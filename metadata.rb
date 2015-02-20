name 'accounts'
maintainer 'Sander van Zoest'
maintainer_email 'sander@vanzoest.com'
license 'Apache 2.0'
description 'System Accounts management'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.1'
replaces 'sudo'
conflicts 'sudo'
%w(redhat centos debian ubuntu).each do |os|
  supports os
end
