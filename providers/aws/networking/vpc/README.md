# 🌐 VPC Terraform Module

This module provisions a basic AWS VPC infrastructure with subnets, a route table, an internet gateway, and a security group.

It is designed to be reusable across projects and environments, making it easier to maintain consistent networking configurations in your AWS infrastructure.

---

## 📦 What it creates

- A **VPC** with a user-defined CIDR block.
- Multiple **Subnets** based on a list of CIDR blocks.
- An **Internet Gateway** attached to the VPC.
- A **Route Table** with a default route to the internet.
- **Route Table Associations** for all subnets.
- A **Security Group** with a default configuration (rules can be added as needed).

---

## 📥 Input Variables

| Name                 | Type    | Description                            | Required |
|----------------------|---------|----------------------------------------|----------|
| `vpc_cidr_block`     | string  | The CIDR block for the VPC.            | ✅ Yes    |
| `subnet_cidr_blocks` | list(string) | List of CIDR blocks for the subnets. | ✅ Yes    |

---

## 📤 Outputs

You can extend this module to include useful outputs like:

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [for s in aws_subnet.subnets : s.id]
}
```

## 🚀 Usage Example

```hcl
module "vpc" {
  source = "git::https://github.com/duv0-x/terraform-tools.git//vpc?ref=main"

  vpc_cidr_block     = "10.0.0.0/16"
  subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
}
```

## 🛡️ Notes
•	The security group is created without any default ingress/egress rules. You can customize it by editing the module.
•	The route table includes a default route to the internet via the Internet Gateway, making subnets public by default.