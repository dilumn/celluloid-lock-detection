source "https://rubygems.org"

gemspec

#de This duplicate listing alongside the gemspec listing, and yet *after* the gemspec call above
#de is purely to allow the local-override of this gem ( bundle config local.celluloid /path ),
#de for purposes of development... otherwise this can be omitted at time of release:
gem 'celluloid', github: 'celluloid/celluloid', branch: 'master', submodules: true
