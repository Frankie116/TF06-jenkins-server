terraform {
    backend "s3" {
        bucket         = "my-tf-backend"
        key            = "my-state.tfstate"   
        region         = "eu-west-2"         # Note: DynamoDB table needs to be created in
        dynamodb_table = "my-s3-statelock"   # specific region with LockID as primary key
    }
}