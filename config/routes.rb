Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/update'
  get 'categories/destroy'
  get 'categories/new'
  get 'categories/edit'
 #Route racine ou nous allons lui dire ce qu'elle doit faire quand elle est à la racine.
  root to: 'pages#home'

# (/:name) = paramètre optionnelle 
  get '/welcome(/:name)', to: 'pages#salut', as: 'salut' 
# as: 'salut' = cette route là je vais l'appeler salut grâce _path (regade dans application.html.erb)
#En gros lorsque j'appelle l'url get '/welcome(/:name)' j'aurrai cette action to: 'pages#salut' et nous donnons un nom aux routes as: 'salut'. Les routes pointes vers les action dans le fichier controller

  resources :posts
  
  resources :categories
  
end
