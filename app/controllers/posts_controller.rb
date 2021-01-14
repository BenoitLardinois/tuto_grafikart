class PostsController < ApplicationController
#1) Est lié au Controller, CRUD
#2) ESt lié au Controller, filres
#3) Est lié au Controller, Sessions/cookies
#4) Est lié au Controller, différents formats
#5) Est lié au Models, Validation des données
#6) Est lié au Models, les callbacks

  
  
  
#2)Appeler la méthode (qui est créer en private) et l'avantage c'est les méthodes show, edit, destroy, update, ... n'ont plus besoins de @post = Post.find(params[:id]) et donc permet d'alléger le code
  before_action :set_post, only: [:update, :edit, :show, :destroy]
#2)utiliser un second paramètre qui va appliquer ceci uniquement sur les méthodes que je souhaite
  #skip_before_action :verify_athenticity_token;
  
#2)skip_before_action permet de sauté le :verify_athenticity_token TRÈS DANGEREUX À FAIRE !!! Possibilité de rajouter un second paramètre qui va s'appliquer uniquement sur les méthodes qu'on souhaite
  
  
  
  
  def index
#3)Je peux accceder à la  session en faisant ceci... Et nous pouvons récupéré cette valeur là dans le index du controller
    session[:user_id] = {username: 'Jean', id: 3}
    
#3)Ci dessus permet de flasher uniquement pour la requette actuelle!
    #flash.now[:success] = "Bonjour!"
  
    
    
#3)ci dessous les cookies(!!!value =  string!!!) et on lui demander d'expiré(quand on quitte la page(session)) plus tard que la session grâce à expire.
#Aussi si on veut stocker un objet il faut un JSON comme ceci: value: JSON.generate({name: "Dick"}),
=begin
    cookies[:username] = { 
      value: "Benoît",
      expires: 1.month.from_now
    }
=end
    
#3)Il exsite les cookies signé (qui utilise une sécurité)
    #cookies.signed[:username] = "John"
    
#3)Il exsite les cookies chiffré (impossible de déchiferer dans notre clé privée)
    #cookies.encypted[:username] = "John"
    
#3)Possible de créer un cookie qui reste tout le long de la vie de l'utilisateur, delete permet de supprimé une clé
    #cookies.permanent.signed[:username] = "Dick"
    
#3)Possible de supprimé une clé qui est appliqué directement sur le cookie
    cookies.delete(:username)
    
    @posts = Post.all
    
#4)Méthode pour utiliser les différent formats, nous pouvons écrire ces méthodes dans le model post.rb (http://localhost:3000/posts.json)
    puts "=" * 60
    puts request.format
    respond_to do |format|
      format.html
      format.xml { render xml: @posts }
      format.json do
        render json: @posts#.as_json(only: [:name, :created_at, :id])
      end
#Dans le fichier mime_types.rb un format est enregister pour lire les rtf (http://localhost:3000/posts.rtf)
      format.rtf { render plain: "azazazaza"}
    end
  end
  
  
  
  
  
  
  
  
  def show
#1)Récupérer l'article (Post.find) et demander l'article qui est correspond au params qui passé (params[:id])
    #@post = Post.find(params[:id])
    
#4)Méthode pour utiliser les différent formats
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end
  
  
  
  
  
  
  
  
   
  def edit
#1)Création de la méthode edit
    #@post = Post.find(params[:id])
  end
  
  
  
  
  
  
  
  
  
  
  def update
#1)Récupérer l'article que nous avons modifier(verifier et valider) puis ensuite on applique la méthode update.
    #@post = Post.find(params[:id])
#1)Récupérer les infos pour les modifier
    #puts params.inspect
#1)Il faut A)require = verifier et B)permit = valider les params 
    #1)puts params.require(:post).inspect
    post_params = params.require(:post).permit(:name, :content)
#1)application de la méthode update (les envoyer a la BDD) + (post_params) qui ont été 'permit'.
    
#3)Permet de sauver un message succes dans la session
    #session[:success] = "Article modifier avec succès!"
#3)puis il faut aller dans la vue de application.html.erb
    
#3)Nous pouvons faire la même choses avec un flash
    #flash[:success] = "Article modifié avec succès!"
    
#5)Possibilité de vérifier si notre enregistrement est valable en faisant une condition;
    if @post.update(post_params)
      redirect_to post_path, success: "Article modifié avec succès"
    else
      render 'edit'
    end

    #1)@post.update(post_params)
#1)Puis on redirger vers la page show de l'article que l'on vient de modifer
#3)possiblité de flasher dans redirect
    #redirect_to post_path, notice:(ou success + {success: "Article modifié avec succès!"}) "Article modifié avec succès!"
  end
  
  
  
  
  
  
  
  
  
  
  
  def new
#1)Methode qui permet de créer un nouveau article (Article Post n'est pas persisté au niveau de la BDD)
    @post = Post.new
  end
  
  
  
  
  
  
  
  
  
  
  def create
#1)réation de son enregistrement MAIS pour cela il faut créer une methode (qui seras privée) et qui vas faire précisément ceci: post_params = params.require(:post).permit(:name, :content) 
    post = Post.new(the_method_post_params)
#1)Rediriger vers la page de consultation de l'article!
#5)Permet de créer
    if post.valid?
      post.save
      redirect_to post_path(post.id), success: "Article créer avec succès!"
    else
      @post = post
      render 'new'
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  def destroy
#1)Récupérer l'article qu'on veut supprimer  
    #@post = Post.find(params[:id])
#1)Puis on le détruit
    @post.destroy
#1)Puis on le redirige vers la page index
    redirect_to posts_path, success: "Article supprimé avec succès!"
  end
end










private


def the_method_post_params
#1)Au lieu de créer à chaque fois une variable @post_params, cette méthode appelle params avec un require avec les articles et un permit qui autorise le nom et content
#6) rajout de :slug
  params.require(:post).permit(:name, :content, :slug)
end





#2)
def set_post
  @post = Post.find(params[:id])
end