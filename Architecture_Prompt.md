Using the Master Prompt above.

DO NOT begin implementation.

Your responsibility in this phase is to design the complete enterprise architecture for a production-ready global mapping, navigation, geospatial intelligence, and local discovery platform.

This architecture will become the single source of truth for every Backend, Frontend, Mobile, Infrastructure, DevOps, AI, Security, GIS, and Operations implementation.

Do NOT generate source code.

Generate only architecture, engineering specifications, domain models, service boundaries, infrastructure decisions, API contracts, geospatial models, deployment topology, scalability strategies, security models, and implementation plans.

────────────────────────────────────────

MISSION

Build a production-ready global mapping platform comparable in engineering maturity to modern commercial mapping platforms.

The objective is NOT to clone any existing product.

Instead, design a cloud-native mapping ecosystem capable of supporting:

• Interactive Maps

• Global Navigation

• Turn-by-Turn Routing

• Local Business Discovery

• Geospatial Search

• Reviews

• User Contributions

• Offline Maps

• Traffic Intelligence

• Fleet APIs

• Geospatial Analytics

• Indoor Mapping (future-ready)

• Drone Routing (future-ready)

• AI-assisted Search

• Enterprise GIS

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

PRIMARY TECHNOLOGY STACK

Frontend

• Next.js 15

• React 19

• TypeScript

• Tailwind CSS

Mobile

• React Native

• Expo

• TypeScript

Backend

• Node.js

• NestJS

• TypeScript

Database

• PostgreSQL

• PostGIS

ORM

• Prisma

Caching

• Redis

Search

• Elasticsearch / OpenSearch

Maps

• OpenStreetMap

Routing Engine

• Valhalla

Vector Tiles

• Martin or TileServer GL

Object Storage

• AWS S3-compatible Storage

Infrastructure

• Docker

• Kubernetes

• Helm

• Terraform

• GitHub Actions

Observability

• Prometheus

• Grafana

• Loki

• Tempo

• OpenTelemetry

Secrets

• HashiCorp Vault

────────────────────────────────────────

APPLICATIONS

Design complete architecture for:

• Consumer Mobile App

• Consumer Web App

• Business Portal

• Administration Dashboard

• Map Editor

• Fleet Dashboard

• Public API Portal

• Developer Portal

────────────────────────────────────────

CORE DOMAINS

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

Navigation

Users

Profiles

Saved Places

Favorites

Lists

History

Location Sharing

Notifications

Analytics

Administration

Moderation

Developer Platform

Feature Flags

Audit

Future AI Platform

────────────────────────────────────────

MICROSERVICES

Generate service boundaries for:

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

Feature Flag Service

Audit Service

Developer Platform Service

────────────────────────────────────────

MAP FEATURES

Design architecture supporting:

Interactive Maps

Vector Tiles

Satellite Layer Integration

Terrain Layer

Traffic Layer

Transit Layer

Cycling Layer

Walking Layer

3D Buildings (future-ready)

Indoor Maps (future-ready)

Offline Maps

Map Styling

Marker Clustering

Heat Maps

Distance Measurement

Drawing Tools

Geofencing

Coordinate Conversion

Map Snapshots

────────────────────────────────────────

NAVIGATION

Support:

Turn-by-Turn Navigation

Driving

Walking

Cycling

Truck Routing

Motorcycle Routing

Public Transit (future-ready)

Alternative Routes

Waypoint Optimization

Multi-stop Routing

Road Restrictions

ETA Estimation

Voice Navigation APIs

Traffic-aware Routing

────────────────────────────────────────

SEARCH

Generate architecture for:

Address Search

Nearby Search

Business Search

Category Search

Reverse Geocoding

Forward Geocoding

Autocomplete

Search Suggestions

Full-text Search

Spatial Search

Ranking Engine

Synonyms

Language Detection

Search Analytics

────────────────────────────────────────

PLACES

Generate complete domain model for:

Restaurants

Hotels

Hospitals

Gas Stations

Museums

Tourist Attractions

Parking

Public Transport

Airports

Government Buildings

EV Charging Stations

Custom Categories

────────────────────────────────────────

BUSINESSES

Support:

Business Profiles

Verification

Ownership

Photos

Menus

Services

Opening Hours

Contact Information

Attributes

Categories

Location Editing

Multi-location Businesses

────────────────────────────────────────

REVIEWS

Design:

Ratings

Reviews

Photos

Voting

Helpful Marks

Reporting

Moderation

Spam Detection

Review Analytics

────────────────────────────────────────

TRAFFIC

Generate architecture for:

Road Closures

Construction

Accidents

Traffic Density

Crowdsourced Reports

Speed Data

Historical Traffic

Predictive Traffic (future-ready)

────────────────────────────────────────

DATABASE

Generate complete geospatial database architecture.

Include:

ERD

Normalization Strategy

PostGIS Schema

Spatial Indexes

GiST Indexes

Partitioning Strategy

Routing Tables

Place Tables

Business Tables

Review Tables

Media Tables

Audit Tables

Optimize for:

250M+ places

25M+ businesses

5B+ reviews

Global coordinates

High-performance spatial queries

Read replicas

Sharding preparation

────────────────────────────────────────

GEOSPATIAL DESIGN

Generate:

Coordinate Systems

Geometry Types

Geography Types

Spatial Relationships

Distance Calculations

Bounding Boxes

Spatial Joins

Nearest Neighbor Queries

Polygon Searches

Geofencing Strategy

Tile Generation Strategy

────────────────────────────────────────

PHASE 1 REQUIREMENTS

Generate ONLY:

1. Enterprise system architecture
2. Domain decomposition
3. Bounded contexts
4. Service boundaries
5. Monorepo structure
6. Folder hierarchy
7. ERD
8. PostgreSQL schema
9. PostGIS design
10. Prisma schema
11. Elasticsearch mappings
12. Redis architecture
13. API contracts
14. Authentication architecture
15. Authorization model
16. Routing architecture
17. Tile server architecture
18. Geospatial architecture
19. Search architecture
20. Traffic architecture
21. Deployment architecture
22. Kubernetes topology
23. Infrastructure overview
24. Security architecture
25. Disaster recovery strategy
26. Project index

Do NOT implement backend code.

STOP after Phase 1.

Wait for approval before beginning backend implementation.

────────────────────────────────────────

ARCHITECTURAL DECISIONS

Unless there is a compelling technical reason otherwise, assume:

• PostgreSQL + PostGIS for geospatial data

• Prisma ORM

• Valhalla as the routing engine

• Martin or TileServer GL for vector tiles

• OpenStreetMap as the primary mapping source

• Elasticsearch/OpenSearch for search

• Redis for caching

• S3-compatible object storage

• Kubernetes for orchestration

• Terraform for Infrastructure as Code

• OpenTelemetry for observability

• Vault for secrets management

• Event-driven communication where appropriate

• Clean Architecture

• Domain-Driven Design

• Repository Pattern

• Dependency Injection

• CQRS where appropriate

Design every architectural decision for long-term scalability, maintainability, resilience, vendor independence, and global deployment.
