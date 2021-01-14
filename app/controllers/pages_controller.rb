class PagesController < ApplicationController
  
  def salut
#Va afficher le nom dans le terminal
    #puts params[:name].inspect
#va créer une variable et acceder à cette variable depuis sa vue.
    @name = params[:name]
  end
  
  def home
  end
end