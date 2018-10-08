Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#home'
  get '/about', to: 'application#about'
  get '/community', to: 'application#community'
  get '/blog', to: 'application#blog'
  get '/team', to: 'application#team'
  get '/team/:name', to: 'application#member', as: 'member'
end
