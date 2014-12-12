#!/bin/bash

if [ ! -a  /etc/apt/sources.list.d/puppetlabs.list ]; then
  PUPPETLABS_RELEASE_DEB=puppetlabs-release-$(lsb_release --codename --short).deb
  wget http://apt.puppetlabs.com/$PUPPETLABS_RELEASE_DEB --no-verbose --timestamping  \
    || { echo 'Could not download Debian package from puppetlabs.'; exit 1; }
  dpkg --install $PUPPETLABS_RELEASE_DEB
  apt-get update
fi

apt-get install --assume-yes puppet ruby-dev rake build-essential
gem install bundler

if [ -a /etc/puppet/modules/firewall ]; then
  rm -rf /etc/puppet/modules/firewall
fi
ln --symbolic /vagrant /etc/puppet/modules/firewall

#rsync -av /vagrant/ ~/firewall/ && cd ~/firewall/ && rake spec
