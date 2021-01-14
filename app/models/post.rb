class Post < ApplicationRecord
  
#4)Nous passons uniquement les params que l'on veut
  def as_json(options=nil)
    super(only: [:name, :id, :created_at])
  end
  
#5) La méthode validates
  #validates :name, presence: { message: "Ne doit pas être vide."}
#ci dessous nous faisant la validations uniquement lors de la création du contenu. (regarde dans le controller create)
  #validates :name, length: { is: 5}, on: :create
  
#6)Lorsque l'article est modifié, automatiquement si le champ 'URL de l'article'(slug) n'est pas rempli il se rempli à partir du champ 'Titre de l'article'(name) et ce avant de valider les données
  before_validation :default_slug
  
  private
   
#6)On déclare cette méthode (:default_slug) ici en privée. 'self' prend l'enregistrement court puis on définit sont slug 'self.slug' et le slug sera 'name' grâce au if qui ne fonctionne pas! (si on a le name qui est pas vide et le slug est pas vide).
#Mais pour que ça fonctionne il faut retirer les règles de validations ci dessus #5
  def default_slug
    #if !self.name.empty? && self.slug.empty?
      self.slug = name.parameterize#(permet de remplir (si le champ est vide) le champ url de l'article avec par dafaut '-')
    #end
  end
  
end