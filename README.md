# Hashie::LazyTrash

An extended `Hashie::Trash` with the following 2 additional features:

  1. When trying to set a value that is not defined as a property, the LazyTrash just sllently ignores this value
     (as opposed to Hashie::Trash, which raises an Exception)

  2. You can define properties that are to be fetched lazily (on first access), i.e.

        property :user_id
        property :user, :lazy => lambda { User.find(user_id) }

     As you can see in this example, the Proc is executed in the context of the Hashie::LazyTrash instance

## Usage

This gem relies on the yet-unreleased version 2 of the `hashie` gem. Therefore, you must get that dependency using bundler
from github manually for now:

    # Gemfile
    gem 'hashie', :github => 'intridea/hashie'
    gem 'hashie-lazy_trash'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
