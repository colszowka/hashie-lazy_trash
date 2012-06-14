require "hashie-lazy_trash/version"
require 'hashie'

#
# A Hashie::Trash with 2 main differences:
#
#   1. When trying to set a value that is not defined as a property, the LazyTrash just sllently ignores this value
#      (as opposed to Hashie::Trash, which raises an Exception)
#   2. You can define properties that are to be fetched lazily (on first access), i.e.
#
#        property :user_id
#        property :user, lazy: ->{ User.find(user_id) }
#
#      As you can see in this example, the Proc is executed in the context of the Hashie::LazyTrash instance.
#
class Hashie::LazyTrash < Hashie::Trash
  def self.property(property_name, options = {})
    super

    if options[:lazy]
      lazy_properties[property_name.to_sym] = options[:lazy]
    end
  end

  def [](property)
    if !super and self.class.lazy_properties.include?(property.to_sym)
      self[property.to_sym] = instance_exec(&self.class.lazy_properties[property.to_sym])
    else
      super
    end
  end

  private

  def self.lazy_properties
    @lazy_properties ||= {}
  end

  # If the property does not exist, just returns false and therefore denies setting a value to it
  def property_exists?(property)
    self.class.property?(property.to_sym)
  end
end