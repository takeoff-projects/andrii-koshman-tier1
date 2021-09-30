#!/usr/bin/env bash

gcloud builds submit --tag=gcr.io/$GOOGLE_CLOUD_PROJECT/go-pets/go-pets-image .  --project $GOOGLE_CLOUD_PROJECT

(cd terraform && terraform init && terraform apply -auto-approve)