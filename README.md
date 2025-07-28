# 🌍 Terraform Reusable Modules

This repository contains reusable Terraform modules to standardize and simplify the deployment of common infrastructure components across multiple projects.

---

### 📦 Available Modules

| Module | Description |
|--------|-------------|
| `vpc`  | Creates a Virtual Private Cloud (VPC) with subnets, route tables, internet/NAT gateways, and other essential networking resources. |

> More modules will be added over time, including support for Lambda functions, API Gateway, SQS, and other AWS services.

---

### 🚀 Usage

Each module is designed to be easily consumed from other Terraform projects. Here's a basic example of how to use the `vpc` module:

```hcl
module "vpc" {
  source = "git::https://github.com/duv0-x/terraform-tools.git//vpc?ref=main"

  environment      = "dev"
  cidr_block       = "10.0.0.0/16"
  azs              = ["us-west-2a", "us-west-2b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateways = true
}
```

### 📁 Structure

Each module is located in its own folder and follows Terraform best practices:

    terraform-modules/
    ├── providers
        ├── aws
            ├── networking
                ├── vpc/
                    ├── main.tf
                    ├── variables.tf
                    ├── outputs.tf
                    ├── README.md

### ✅ Requirements
- Terraform >= 1.0
- AWS CLI configured (for module usage with AWS resources)

### 🤝 Contributing

Feel free to open issues or submit pull requests if you’d like to suggest improvements or add new modules.