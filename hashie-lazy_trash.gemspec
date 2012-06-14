# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hashie-lazy_trash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christoph Olszowka"]
  gem.email         = ["christoph at olszowka.de"]
  gem.description   = %q{An extended version of Hashie::Trash}
  gem.summary       = %q{An extended version of Hashie::Trash}
  gem.homepage      = "https://github.com/colszowka/hashie-lazy_trash"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hashie-lazy_trash"
  gem.require_paths = ["lib"]
  gem.version       = HashieLazyTrashVersion
end
