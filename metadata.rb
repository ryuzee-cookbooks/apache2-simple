name             'apache2-simple'
maintainer       'Ryutaro YOSHIBA'
maintainer_email 'ryuzee@gmail.com'
license          'MIT'
description      'Installs/Configures apache2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          "yum"

%w{redhat centos scientific fedora amazon ubuntu}.each do |os|
    supports os
end
