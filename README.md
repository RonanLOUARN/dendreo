# Dendreo

Gem pour l'API du CRM Dendreo.


## Installation

Ajoutez cette ligne à votre Gemfile:

```ruby
gem 'Dendreo'
```

Bien entendu:

    $ bundle

Ou installez la gem vous-même:

    $ gem install dendreo

## Démarrage rapide


Instanciez votre API.

```ruby
  dendreo = Dendreo::API.new('https://pro.dendreo.com/masociété/api', 'MaCleApi')
```
Attention à bien vérifier que votre url à bien ce format:

```ruby
 'https://pro.dendreo.com/masociété/api'
```

## Utilisation:

Je vous invite à bien lire la documentation de l'api ici => https://developers.dendreo.com/

La gem utilise la 'method_missing', il vous suffira donc de récupérer le nom de la resource que vous souhaitez récupérer, ajouter ou modifier.

Exemple:

Il faut donc piocher le nom de la ressource tel quel est dans l'url de la requête API.

- Catégories de module.         => 'categories_module'
- Catégories de produits        => 'categories_produit'
- Modules/Produits              => 'modules'
- Formateurs                    => 'formateurs'
- Entreprises                   => 'entreprises'
- Contacts                      => 'contacts'
- Particuliers                  => 'contacts' avec la variable 'particulier' = 1 sinon ajout d'un contact
- Participants                  => 'participants'
- Etapes                        => 'etapes'
- Centres de formation          => 'centres_de_formation'
- Salles de formation           => 'salles_de_formation'
- Factures                      => 'factures'
- Actions de formation          => 'actions_de_formation'
- Créneaux                      => 'creneaux'
- Inscription d'un participant  => 'laps'
- Programmation d'un module     => 'lams'
- Mails                         => 'emails'


Arguments:

```ruby
# methode http 
{ method: :get }

# toute information qui doit passer par l'url
{ url_data: { id: 123456 } } 

# toute information que vous souhaitez modifier/créer
{ form_data: { email: 'dendreo@test.com' } } 

# exemple d'utilisation
dendreo = Dendreo::API.new('https://pro.dendreo.com/masociété/api', 'MaCleApi') 

dendreo.participants(
  method: :post, 
  url_data: { 
    id_participant: 1345 
  }, 
  form_data: { 
    nom: 'nouveau nom', 
    civilite: 'M.', 
    id_add: 2, 
  }
) 

```

Pour les participants ( GET https://pro.dendreo.com/demo/api/participants.php?)

```ruby
  # Renvoi tous les particpants
  dendreo.participants(method: 'get')

  # Renvoi le particpant qui a l'id en question
  dendreo.participants(method: 'get', url_data: { id_participant: 1345 })

  # Renvoi le ou les particpants qui ont l'email en question
  dendreo.participants(method: 'get', url_data: { email: 'mon_email@gmail.com' })

  #Renvoi le ou les particpants qui ont le commentaire en question
  dendreo.participants(method: 'get', url_data: { search: 'Un nom ou ce que vous souhaitez id, email, commentaires etc..' })
```

Ajouter ou modifier un participant.

Attention, pour modifier un participant déjà existant, il vous suffit de remplacer 'id_participant' par 'id' tout court et d'ajouter un 'id_add' qui contiendra un id d'administrateur.

Faites appel au support dendreo pour plus d'informations, ils sont très réactifs equipe@dendreo.com .

```ruby
  # Créer un participant
  dendreo.participants(method: 'post', form_data: { nom: 'nouveau nom', prenom: 'toto', civilite: 'M.', email: 'toto@gmail.com', id_add: 2 })

  # Modifier un participant existant (Attention, bien remplacer 'id' par 'id_participant' et ajouter un 'id_add' pour
  # s'identifier en admin sur la mise à jour.)
  dendreo.participants(method: 'post', url_data: { id_participant: 1345 }, form_data: { nom: 'nouveau nom', civilite: 'M.', id_add: 2 })

  # Supprimer un participant (attention, il n'y a pas de methode 'delete' sûr tous les endpoints)
  dendreo.participants(method: 'delete', url_data: { id_participant: 1345 })

```

## Contribution

Rapports de bugs et contibutions ici => https://github.com/RonanLOUARN/dendreo.

## Licence

Cette gem est opensource.
