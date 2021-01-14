#3)Fichier qui permet de gérer les sessions
Rails.application.config.session_store :cookie_store, key: '_projet_grafikart_session'

#3)cash_store permet de d'utiliser le système de cash pour sauvegarder les sessions. 
#3)active_record_store permet de d'utiliser le système de BDD dirextement.