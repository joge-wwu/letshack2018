class UploadController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    filename = params[:name] + '.jpg'
    send_data File.read(Rails.root.join('uploads', filename), mode: 'rb'), filename: filename, type: 'image/jpeg', disposition: 'inline'
  end

  def create
    filename = params[:name] + '.jpg'
    File.open(Rails.root.join('uploads', filename), 'wb') { |f| f.write(Base64.decode64(params[:content].delete("\n").tr(' ', '+'))) }
  end

  def check_mock
    error = Math.random >= 0.5
    render nothing: true, status: error ? 415 : 200
  end
end