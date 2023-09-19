### Application for Migrating images from Legacy to Production

## Pre-req

- AWS account
- terraform installed locally 
- execute seeder.py with AWS and postgres credentials to populate some test data
- IAM role for Lambda function to execute migrate operation 


## Deploy Infrastructure

- git clone https://github.com/parvez99/migrateimages
- Open your terminal and run:
```bash
export AWS_ACCESS_KEY_ID="your aws access key"
export AWS_SECRET_ACCESS_KEY="your aws secret key"
export AWS_DEFAULT_REGION="aws region you wish to deploy the cluster to"
```
- terraform plan to verify all the resources being created
- terraform apply with yes option

## Deploy application 

# Lambda function should be deployed as part fo the infrastructure setup that
  - Pull the docker image from https://hub.docker.com/repository/docker/parvezmulani/migrateimages/general
  - Runs the application to migrate images from legacy-s3 to production-s3
  - Exits on completion

