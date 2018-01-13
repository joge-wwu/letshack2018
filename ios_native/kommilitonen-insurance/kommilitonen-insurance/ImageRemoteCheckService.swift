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
    
    
    class func checkImage(image: UIImage, imageTypeId: String, completion: @escaping (_ result: Bool)->()) {
       
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        
        let uploadUrlString = "http://einmbp.local:3000/upload/" + imageTypeId
        let uploadUrl = URL(string: uploadUrlString)
        
        var postRequest = URLRequest.init(url: uploadUrl!)
        postRequest.httpMethod = "POST"
        
        let strBase64:String = (imageData?.base64EncodedString(options: .init(rawValue: 0)))!
        let postStr = "content="+strBase64
        postRequest.httpBody = postStr.data(using: String.Encoding.utf8);
        
        
        let uploadSession = URLSession.shared
        let executePostRequest = uploadSession.dataTask(with: postRequest as URLRequest) { (data, response, error) -> Void in
            if let response = response as? HTTPURLResponse
            {
                print(response.statusCode)
                if response.statusCode == 200 {
                    completion(true)
                    return
                }
                completion(false)
                return
                
            }
            if let data = data
            {
                let json = String(data: data, encoding: String.Encoding.utf8)
                print("Response data: \(String(describing: json))")
            }
        }
        executePostRequest.resume()
        
    }
    
}
