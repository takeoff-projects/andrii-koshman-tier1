#!/usr/bin/env bash

export GOOGLE_CLOUD_PROJECT=roi-takeoff-user17

timestamp=$(date +%s)

gcloud builds submit --tag=gcr.io/$GOOGLE_CLOUD_PROJECT/go-pets:v1.$timestamp .  --project $GOOGLE_CLOUD_PROJECT

(cd terraform && terraform init && terraform apply -auto-approve -var="app_version=v1.$timestamp")