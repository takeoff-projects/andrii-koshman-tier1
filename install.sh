#!/usr/bin/env bash

export GOOGLE_CLOUD_PROJECT=roi-takeoff-user17

gcloud builds submit --tag=gcr.io/$GOOGLE_CLOUD_PROJECT/go-pets/go-pets-image .  --project $GOOGLE_CLOUD_PROJECT

(cd terraform && terraform init && terraform apply -auto-approve)