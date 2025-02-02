# Create a Simple AD Directory for Amazon WorkSpaces
resource "aws_directory_service_directory" "workspace_directory" {
  name     = "corp.example.com"
  password = "SuperSecretPassword123!" # Ensure this meets the password policy
  size     = "Small"

  vpc_settings {
    vpc_id     = "vpc-0a1b2c3d4e5f6g7h8"                                  # Replace with your actual VPC ID
    subnet_ids = ["subnet-0a1b2c3d4e5f6g7h8", "subnet-0a1b2c3d4e5f6g7i9"] # Replace with your actual subnet IDs
  }

  tags = {
    Name = "WorkspacesDirectory"
  }
}

# Create a Security Group for Amazon WorkSpaces
resource "aws_security_group" "workspace_sg" {
  name        = "workspaces-sg"
  description = "Security group for Amazon WorkSpaces"
  vpc_id      = "vpc-0a1b2c3d4e5f6g7h8" # Replace with your actual VPC ID

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WorkspacesSG"
  }
}

# Create an Amazon WorkSpace
resource "aws_workspaces_workspace" "example_workspace" {
  directory_id = aws_directory_service_directory.workspace_directory.id
  bundle_id    = "wsb-bh8rsxt14" # Replace with the desired bundle ID (e.g., Value with Windows 10)
  user_name    = "admin"         # User that will access the workspace

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = "alias/aws/workspaces"

  workspace_properties {
    compute_type_name                         = "VALUE" # Options: VALUE, STANDARD, PERFORMANCE, POWER, GRAPHICS, GRAPHICS_PRO
    user_volume_size_gib                      = 50
    root_volume_size_gib                      = 80
    running_mode                              = "AUTO_STOP" # Options: AUTO_STOP, ALWAYS_ON
    running_mode_auto_stop_timeout_in_minutes = 60
  }

  tags = {
    Name = "ExampleWorkspace"
  }
}