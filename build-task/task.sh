#!/bin/bash

set -ex

apt-get update -y
apt-get install zip sqlite3 libsqlite3-dev -y

cd bookshelf-api/web_app

pip install -r requirements.txt

export FLASK_APP=./app.py
export FLASK_DEBUG=1
export FLASK_RUN_PORT=3000
export DATABASE_URL="postgresql://localhost:5432/librarian?user=postgres&password=postgres"

flask test

#cd react_app
#
#yarn global add create-react-app
#yarn
#CI="true" yarn test
#
#yarn build
#
#rm -rf node_modules
#rm .gitignore
#
#cd ..
#
#cd react_app_2/front_end
#yarn
#CI="true" yarn test
#
#yarn build
#
#rm -rf node_modules
#
#cd ../..

cd ..

cp -rf ../resource-gist-dev/.git ../updated-gist/.git

cd web_app

zip -r ../../bookshelf-api.zip .

cd ../..

mv bookshelf-api.zip updated-gist

cd updated-gist

git config --global user.email "concourse@example.com"
git config --global user.name "Concourse"

git add .
git commit -m "New Build"
