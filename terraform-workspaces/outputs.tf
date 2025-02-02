output "workspace_directory_id" {
  description = "The ID of the created Simple AD directory"
  value       = aws_directory_service_directory.workspace_directory.id
}

output "workspace_ip_address" {
  description = "The IP address of the created Amazon WorkSpace"
  value       = aws_workspaces_workspace.example_workspace.ip_address
}