#!/bin/bash

echo "setting env vars for document_verification_api launch"
echo "running as $(whoami)"

SECRET_KEY_BASE=1a0dedf26783f37253fc66b6d2cd833591148bda9d3d6807355180e5ca99a431531a15a4327f409293b0a08a41f078223967d59a318866d63755e65dac2ab673
POSTGRESQL_PORT=5434
POSTGRESQL_USER=postgres
POSTGRESQL_PASSWORD=pgp4ss
RAILS_ENV=production
RAILS_PORT=3002

export SECRET_KEY_BASE
export POSTGRESQL_PORT
export POSTGRESQL_USER
export POSTGRESQL_PASSWORD
export RAILS_ENV
export RAILS_PORT

echo "starting document_verification_api"

cd /home/abre/document_verification_api/docker-compose.yml

docker-compose down
docker-compose up -d

echo "document_verification_api started"
