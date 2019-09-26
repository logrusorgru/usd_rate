Rails.application.routes.draw do

  root to: 'rates#show'

  get '/admin', to: 'rates#edit'
  patch '/admin', to: 'rates#update'

end
