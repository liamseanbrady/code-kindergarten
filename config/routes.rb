Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'report_cards#index'
  get '/register', to: 'users#new'
end
