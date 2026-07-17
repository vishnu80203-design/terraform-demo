# 1. The Core VPC Network Boundary
resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "Jenkins-AWS-VPC"
    Project = "Jenkins-Test"
  }
}

# 2. Public Subnet within the VPC (Zone A)
resource "aws_subnet" "jenkins_public_subnet" {
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true # Natively injects public IPs to resources launched here

  tags = {
    Name    = "Jenkins-Public-Subnet-1A"
    Project = "Jenkins-Test"
  }
}

# 3. Internet Gateway for Public Route Management
resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name    = "Jenkins-Internet-Gateway"
    Project = "Jenkins-Test"
  }
}

# 4. Route Table Mapping Traffic to the Internet Gateway
resource "aws_route_table" "jenkins_public_rt" {
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # Routes all non-VPC traffic to the internet
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }

  tags = {
    Name    = "Jenkins-Public-RouteTable"
    Project = "Jenkins-Test"
  }
}

# 5. Route Table Association (Binding Subnet to Route Table)
resource "aws_route_table_association" "jenkins_public_assoc" {
  subnet_id      = aws_subnet.jenkins_public_subnet.id
  route_table_id = aws_route_table.jenkins_public_rt.id
}

# 6. Security Group (Stateful Firewall Rule)
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-test-security-group"
  description = "Allow inbound SSH and HTTP traffic for testing"
  vpc_id      = aws_vpc.jenkins_vpc.id

  # Inbound Rule: SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all IPs. Restrict to your home IP in production.
  }

  # Inbound Rule: HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow all egress traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Matches all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Jenkins-Security-Group"
    Project = "Jenkins-Test"
  }
}

# 7. Dynamic AWS Resource Group to Aggregate All Components
resource "aws_resourcegroups_group" "jenkins_group" {
  name = "Jenkins-Mumbai-Resource-Group"

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = [
        {
          Key    = "Project"
          Values = ["Jenkins-Test"]
{
                  Key    = "Project"
                  Values = ["Jenkins-Test"]
                }
              ]
            })
          }
        }

# 8. S3 Bucket for Small Storage
resource "aws_s3_bucket" "jenkins_storage_bucket" {
  bucket = "vishnu-jenkins-storage-80203" # This must be globally unique
  
  tags = {
    Name    = "Jenkins-Storage-Bucket"
    Project = "Jenkins-Test"
  }
}
