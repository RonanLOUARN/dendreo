# Dendreo

Gem pour l'API du CRM dendreo.


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

## Contribution

Bug reports and pull requests are welcome on GitHub at https://github.com/RonanLOUARN/dendreo.

## Licence

Cette gem est opensource.
