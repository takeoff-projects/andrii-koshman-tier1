#!/usr/bin/env bash

#gcloud builds submit --tag=gcr.io/$GOOGLE_CLOUD_PROJECT/go-pets/go-pets-image .  --project $GOOGLE_CLOUD_PROJECT
bucket="roi-takeoff-user17-terraform-state"
(cd terraform &&
terraform init -reconfigure <<< $bucket &&
terraform apply -auto-approve)