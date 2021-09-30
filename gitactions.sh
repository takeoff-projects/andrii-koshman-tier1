#!/usr/bin/env bash

export OOGLE_APPLICATION_CREDENTIALS = ${{ secrets.GOOGLE_APPLICATION_CREDENTIALS }}
gcloud builds submit --tag=gcr.io/${{ secrets.GOOGLE_CLOUD_PROJECT }}/go-pets/go-pets-image .  --project ${{ secrets.GOOGLE_CLOUD_PROJECT }}

(cd terraform &&
terraform init  -backend-config="bucket=roi-takeoff-user17-terraform-state" &&
terraform apply -auto-approve)