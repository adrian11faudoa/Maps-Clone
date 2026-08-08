Using the approved Architecture Blueprint, the approved Backend Blueprint, and the Master Prompt above.

Begin frontend and mobile implementation ONLY.

Do NOT generate backend code.

Do NOT generate infrastructure code.

Do NOT redesign APIs.

Do NOT redesign the database.

Assume all backend APIs, authentication flows, geospatial services, routing services, and search contracts have been finalized.

Consume them exactly as specified.

Generate production-ready applications incrementally according to the Master Prompt milestone strategy.

────────────────────────────────────────

MISSION

Build world-class web and mobile applications for a global mapping, navigation, local discovery, and geospatial intelligence platform.

The applications should achieve the engineering quality of leading commercial mapping platforms while remaining vendor-independent and based on open technologies.

Generate:

• Consumer Mobile App (iOS & Android)

• Consumer Web App

• Business Portal

• Administration Dashboard

• Map Editor

• Fleet Dashboard

• Developer Portal

• Shared Design System

• Shared UI Component Library

• Shared API SDK

────────────────────────────────────────

TECH STACK

Web

• Next.js 15

• React 19

• TypeScript

• Tailwind CSS

Mobile

• React Native

• Expo

• TypeScript

Navigation

• React Navigation

State Management

• Zustand

Server State

• TanStack Query

Forms

• React Hook Form

• Zod

Maps

• MapLibre GL

• OpenStreetMap

Animations

• React Native Reanimated

• React Native Gesture Handler

• Moti

• Framer Motion (Web)

Lists

• FlashList

Storage

• MMKV

• SecureStore

Notifications

• Expo Notifications

────────────────────────────────────────

ARCHITECTURE

Follow:

• Clean Architecture

• Feature-first Organization

• SOLID

• Strict TypeScript

• Shared Design System

• Shared API Layer

• Modular UI

• Separation of Presentation and Business Logic

────────────────────────────────────────

APPLICATIONS

Generate:

Consumer Mobile App

Consumer Web App

Business Portal

Administration Dashboard

Map Editor

Fleet Dashboard

Developer Portal

Shared Components

Shared Hooks

Shared Utilities

Shared API SDK

────────────────────────────────────────

AUTHENTICATION

Implement:

Registration

Login

Logout

Email Verification

OAuth

Password Reset

Session Management

Device Management

Biometric Authentication

Role-based UI

────────────────────────────────────────

MAP EXPERIENCE

Implement:

Interactive Maps

Vector Tiles

Marker Clustering

Heat Maps

Traffic Layer

Terrain Layer

Satellite Layer Support

Offline Maps

Custom Map Styles

Drawing Tools

Distance Measurement

Compass

Scale Control

Current Location

Location Accuracy Indicator

Geofencing Visualization

Map Snapshots

────────────────────────────────────────

SEARCH EXPERIENCE

Implement:

Address Search

Nearby Search

Business Search

Category Search

Autocomplete

Recent Searches

Search Suggestions

Filters

Distance Filters

Open Now Filter

Rating Filter

Favorites Filter

────────────────────────────────────────

PLACES

Generate interfaces for:

Place Details

Business Details

Photos

Opening Hours

Reviews

Ratings

Menus

Amenities

Accessibility Information

Popular Times (future-ready)

Directions

Share Place

Save Place

────────────────────────────────────────

NAVIGATION

Implement:

Turn-by-Turn Navigation

Driving Mode

Walking Mode

Cycling Mode

Truck Routing

Alternative Routes

Waypoint Management

ETA Display

Traffic Alerts

Voice Navigation UI

Route Preview

Arrival Summary

────────────────────────────────────────

USER FEATURES

Support:

Profiles

Favorites

Saved Places

Custom Lists

Travel History

Location Sharing

Privacy Controls

Notification Preferences

────────────────────────────────────────

BUSINESS PORTAL

Generate:

Business Dashboard

Location Management

Business Verification

Photo Upload

Menu Management

Analytics

Review Responses

Business Settings

────────────────────────────────────────

MAP EDITOR

Implement:

Place Editing

Road Editing (future-ready)

POI Creation

Category Assignment

Geometry Editing

Review Queue

Approval Workflow

────────────────────────────────────────

ADMINISTRATION

Generate:

User Management

Business Moderation

Review Moderation

Content Moderation

Analytics Dashboard

Audit Viewer

Feature Flag Management

────────────────────────────────────────

STATE MANAGEMENT

Implement Zustand stores for:

Authentication

User

Profile

Maps

Routing

Traffic

Places

Businesses

Search

Favorites

Saved Places

Notifications

Theme

Feature Flags

────────────────────────────────────────

SERVER STATE

Implement TanStack Query supporting:

Caching

Infinite Queries

Optimistic Updates

Background Refresh

Retries

Offline Cache

Pagination

Cache Invalidation

────────────────────────────────────────

API CLIENT

Generate:

Typed SDK

REST Client

Authentication Interceptors

Retry Logic

Pagination Helpers

Geospatial Utilities

────────────────────────────────────────

OFFLINE MODE

Implement:

Offline Maps

Offline Search Cache

Offline Favorites

Offline Saved Places

Background Synchronization

Conflict Resolution

Automatic Retry

────────────────────────────────────────

NOTIFICATIONS

Support:

Push Notifications

Email Notifications

Location Alerts

Traffic Alerts

Business Notifications

Review Notifications

Deep Linking

────────────────────────────────────────

PERFORMANCE

Optimize:

Map Rendering

Tile Loading

Lazy Loading

Code Splitting

FlashList

Image Optimization

Memory Usage

Battery Consumption

Background Prefetching

────────────────────────────────────────

ACCESSIBILITY

Implement:

WCAG 2.2 AA Compliance

Screen Reader Support

VoiceOver

TalkBack

Keyboard Navigation (Web)

Dynamic Text

Reduced Motion

Focus Management

High Contrast Support

────────────────────────────────────────

RESPONSIVE DESIGN

Support:

Phones

Tablets

Desktop

Large Displays

Landscape

Portrait

────────────────────────────────────────

THEMING

Support:

Light Theme

Dark Theme

System Theme

Brand Themes

────────────────────────────────────────

ANIMATIONS

Use Reanimated, Moti, and Framer Motion for:

Map Transitions

Navigation Transitions

Dialogs

Bottom Sheets

Marker Animations

Loading States

Micro-interactions

────────────────────────────────────────

ERROR HANDLING

Generate:

Error Boundaries

Offline Screens

Location Permission Screens

Retry Components

Maintenance Screens

Empty States

────────────────────────────────────────

AI-READY UI

Prepare interfaces for:

Natural Language Search

AI Route Planning

AI Place Recommendations

Review Summaries

Traffic Prediction

Travel Assistant

AI Settings

AI Usage Dashboard

────────────────────────────────────────

TESTING

Generate:

Unit Tests

Component Tests

Integration Tests

Accessibility Tests

Performance Tests

Visual Regression Architecture

End-to-End Tests

Map Interaction Tests

────────────────────────────────────────

DOCUMENTATION

Generate:

Component Documentation

Design System Documentation

Navigation Guide

Frontend Standards

State Management Standards

API Integration Guide

Developer Onboarding Guide

────────────────────────────────────────

PROJECT ORGANIZATION

Maintain throughout development:

Current Milestone

Generated Screens

Generated Components

Generated Features

API Integrations

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

Generate the frontend incrementally according to the Master Prompt.

Each milestone should contain approximately 20–40 files.

At the end of every milestone:

• Verify the applications compile successfully.

• Update the project index.

• List completed screens and features.

• Identify the next file to generate.

STOP and wait for approval before generating the next milestone.
