Rails.application.routes.draw do

  root 'films#index'
  post '/', to: 'films#index'

   #navigations for static pages
   get 'about', to: 'films#about'
   get 'contact', to: 'films#contactUs'
   get 'admin_index', to: 'admins#index'

   #search routes
   post '/search', to: 'latests#search'
   get '/search', to: 'latests#index'
 
  #navigation for paginated music page
  post '/musics_index', to: 'musics#index'
  get '/musics_index', to: 'musics#index'
  
  
  #navigation for paginated video page
  post '/videos_index', to: 'videos#index'
  get '/videos_index', to: 'videos#index'

  #navigation for paginated news page
  post '/news_index', to: 'news#index'
  get '/news_index', to: 'news#index'

 

  #routes for downloads
  post '/video_download', to: 'videos#download'
  post '/music_download', to: 'musics#download'

  #routes for authentication
  post '/auth', to: 'artists#auth'
  
  resources :musics, :videos, :news, :artists

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
