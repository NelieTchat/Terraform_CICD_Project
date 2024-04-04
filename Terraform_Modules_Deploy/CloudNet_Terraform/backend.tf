# Configure the backend to store the state file in the S3 bucket
terraform {
  backend "s3" {
    bucket         = "tfstate-cloudnet-project"
    key            = "terraform.tfstate"
<<<<<<< HEAD
    region         = "us-east-1"            # Replace with your AWS region
    dynamodb_table = "terraform-lock-table" # Optional: Specify an existing DynamoDB table for state locking
    encrypt        = true
    # Optional: Enable encryption for the state file
=======
    region         = "us-east-1"  # Replace with your AWS region
    dynamodb_table = "terraform-lock-table"  # Optional: Specify an existing DynamoDB table for state locking
    encrypt        = true 
                # Optional: Enable encryption for the state file
>>>>>>> 6fc70ed423ad9265eec9df1092eec5a0f3de8117
  }
}