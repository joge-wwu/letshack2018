//
//  ImageRemoteCheckService.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class ImageRemoteCheckService  {
    
    
    class func checkImageJson(image: UIImage, imageTypeId: String, completion: @escaping (_ result: Bool)->()) {
        
        let imageData = UIImageJPEGRepresentation(image, 0.6)
        
        let uploadUrlString = "http://192.168.0.126:5002/classifier"
        let uploadUrl = URL(string: uploadUrlString)
        
        var postRequest = URLRequest.init(url: uploadUrl!)
        postRequest.httpMethod = "POST"
        
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let strBase64:String = (imageData?.base64EncodedString(options: .init(rawValue: 0)))!

        let parameters = ["image": strBase64, "imageTypeId": imageTypeId]
        
        do {
            postRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5.0
        sessionConfig.timeoutIntervalForResource = 5.0
        
        
        let uploadSession = URLSession(configuration: sessionConfig)
        let executePostRequest = uploadSession.dataTask(with: postRequest as URLRequest) { (data, response, error) -> Void in
            
            if let response = response as? HTTPURLResponse
            {
                print(response.statusCode)
                if response.statusCode >= 200 && response.statusCode < 400 {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
                else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            
            
            //            if let data = data
            //            {
            //                let json = String(data: data, encoding: String.Encoding.utf8)
            //                print("Response data: \(String(describing: json))")
            //            }
        }
        executePostRequest.resume()
        
    }
    
    
    class func uploadImage(image: UIImage, imageTypeId: String, completion: @escaping (_ result: Bool)->()) {
       
        let imageData = UIImageJPEGRepresentation(image, 0.6)
        
        let uploadUrlString = "http://einmbp.local:3000/upload/" + imageTypeId
        let uploadUrl = URL(string: uploadUrlString)
        
        var postRequest = URLRequest.init(url: uploadUrl!)
        postRequest.httpMethod = "POST"
        
        let strBase64:String = (imageData?.base64EncodedString(options: .init(rawValue: 0)))!
        let postStr = "content="+strBase64
        postRequest.httpBody = postStr.data(using: String.Encoding.utf8);
        
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5.0
        sessionConfig.timeoutIntervalForResource = 5.0
        
        let uploadSession = URLSession(configuration: sessionConfig)
        let executePostRequest = uploadSession.dataTask(with: postRequest as URLRequest) { (data, response, error) -> Void in
            if let response = response as? HTTPURLResponse
            {
                print(response.statusCode)
                if response.statusCode == 204 {
                    completion(true)
                    return
                }
                completion(false)
                return
                
            }
            
            completion(false)
            return
            
//            if let data = data
//            {
//                let json = String(data: data, encoding: String.Encoding.utf8)
//                print("Response data: \(String(describing: json))")
//            }
        }
        executePostRequest.resume()
        
    }
    
}
