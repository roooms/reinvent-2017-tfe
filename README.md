# re:Invent 2017 Terraform Enterprise Demo

A simple Terraform configuration to demonstrate the features within Terraform Enterprise.

This configuration provisions an AWS VPC and required networking components along with two EC2 instances.

## Estimated Time to Complete

10 minutes.

## Prerequisites

### AWS

`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are required as Environment Variables in Terraform Enterprise.

## Steps

> The steps in this guide assume you have access to Terraform Enterprise and are familiar with navigating the interface

1. In TFE select the reinvent organization.
1. Create a new Sentinel Policy:

    * Name the Sentinel Policy restrict_instance_type
    * Set the Enforcement Mode to soft-mandatory (can override)
    * Use the policy code from restrict_instance_type.sentinel

1. Create a new workspace name reinvent-2017-tfe that is linked to this repository.
1. Set Terraform Variables in the TFE UI for any variable defaults you want to override.
1. Queue a plan and review the Policy Check output.
1. Update the instance types in the Terraform configuration so they are in the list of allowed_instance_types.
1. Queue a new plan and review the Policy Check output.
