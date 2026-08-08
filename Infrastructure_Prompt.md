Using the approved Architecture Blueprint, the approved Backend Blueprint, the approved Frontend Blueprint, and the Master Prompt above.

Begin infrastructure and DevOps implementation ONLY.

Do NOT generate backend business logic.

Do NOT generate frontend or mobile code.

Do NOT redesign the architecture.

Assume all architectural decisions have been approved.

Your responsibility is to build the complete production-grade cloud platform capable of operating one of the world's largest mapping, navigation, geospatial intelligence, and local discovery ecosystems.

Generate infrastructure incrementally according to the Master Prompt milestone strategy.

────────────────────────────────────────

MISSION

Build a cloud-native infrastructure supporting:

• 500M+ registered users

• 100M+ monthly active users

• Billions of map tile requests

• Millions of routing requests per day

• 250M+ places

• 25M+ businesses

• Multi-region active-active deployment

• Zero-downtime deployments

• High availability

• Disaster recovery

• Global scalability

Optimize for reliability, performance, observability, cost efficiency, and long-term maintainability.

────────────────────────────────────────

TARGET ENVIRONMENTS

Generate complete infrastructure for:

• Local Development

• Development

• QA

• Staging

• Production

• Disaster Recovery

────────────────────────────────────────

PRIMARY CLOUD PLATFORM

Target AWS.

Generate infrastructure for:

Networking

• VPC

• Multi-AZ Design

• Public Subnets

• Private Subnets

• NAT Gateways

• Internet Gateway

• Route Tables

• Security Groups

• Network ACLs

Compute

• Amazon EKS

• Managed Node Groups

• Karpenter

• Cluster Autoscaler

• Horizontal Pod Autoscaler

• Vertical Pod Autoscaler

Storage

• Amazon S3

• Amazon EBS

• Amazon EFS

Database

• PostgreSQL

• Read Replicas

• PITR

• Automated Backups

Geospatial

• PostGIS

Search

• OpenSearch / Elasticsearch

Caching

• Redis

Registry

• Amazon ECR

CDN

• CloudFront

DNS

• Route53

Certificates

• AWS Certificate Manager

Secrets

• HashiCorp Vault

────────────────────────────────────────

MAP INFRASTRUCTURE

Generate infrastructure for:

Vector Tile Servers

Regional Tile Clusters

Tile Generation Workers

Tile Cache

Tile Versioning

Tile Distribution

Tile Invalidation

CDN Edge Caching

Regional Replication

────────────────────────────────────────

GEOSPATIAL INFRASTRUCTURE

Deploy:

PostGIS Clusters

Spatial Read Replicas

Routing Engine Clusters

Valhalla Services

Geocoding Services

Reverse Geocoding Services

Spatial Analytics Workers

Regional Geospatial Services

────────────────────────────────────────

TRAFFIC INFRASTRUCTURE

Generate:

Traffic Aggregation Workers

Incident Processing

Crowdsourced Reports Pipeline

Historical Traffic Storage

Traffic Analytics

Real-time Update Distribution

────────────────────────────────────────

MEDIA INFRASTRUCTURE

Support:

Business Images

Place Images

Review Images

Documents

Map Assets

Generate:

Image Optimization Workers

Thumbnail Workers

Metadata Extraction

Virus Scanning

Signed URLs

CloudFront Distribution

Lifecycle Policies

Cross-Region Replication

────────────────────────────────────────

SEARCH INFRASTRUCTURE

Deploy:

OpenSearch / Elasticsearch Cluster

Index Templates

Snapshot Strategy

Shard Strategy

Replica Strategy

Hot/Warm Tiering

Autoscaling

Monitoring

────────────────────────────────────────

CONTAINERIZATION

Generate:

Development Dockerfiles

Production Dockerfiles

Multi-stage Builds

Docker Compose

Container Optimization

Container Security

Image Signing

────────────────────────────────────────

KUBERNETES

Generate manifests for:

Namespaces

Deployments

StatefulSets

DaemonSets

Jobs

CronJobs

Services

Ingress

Gateway API (future-ready)

ConfigMaps

Secrets

Persistent Volumes

Persistent Volume Claims

Network Policies

Pod Security Standards

Service Accounts

RBAC

Resource Quotas

Limit Ranges

Pod Disruption Budgets

Horizontal Pod Autoscaler

Vertical Pod Autoscaler

────────────────────────────────────────

HELM

Generate:

Reusable Helm Charts

Environment Overrides

Secrets Integration

Values Files

Chart Documentation

────────────────────────────────────────

INFRASTRUCTURE AS CODE

Generate Terraform modules for:

Networking

IAM

EKS

PostgreSQL

PostGIS

Redis

OpenSearch

CloudFront

S3

ECR

Load Balancers

DNS

Certificates

Vault

Monitoring

Logging

Backups

Disaster Recovery

────────────────────────────────────────

CI/CD

Generate GitHub Actions workflows for:

Formatting

Linting

Unit Tests

Integration Tests

Security Scanning

Dependency Scanning

Container Builds

Container Scanning

Artifact Publishing

Preview Environments

Development Deployment

Staging Deployment

Production Deployment

Blue-Green Deployments

Canary Releases

Automatic Rollbacks

Release Automation

Semantic Versioning

────────────────────────────────────────

OBSERVABILITY

Generate:

Prometheus

Grafana

Loki

Tempo

OpenTelemetry

Distributed Tracing

Structured Logging

Infrastructure Dashboards

Routing Dashboards

Tile Metrics

Geospatial Metrics

Traffic Metrics

API Metrics

Database Metrics

Cache Metrics

────────────────────────────────────────

ALERTING

Generate alerts for:

CPU

Memory

Disk

Cluster Health

Node Health

Database Health

Redis Health

OpenSearch Health

Routing Engine Health

Tile Server Health

Traffic Pipeline Failures

API Latency

Search Latency

Routing Latency

Tile Generation Failures

Backup Failures

SSL Expiration

────────────────────────────────────────

SECURITY

Implement:

TLS Everywhere

IAM Least Privilege

Kubernetes RBAC

Network Policies

Vault Integration

Secrets Rotation

Container Scanning

Image Signing

Runtime Security

Encryption at Rest

Encryption in Transit

DDoS Protection

WAF-ready Architecture

OWASP Best Practices

SOC 2 Readiness

ISO 27001 Readiness

GDPR Compliance

CCPA Compliance

────────────────────────────────────────

BACKUPS

Generate:

Database Backups

PostGIS Backups

OpenSearch Snapshots

Redis Backups

S3 Replication

Retention Policies

Restore Automation

Backup Verification

────────────────────────────────────────

DISASTER RECOVERY

Design:

Recovery Time Objective (RTO)

Recovery Point Objective (RPO)

Cross-Region Failover

Database Recovery

Search Recovery

Redis Recovery

Routing Engine Recovery

Traffic Pipeline Recovery

Operational Runbooks

────────────────────────────────────────

PERFORMANCE

Optimize:

Tile Delivery

Routing Throughput

Search Performance

Spatial Queries

Autoscaling

Connection Pooling

CloudFront Edge Caching

Compression

Resource Requests

Resource Limits

────────────────────────────────────────

COST OPTIMIZATION

Generate strategies for:

Spot Instances

Reserved Capacity

Storage Tiering

CloudFront Optimization

Autoscaling Policies

Lifecycle Rules

Cost Monitoring

FinOps Dashboards

────────────────────────────────────────

COMPLIANCE

Prepare infrastructure for:

SOC 2

ISO 27001

GDPR

CCPA

Audit Logging

Retention Policies

────────────────────────────────────────

TESTING

Generate infrastructure testing for:

Terraform Validation

Helm Validation

Kubernetes Validation

Routing Load Testing

Tile Load Testing

Search Load Testing

Spatial Query Benchmarks

Disaster Recovery Drills

Backup Restoration

Chaos Engineering

Smoke Tests

────────────────────────────────────────

DOCUMENTATION

Generate:

Infrastructure Overview

Deployment Guide

Operations Guide

Monitoring Guide

Secrets Management Guide

Incident Response Guide

Disaster Recovery Guide

Runbooks

Capacity Planning Guide

Maintenance Guide

Cost Optimization Guide

────────────────────────────────────────

PROJECT ORGANIZATION

Maintain throughout development:

Current Milestone

Generated Infrastructure Files

Terraform Modules

Helm Charts

Docker Images

GitHub Actions

Networking Components

Monitoring Components

Security Components

Remaining Work

Dependencies

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never generate pseudo-code.

Never generate placeholders.

Never omit implementations.

Never regenerate unchanged files.

Only modify files when required.

────────────────────────────────────────

STOP CONDITIONS

Generate the infrastructure incrementally according to the Master Prompt.

Each milestone should contain approximately 20–40 files.

At the end of every milestone:

• Verify the infrastructure is deployable.

• Update the project index.

• List completed infrastructure components.

• Identify the next file to generate.

STOP and wait for approval before generating the next milestone.
