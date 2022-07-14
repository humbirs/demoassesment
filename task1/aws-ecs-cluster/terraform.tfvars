aws_region        = "us-east-1"
aws_access_key    = "update-with-access-key"
aws_secret_key    = "Update-with-Secret"
aws_key_pair_name = "key-pair-name"

availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

app_name        = "nginx"
app_environment = "demotest"
image_name_url        = "docker.io/library/nginx:latest"

