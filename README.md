
# Terraform AWS S3 Bucket Configuration with static website

This Terraform configuration sets up an AWS S3 bucket along with various configurations and permissions.

## Contents

- [Terraform AWS S3 Bucket Configuration with static website](#terraform-aws-s3-bucket-configuration-with-static-website)
  - [Contents](#contents)
  - [Overview](#overview)
  - [Setup](#setup)
  - [Terraform Configuration](#terraform-configuration)
  - [Usage](#usage)
  - [References](#references)
  - [Contributing](#contributing)
  - [License](#license)

## Overview

This Terraform configuration creates an S3 bucket named `my_bucket` with the following features:

- **Bucket Ownership Controls:** Object ownership set to "BucketOwnerPreferred."
- **Public Access Block:** Public access is not blocked, allowing for public ACLs and policies.
- **Bucket ACL:** Objects in the bucket are set to have a "public-read" ACL.
- **Bucket Versioning:** Versioning is enabled for the bucket.
- **Bucket Policy:** Allows public read access to objects in the bucket.
- **Website Configuration:** Configures the bucket to host a static website with `index.html` as the index document and `error.html` as the error document.

## Setup

1. Make sure you have [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
2. Clone this repository to your local machine.

## Terraform Configuration

The Terraform configuration is split into multiple resources:

- `aws_s3_bucket`: Creates the S3 bucket.
- `aws_s3_bucket_ownership_controls`: Sets object ownership to "BucketOwnerPreferred."
- `aws_s3_bucket_public_access_block`: Configures public access settings.
- `aws_s3_bucket_acl`: Sets the ACL for objects in the bucket to "public-read."
- `aws_s3_bucket_versioning`: Enables versioning for the bucket.
- `aws_s3_bucket_policy`: Sets a bucket policy allowing public read access.
- `aws_s3_bucket_website_configuration`: Configures the bucket to host a static website.
- `aws_s3_object`: Uploads files to the bucket.

## Usage

1. Navigate to the directory containing the Terraform files.
2. Initialize Terraform with `terraform init`.
3. Review the execution plan with `terraform plan`.
4. Apply the configuration with `terraform apply`.
5. Confirm the changes.

## References
- Tech-With-Helen GitHub Repository
- Terraform Template Module
- Terraform AWS Provider Documentation - S3 Bucket
- Mathesh-me GitHub Repository


## Contributing

Contributions are welcome! If you find any issues or improvements, feel free to open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

