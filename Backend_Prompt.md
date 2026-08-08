Using the approved Architecture Blueprint and the Master Prompt above.

Begin backend implementation ONLY.

Do NOT generate frontend code.

Do NOT generate mobile code.

Do NOT generate infrastructure code unless required for backend execution.

Assume the Architecture Blueprint has been approved.

Follow it exactly.

Never redesign APIs.

Never redesign the database.

Generate code incrementally according to the Master Prompt milestone strategy.

────────────────────────────────────────

MISSION

Build the complete production-ready backend for a global mapping, navigation, geospatial intelligence, and local discovery platform.

The backend must support:

• Interactive Maps

• Global Navigation

• Turn-by-Turn Routing

• Places

• Business Listings

• Reviews

• Geospatial Search

• Reverse & Forward Geocoding

• Traffic Intelligence

• Offline Maps

• Fleet APIs

• Public APIs

• Enterprise GIS

• AI-assisted Search (future-ready)

Design for:

• 500M+ registered users

• 100M+ monthly active users

• 250M+ places

• 25M+ verified businesses

• Billions of map tile requests

• Millions of routing requests per day

• Multi-region deployment

• Active-Active architecture

• Zero-downtime deployments

────────────────────────────────────────

TECH STACK

Language

• TypeScript

Framework

• NestJS

Runtime

• Node.js

Database

• PostgreSQL

• PostGIS

• Prisma ORM

Cache

• Redis

Search

• Elasticsearch / OpenSearch

Routing

• Valhalla

Maps

• OpenStreetMap

Vector Tiles

• Martin / TileServer GL

Storage

• AWS S3-compatible Storage

Documentation

• OpenAPI / Swagger

────────────────────────────────────────

ARCHITECTURE

Strictly follow:

• Clean Architecture

• Domain-Driven Design

• SOLID

• Repository Pattern

• Service Layer

• Dependency Injection

• Feature-first organization

• Event-Driven Architecture where appropriate

• CQRS where appropriate

Never violate architectural boundaries.

────────────────────────────────────────

IMPLEMENT THE FOLLOWING DOMAINS

Maps

Geospatial

Routing

Traffic

Places

Businesses

Categories

Reviews

Media

Search

Users

Profiles

Favorites

Saved Places

Lists

Location History

Location Sharing

Notifications

Analytics

Administration

Moderation

Audit

Feature Flags

Developer Platform

Future AI Platform

────────────────────────────────────────

MICROSERVICES

Generate production-ready implementations for:

API Gateway

Authentication Service

Authorization Service

User Service

Profile Service

Places Service

Business Service

Category Service

Review Service

Search Service

Geospatial Service

Routing Service

Traffic Service

Map Tile Service

Reverse Geocoding Service

Forward Geocoding Service

Media Service

Notification Service

Analytics Service

Administration Service

Moderation Service

Audit Service

Feature Flag Service

Developer Platform Service

────────────────────────────────────────

AUTHENTICATION

Implement:

Registration

Email Verification

OAuth

JWT

Refresh Tokens

Session Management

Device Management

Password Reset

RBAC

────────────────────────────────────────

PLACES

Implement:

Place Profiles

Categories

Tags

Attributes

Coordinates

Photos

Descriptions

Popularity Scores

Ownership

Verification Status

Opening Hours

Accessibility Information

Multilingual Content

────────────────────────────────────────

BUSINESSES

Support:

Business Profiles

Multiple Locations

Ownership Verification

Business Categories

Services

Menus (where applicable)

Media

Contact Information

Opening Hours

Business Analytics

────────────────────────────────────────

REVIEWS

Implement:

Ratings

Written Reviews

Photos

Helpful Votes

Review Moderation

Spam Detection

Review Reporting

Business Responses

Review Analytics

────────────────────────────────────────

SEARCH

Implement Elasticsearch/OpenSearch supporting:

Address Search

Nearby Search

Business Search

Category Search

Autocomplete

Reverse Geocoding

Forward Geocoding

Search Suggestions

Ranking

Synonyms

Language Detection

Geospatial Filtering

Full-text Search

────────────────────────────────────────

GEOSPATIAL

Implement PostGIS services for:

Spatial Queries

Bounding Box Queries

Nearest Neighbor

Radius Search

Polygon Search

Geofencing

Spatial Indexes

Distance Calculations

Coordinate Conversion

Map Projections

────────────────────────────────────────

ROUTING

Integrate Valhalla supporting:

Driving

Walking

Cycling

Truck Routing

Alternative Routes

Multi-stop Routes

Road Restrictions

ETA Calculation

Traffic-aware Routing

Route Optimization

────────────────────────────────────────

TRAFFIC

Implement:

Road Closures

Construction

Traffic Incidents

Crowdsourced Reports

Traffic Density

Historical Traffic

Traffic Analytics

────────────────────────────────────────

MAP TILES

Generate services for:

Vector Tile Delivery

Tile Caching

Tile Versioning

Tile Invalidation

Regional Tile Distribution

CDN Optimization

────────────────────────────────────────

MEDIA

Support:

Business Photos

Place Photos

Review Photos

Maps Assets

Documents

Generate:

Signed Upload URLs

Signed Download URLs

Image Optimization

Thumbnail Generation

Metadata Extraction

Virus Scanning

Lifecycle Policies

────────────────────────────────────────

CACHE

Implement Redis for:

Search Cache

Tile Cache

Nearby Search Cache

Routing Cache

Session Cache

API Cache

Rate Limiting

Distributed Locks

Feature Flags

────────────────────────────────────────

EVENT-DRIVEN ARCHITECTURE

Generate events such as:

PlaceCreated

PlaceUpdated

BusinessVerified

ReviewCreated

ReviewModerated

TrafficUpdated

RouteCalculated

TileInvalidated

MediaUploaded

MediaProcessed

AnalyticsUpdated

NotificationQueued

FeatureFlagUpdated

AuditEventCreated

Generate producers, consumers, retry policies, and dead-letter handling.

────────────────────────────────────────

BACKGROUND WORKERS

Generate workers for:

Tile Generation

Search Indexing

Image Processing

Metadata Extraction

Traffic Aggregation

Analytics Aggregation

Cache Invalidation

Data Cleanup

Retention Policies

────────────────────────────────────────

OBSERVABILITY

Implement:

Structured Logging

Distributed Tracing

Metrics

Health Checks

Readiness Checks

Liveness Checks

Search Metrics

Routing Metrics

Tile Metrics

Traffic Metrics

API Metrics

────────────────────────────────────────

SECURITY

Implement:

OWASP Top 10

JWT

RBAC

Rate Limiting

Input Validation

Secrets Management

Audit Logging

Encryption at Rest

Encryption in Transit

Abuse Prevention

────────────────────────────────────────

AI-READY ARCHITECTURE

Prepare interfaces for:

Semantic Search

AI-assisted Place Discovery

Review Summarization

Route Optimization AI

Traffic Prediction

Geospatial Recommendations

Natural Language Search

LLM Gateway

Prompt Management

AI Audit Logs

────────────────────────────────────────

TESTING

Generate:

Unit Tests

Integration Tests

Repository Tests

Controller Tests

Contract Tests

Performance Tests

Security Tests

Geospatial Accuracy Tests

Routing Validation Tests

────────────────────────────────────────

PROJECT ORGANIZATION

Maintain:

Current Milestone

Generated Files

Completed Services

API Endpoints

Database Objects

Background Workers

Events

Dependencies

Remaining Work

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

Generate the backend incrementally according to the Master Prompt.

Each milestone should contain approximately 20–40 files.

At the end of every milestone:

• Verify the backend compiles successfully.

• Update the project index.

• List completed services.

• Identify the next file to generate.

STOP and wait for approval before generating the next milestone.
