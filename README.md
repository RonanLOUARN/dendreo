# Dendreo

Gem pour l'API du CRM Dendreo.


## Installation

Ajoutez cette à votre Gemfile:

```ruby
gem 'dendreo'
```

Bien entendu:

    $ bundle

Ou installez le gem vous-même:

    $ gem install dendreo

## Démarrage rapide


Instanciez votre API.

```ruby
  dendreo = Dendreo::API.new("https://pro.dendreo.com/masociété/api", "MaCleApi")
```
Attention à bien vérifier que votre url à bien ce format:

```ruby
 'https://pro.dendreo.com/masociété/api'
```

## Utilisation:

Je vous invite à bien lire la documentation de l'api ici => https://developers.dendreo.com/

La gem utilise la "method_missing", il vous suffira donc de récupérer le nom de la resource que vous souhaitez récupérer, ajouter ou modifier (hé oui c'est possible!).

Exemple:

Il faut donc piocher le nom de la ressource tel quel est dans l'url de la requête API.

Pour les participants ( GET https://pro.dendreo.com/demo/api/participants.php?)

```ruby
  # Renvoi tous les particpants
  dendreo.participants(method: "get")

  # Renvoi le particpant qui a l'id en question
  dendreo.participants(method: "get", datas: {id_participant: 1345})

  # Renvoi le ou les particpants qui ont l'email en question
  dendreo.participants(method: "get", datas: {email: "mon_email@gmail.com"})

  #Renvoi le ou les particpants qui ont le commentaire en question
  dendreo.participants(method: "get", datas: {search: "Un joli nom ou ce que vous souhaitez id, email, commentaires etc.."})
```

Ajouter ou modifier un participant.

Attention, pour modifier un participant déjà existant, il vous suffit de remplacer "id_participant" par "id" tout court et d'ajouter un "id_add" qui contiendra un id d'administrateur.

Je porte votre attention sur le fait que si vous modifiez un utilisateur il faudra re-rentrer la totalité des données, même si elles étaient déjà existantes auparavant, sinon il ne les gardera pas. Vous pouvez donc utiliser la méthode get avec l'id en question pour récupérer les informations avant de faire vôtre modification.

L'API est faite comme cela, je n'y peut rien. Ceci n'est pas encore spécifié dans la documentation.
Faites appel au support dendreo pour plus d'informations, ils sont très réactifs equipe@dendreo.com .

```ruby
  # Créer un participant
  dendreo.participants(method: "post", datas: {nom: "nouveau nom", prenom: "toto", civilite: "M.", email: "toto@gmail.com", id_add: 2})

  # Modifier un participant existant
  dendreo.participants(method: "post", datas: {id: 1345, nom: "nouveau nom", civilite: "M.", id_add: 2})

```
Cet exemple fonctionne sur toutes les ressources sauf les "particuliers" que l'on peut créer mais pas modifier.


## Contribution

Bug reports and pull requests are welcome on GitHub at https://github.com/RonanLOUARN/dendreo.

## Licence

Cette gem est opensource.
