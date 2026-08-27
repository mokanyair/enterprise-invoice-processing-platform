# AWS Event-Driven Serverless Invoice Processing Platform

A serverless, event-driven invoice-processing platform built on AWS and provisioned using modular Terraform Infrastructure as Code.

The platform automatically detects newly uploaded invoices, invokes serverless processing, stores processed results separately, and publishes processing notifications without requiring continuously running compute infrastructure.

---

## Project Overview

This project demonstrates the design and implementation of an event-driven AWS workload using:

- Amazon S3 for object storage and event generation
- AWS Lambda for serverless processing
- Amazon SNS for asynchronous notifications
- AWS IAM for workload permissions
- Amazon CloudWatch for Lambda logging
- Terraform for Infrastructure as Code
- Terraform Cloud for remote state and workspace management

The infrastructure is separated into reusable Terraform modules rather than being implemented as one monolithic Terraform configuration.

---

## Problem It Solves

Traditional file-processing systems often depend on continuously running servers, scheduled polling jobs, or manually triggered workflows.

This project replaces that model with an event-driven architecture.

When an invoice is uploaded to the raw S3 bucket, Amazon S3 generates an object-created event that invokes the Lambda processor automatically.

The processing workflow therefore runs only when work is available.

---

## Architecture


                    Invoice Upload
                          |
                          v
                +-------------------+
                |   Amazon S3       |
                |    Raw Bucket     |
                +-------------------+
                          |
                   ObjectCreated Event
                          |
                          v
                +-------------------+
                |    AWS Lambda     |
                | Invoice Processor |
                +-------------------+
                     |          |
                     |          |
                     v          v
          +----------------+  +----------------+
          |   Amazon S3    |  |   Amazon SNS   |
          | Processed Data |  | Notifications  |
          +----------------+  +----------------+
                                      |
                                      v
                               Email Subscriber

                          +
                          |
                    CloudWatch Logs

## Infrastructure Provisioning
Terraform
   |
   +--> S3 Module
   |
   +--> Lambda Module
   |
   +--> SNS Module
   |
   +--> IAM Permissions
   |
   +--> S3 Event Notification
   |
   +--> Terraform Cloud
        Remote State / Workspace
                    
