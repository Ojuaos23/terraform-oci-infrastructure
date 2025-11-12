Project 3: Infrastructure-as-Code with Terraform
Automated deployment of cloud networking infrastructure on Oracle Cloud using Terraform.
🎯 Project Overview
This project demonstrates Infrastructure-as-Code (IaC) principles by automating the deployment of a complete cloud environment including networking, security, and compute resources.
🏗️ Infrastructure Components

Virtual Cloud Network (VCN) - 10.0.0.0/16 CIDR block
Public Subnet - 10.0.1.0/24
Internet Gateway - Public internet access
Route Table - Traffic routing configuration
Security List - Firewall rules (SSH, HTTP)
Compute Instance - VM.Standard.E2.1.Micro (Always Free)

🛠️ Technologies Used

Terraform v1.6.5 - Infrastructure-as-Code tool
Oracle Cloud Infrastructure (OCI) - Cloud provider
OCI Provider - Terraform OCI integration
Oracle Linux 8 - Operating system

📁 Project Structure
project3-terraform/
├── provider.tf          # OCI provider configuration
├── variables.tf         # Variable definitions
├── terraform.tfvars     # Actual variable values (not in repo)
├── network.tf           # VCN, subnet, security configuration
├── compute.tf           # Compute instance configuration
├── outputs.tf           # Output values after deployment
├── ssh-key              # SSH private key (not in repo)
├── ssh-key.pub          # SSH public key
├── screenshots/         # Documentation screenshots
└── README.md            # This file
🚀 Deployment Process
Prerequisites

Terraform installed (v1.6+)
OCI account with API keys configured
OCI compartment OCID

Commands
bash# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply

# Destroy infrastructure (when done)
terraform destroy
📸 Project Screenshots
Terraform Configuration Files
Show Image
Project structure in VS Code showing all Terraform configuration files
Show Image
Example of Terraform HCL code for network configuration
Deployment Process
Show Image
Terraform initialization and provider download
Show Image
Infrastructure plan showing resources to be created
Successful Resource Creation
Show Image
Show Image
Show Image
Terraform successfully creating networking infrastructure
Compute Instance Challenge
Show Image
404 authorization error when attempting to deploy compute instance
OCI Console - Deployed Infrastructure
Show Image
Virtual Cloud Network created in OCI Console
Show Image
VCN details showing CIDR block and components
Show Image
Public subnet configuration
Show Image
Security list with SSH and HTTP ingress rules
Compartment Structure
Show Image
OCI compartment hierarchy showing root and child compartments
Show Image
Child compartment created for resource isolation
IAM Policies
Show Image
List of IAM policies including tenancy, compute, and compartment policies
Show Image
Tenancy-level policy allowing Terraform to manage compute resources
Show Image
Compartment-specific policy for isolated resource management
✅ Successfully Deployed Resources

VCN - Created with 10.0.0.0/16 CIDR block
Internet Gateway - Configured for public internet access
Security List - Ingress rules for SSH (22) and HTTP (80)
Route Table - Routes configured for internet gateway
Public Subnet - 10.0.1.0/24 with public IP assignment

🔧 Troubleshooting & Problem-Solving
Encountered OCI free tier limitations when attempting to deploy compute instances. Implemented multiple troubleshooting strategies to isolate and resolve the issue.
Challenge: 404-NotAuthorizedOrNotFound Error
The compute instance failed to launch with authorization errors despite proper Terraform configuration.
Solutions Attempted:
1. Created Child Compartment

Initially used tenancy OCID as compartment OCID
Created dedicated child compartment: ocid1.compartment.oc1..aaaaaaaagnbdrx33zxnwnrrk4i4b3faumiglzlqv4644eezupvidn54lcxjq
Updated Terraform configuration to use isolated child compartment
Tested deployment in new compartment structure
Result: Issue persisted

2. IAM Policy Configuration

Existing Tenancy Policy: Reviewed default tenancy-level policy created with OCI account
Created policy: allow-terraform-compute to allow Terraform to manage compute instances at tenancy level
Created policy: terraform-child-compartment-policy for compartment-specific resource management with explicit compute permissions
Configured policy attachments and verified scope (tenancy vs compartment level)
Verified policy statements matched OCI requirements
Result: Issue persisted despite comprehensive IAM configuration across multiple policy levels

3. Availability Domain Optimization

Modified code to auto-select first available AD using data source
Implemented dynamic AD selection: data.oci_identity_availability_domains.ads.availability_domains[0].name
Tested multiple availability domains (AD-1, AD-2, AD-3)
Ensured proper AD naming format for us-ashburn region
Result: Issue persisted across all availability domains

4. SSH Key Configuration

Generated new RSA SSH key pair (2048-bit) for instance access
Verified key file paths and proper file permissions
Confirmed key format compatibility with OCI requirements
Tested key file reading in Terraform configuration
Result: Keys configured correctly, not the cause

5. API Authentication Verification

Validated OCI API keys and fingerprint matching
Confirmed proper provider configuration in provider.tf
Tested with different credential paths
Verified private key PEM format
Result: Authentication working correctly for network resources

Root Cause Analysis
After systematic debugging across compartments, policies, availability domains, and authentication:
Conclusion: Free tier account limitations or regional capacity constraints prevented compute instance provisioning. The networking infrastructure deployed successfully, demonstrating that Terraform configuration and IaC workflow were correct. The 404 error specifically occurred only for compute instance creation, not for any networking resources.
Key Learnings
This troubleshooting process demonstrated:

Systematic debugging methodology - Testing each potential cause systematically
OCI IAM understanding - Policy hierarchy (tenancy vs compartment), policy creation and attachment
Compartment design - Resource isolation and organizational structure
Terraform state management - Understanding what's deployed vs what's planned
Cloud service limitations - Real-world constraints in free tier environments
Professional problem-solving - Documenting attempts, analyzing results, adapting approach

💡 Key Takeaways
Infrastructure-as-Code Benefits
Consistency - Same code produces identical infrastructure every time
Version Control - Track infrastructure changes in Git like application code
Collaboration - Team members can review and approve infrastructure changes
Documentation - The code itself documents the infrastructure design
Automation - Deploy or destroy complete environments with single commands
Reproducibility - Recreate entire infrastructure in minutes
Project Outcomes
While the compute instance couldn't be deployed due to account constraints, this project successfully demonstrated:

✅ Complete Infrastructure-as-Code workflow (init, plan, apply, destroy)
✅ Resource dependency management (Terraform automatically orders resource creation)
✅ Cloud networking concepts (VCN, subnets, routing, security)
✅ Systematic troubleshooting methodology
✅ OCI IAM and policy management
✅ Professional documentation practices

🎓 Skills Demonstrated

Infrastructure-as-Code (IaC) implementation
Terraform/HCL programming
Cloud networking architecture
OCI platform knowledge
IAM policy configuration
Compartment design
Systematic debugging
Technical documentation
Problem-solving under constraints

🧹 Cleanup
To remove all created resources and avoid consuming free tier quota:
bashterraform destroy
Type yes when prompted. All 5 networking resources will be deleted within 1-2 minutes.
🔗 Links

GitHub Repository: View Source Code
LinkedIn: Oluwatobi Ojuade
Portfolio: ojuaos23.github.io
Email: Tobi_Ojuade@yahoo.com

📚 Resources

Terraform Documentation
OCI Terraform Provider
OCI Free Tier
Infrastructure-as-Code Best Practices


Project Status: ✅ Completed - Networking infrastructure successfully deployed via IaC
Date: November 2025
Technologies: Terraform, OCI, HCL, IAM, Git