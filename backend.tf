terraform {
  backend "s3" {
    bucket = "share-hub-asset-bucket"
    region = "eu-west-1"
    key = "jenkins-server/terraform.tfstate"
  }
}