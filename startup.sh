#/bin/bash

cd /opt/
git clone git://github.com/facebook/libphutil.git
git clone git://github.com/facebook/arcanist.git
git clone git://github.com/facebook/phabricator.git
cd /opt/phabricator && ./bin/storage upgrade --force
