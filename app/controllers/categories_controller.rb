class CategoriesController < ApplicationController
#1) Est lié au Controller, CRUD
#2) ESt lié au Controller, filres
#3) Est lié au Controller, Sessions/cookies
#4) Est lié au Controller, différents formats
#5) Est lié au Models, Validation des données
#6) Est lié au Models, les callbacks

  
  
  
#2)Ce code sera efectué avant les méthodes index, show, ... grâce au filtre (il y en a différentes sortes) before_action (on peut vérifier dans le terminal)
  before_action do |controller|
    puts "$" * 60
    puts "Je suis avant l'action"
    puts "$" * 60
  end
  
  after_action do |controller|
    puts "$" * 60
    puts "Je suis après l'action"
    puts "$" * 60
  end
  
  def index
#3)Nous pouvons l'afficher dans la catégorie de la vue index.
    @session = session[:user_id]
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(the_method_category_params)
    redirect_to category_path(@category.id)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(the_method_category_params)
    redirect_to category_path(@category.id)
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  private
  
  def the_method_category_params
    params.require(:category).permit(:name, :slug)
  end
  
#2)Permet d'entourer une action (yield)et prend le nom d'une méthode (sous forme d'atome). Mais il est rare d'utilisation
  around_action :around

  def around
    puts "€" * 60
    yield
    puts "€" * 60
  end
end