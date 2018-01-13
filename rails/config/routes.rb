Rails.application.routes.draw do
  root to: 'static#start'
  get '/detail', to: 'static#detail'
  get '/upload/:name', to: 'upload#show'
  post '/upload/:name', to: 'upload#create'
  post '/check/:name', to: 'upload#check_mock'
end
