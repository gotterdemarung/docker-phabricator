#/bin/bash

sudo docker run -i -d -p 3306:3306 -p 8081:80 -p 2244:22 gotterdemarung/phabricator
