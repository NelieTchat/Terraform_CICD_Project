# Configure the backend to store the state file in the S3 bucket
terraform {
  backend "s3" {
    bucket         = "tfstate-cloudnet-project"
    key            = "terraform.tfstate"
    region         = "us-east-1"  # Replace with your AWS region
    dynamodb_table = "terraform-lock-table"  # Optional: Specify an existing DynamoDB table for state locking
    encrypt        = true 
                # Optional: Enable encryption for the state file
  }
}