source "https://rubygems.org"

gemspec

#de Thse duplicate listings alongside the gemspec listings, and yet *after* the gemspec call above
#de are purely to allow the local-override of these gems ( bundle config local.celluloid /path ),
#de for purposes of development alongside... otherwise this can be omitted at time of release:
gem 'celluloid', github: 'celluloid/celluloid', branch: 'master', submodules: true
gem 'celluloid-manager', github: 'celluloid/celluloid-manager', branch: 'master'

group :test do
  gem 'rake'
  gem 'rspec', '~> 3.2'
end
