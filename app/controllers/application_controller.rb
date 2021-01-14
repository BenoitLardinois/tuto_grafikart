class ApplicationController < ActionController::Base
#2)Permet d'injecter un before_action + append_after_action qui sont appliqué avec un authenticity_token
  protect_from_forgery with: :exception
  
#3)Permet de rajouter à toute notre application un :success et un type danger
  add_flash_types :success, :danger
  
end

