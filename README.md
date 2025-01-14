
# AWS Infrastructure Automation Using Terraform

This repository contains a Terraform configuration which : 

- Automated the deployment of cloud infrastructure on AWS using Terraform, including EC2 instances, S3 buckets, and IAM roles.  
- Used Infrastructure as Code (IaC) to ensure scalability and repeatability of resources.  
- Configured outputs to display the public IP of the EC2 instance and the bucket name, reducing manual effort.  
- Followed best practices by parameterizing variables and modularizing code. 
<br>

## Features
- **EC2 Instance**: Launches a virtual machine (t2.micro) with a specified Amazon Machine Image (AMI).
- **S3 Bucket**: Creates a bucket to store files, logs, or backups.
- **IAM Policy**: Grants access to the S3 bucket for specific actions (e.g., `s3:GetObject`).

<br>

## What This Project Can Do
With these resources, one can:

- Host a simple web application on the EC2 instance.
- Use the S3 bucket for static website hosting or as a backend for storage.
- Securely connect the EC2 instance to AWS resources via the IAM role.

<br>

## Prerequisites
- **Terraform**: Install the latest version from [Terraform's official website](https://www.terraform.io/downloads.html).
- **AWS CLI**: Install and configure the AWS CLI with your credentials.
- **AWS Account**: Ensure you have access to an AWS account.
- **Environment Variables**: AWS credentials must be set in the environment.

<br>

## File Structure
```plaintext
.
├── main.tf        # Defines the AWS resources (EC2, S3, IAM)
├── provider.tf    # Configures AWS provider
├── variables.tf   # Declares input variables
├── output.tf      # Outputs key resource details
└── .env           # Stores AWS credentials (optional, must be loaded manually)
```



## Step-by-Step Setup
- Clone this Repository and then write `cd cloud-setup` on your command line.

### 1. Configure `.env` File (Optional)
Create a `.env` file in the project root with the following format:

```plaintext
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
```

To load the `.env` file in Windows, use PowerShell:

```powershell
Get-Content .env | ForEach-Object {
    $name, $value = $_ -split '='
    [System.Environment]::SetEnvironmentVariable($name, $value, [System.EnvironmentVariableTarget]::Process)
}
```

Or set them globally:

```powershell
[System.Environment]::SetEnvironmentVariable("AWS_ACCESS_KEY_ID", "your_access_key", "Machine")
[System.Environment]::SetEnvironmentVariable("AWS_SECRET_ACCESS_KEY", "your_secret_key", "Machine")
[System.Environment]::SetEnvironmentVariable("AWS_REGION", "us-east-1", "Machine")
```

### 2. Initialize Terraform
Run the following command to initialize Terraform:

```powershell
terraform init
```

### 3. Validate the Configuration
Validate the configuration files to ensure they are correct:

```powershell
terraform validate
```

### 4. Plan the Infrastructure
View the planned infrastructure changes:

```powershell
terraform plan
```

### 5. Apply the Configuration
Provision the resources in AWS:

```powershell
terraform apply
```

### 6. Output Details
After applying, Terraform will output useful information, such as:
- EC2 instance public IP
- S3 bucket name

<br>

## Troubleshooting

### **Error: Reference to undeclared resource**
This occurs if resource names in your configuration are inconsistent. Ensure all resource references match their declaration in `main.tf`.

### **Credentials Not Found**
Terraform relies on environment variables for AWS credentials. Ensure the environment variables are correctly set and loaded. Verify with:

```powershell
Get-Content env:A | Select-String AWS
```

If credentials are missing, reconfigure your `.env` file or set them using PowerShell.

If the `Credentials Not Found` is still persists, [Refer here](https://www.youtube.com/watch?v=MIE5KahKTqk).

## Resources
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Setting Environment Variables in Windows](https://learn.microsoft.com/en-us/powershell/scripting/samples/sample-scripts-for-managing-environment-variables?view=powershell-7.2)

