You are operating in Senior Engineering Team Mode.

Build the production-ready web frontend for an enterprise-scale global mapping, search, places, directions, navigation, traffic, business, and location platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

The frontend must consume the approved backend APIs and contracts for:

• Identity
• Accounts
• Profiles
• Devices
• Places
• Businesses
• Addresses
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Map tiles
• Map styles
• Routing
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Contributions
• Geofences
• Location sharing
• Trip sharing
• Offline maps
• Notifications
• Moderation
• Privacy
• Administration
• Analytics
• Feature flags
• Configuration
• Audit

Do not redesign the backend.

Do not implement backend code.

Do not implement mobile code.

Do not implement infrastructure code.

────────────────────────────────────────

MISSION

Build a production-ready web application supporting:

CONSUMERS

• Home map
• Interactive map
• Search
• Autocomplete
• Place discovery
• Place details
• Business details
• Directions
• Route selection
• ETA
• Traffic
• Saved places
• Favorites
• Collections
• Reviews
• Photos
• Location sharing
• Trip sharing
• Geofences where applicable
• Account
• Privacy
• Settings

BUSINESSES

• Business profile
• Business claim
• Business verification
• Business information
• Hours
• Special hours
• Attributes
• Photos
• Reviews
• Directions insights
• Analytics

ADMIN / OPERATIONS

• Places
• Businesses
• Reviews
• Contributions
• Roads
• Map datasets
• Routing graphs
• Traffic
• Incidents
• Search
• Offline packages
• Moderation
• Fraud
• Analytics
• Feature flags
• Configuration
• Audit
• Privacy

────────────────────────────────────────

TECHNOLOGY STACK

Framework:

• Next.js
• React
• TypeScript

Styling:

• Tailwind CSS
• shadcn/ui
• CSS variables

Server state:

• TanStack Query

Client state:

• Zustand

Forms:

• React Hook Form
• Zod

Maps:

• Provider-neutral map renderer abstraction
• Vector tiles
• Raster fallback

Charts:

• Recharts

Icons:

• Lucide React

Animations:

• Framer Motion where useful

Testing:

• Jest
• React Testing Library
• Playwright
• Accessibility testing tools

────────────────────────────────────────

FRONTEND ARCHITECTURE

Use:

• Next.js App Router
• Server Components where appropriate
• Client Components only where interaction requires them
• Feature-first architecture
• Strict TypeScript
• Typed API client
• Explicit domain boundaries
• TanStack Query for server state
• Zustand for UI state
• URL-driven search state where appropriate
• Reusable map abstractions
• Reusable route abstractions
• Accessibility-first components
• Responsive design

Do not make the entire application a Client Component.

Do not put routing algorithms or geospatial business logic inside UI components.

────────────────────────────────────────

APPLICATION STRUCTURE

Create:

app/

features/

components/

layouts/

providers/

hooks/

services/

stores/

map/

routing/

search/

location/

places/

businesses/

reviews/

saved-places/

collections/

sharing/

geofencing/

offline/

analytics/

admin/

privacy/

lib/

config/

types/

utils/

styles/

public/

tests/

Separate route groups for:

• Consumer
• Business
• Administration
• Moderation
• Operations

────────────────────────────────────────

NEXT.JS FOUNDATION

Implement:

• App Router
• Route groups
• Layout hierarchy
• Loading states
• Error boundaries
• Not-found
• Suspense
• Metadata
• Open Graph foundation
• Middleware
• Authentication-aware routing

Public routes:

• Map
• Search
• Public place
• Public business
• Public reviews
• Help

Authenticated routes:

• Saved places
• Collections
• Reviews
• Location sharing
• Trip sharing
• Settings

Administrative routes:

• Admin
• Moderation
• Operations
• Analytics
• Audit
• Configuration

Navigation is never a security boundary.

────────────────────────────────────────

DESIGN SYSTEM

Build reusable accessible components:

• Button
• IconButton
• Input
• Textarea
• Select
• Checkbox
• Radio
• Switch
• Dialog
• Drawer
• Sheet
• Popover
• Dropdown
• Tooltip
• Tabs
• Card
• Badge
• Avatar
• Breadcrumb
• Table
• Pagination
• Skeleton
• Alert
• Toast
• Progress
• Slider
• Calendar
• Date picker
• Command
• Separator
• Scroll area
• Empty state
• Error state
• Loading state
• Map control
• Map button
• Search box
• Search result
• Place card
• Business card
• Route card
• Route summary
• Turn-by-turn step
• Traffic legend
• Incident card
• Saved-place card
• Collection card
• Review card
• Rating display
• Photo gallery
• Contribution form
• Share dialog
• Report dialog
• Geofence editor
• Analytics card
• Data table

All components must support:

• Keyboard navigation
• Focus management
• Responsive behavior
• Dark mode
• Accessibility

────────────────────────────────────────

THEME

Support:

• Light
• Dark
• System

Persist preference.

Respect:

• Reduced motion
• High contrast
• Browser accessibility

────────────────────────────────────────

API CLIENT

Implement a typed API client supporting:

• Base URL
• Authentication
• Request ID
• Correlation ID
• Timeout
• Cancellation
• Retry where safe
• Error normalization
• Cursor pagination
• Idempotency
• Route requests
• Search
• Geocoding
• Location sharing
• Offline package metadata

Do not place business rules in the API client.

────────────────────────────────────────

SERVER STATE

Use TanStack Query for:

• Account
• Profile
• Places
• Businesses
• Search
• Autocomplete
• Routes
• ETA
• Traffic
• Incidents
• Saved places
• Collections
• Reviews
• Photos
• Contributions
• Notifications
• Sharing
• Geofences
• Offline maps
• Analytics
• Administration
• Privacy

Support:

• Query keys
• Mutations
• Infinite queries
• Cache
• Refetch
• Optimistic updates where safe
• Invalidation
• Retry
• Error handling

────────────────────────────────────────

CLIENT STATE

Use Zustand for:

• Map UI state
• Map center
• Zoom
• Selected place
• Active route
• Route panel
• Search UI
• Side panel
• Modal state
• Theme
• Layer visibility
• Traffic layer
• Current map interaction
• Navigation preview UI
• Local preferences

Do not use Zustand as the authority for:

• Place ownership
• Business ownership
• Route correctness
• Privacy
• Location permissions
• Review state
• Administrative permissions

────────────────────────────────────────

MAP RENDERING

Build a reusable map-rendering abstraction.

Support:

• Vector tiles
• Raster fallback
• Map styles
• Light/dark
• Accessibility style
• Map controls
• Markers
• Clustering
• Polylines
• Polygons
• Geofences
• Route geometry
• Traffic overlays
• Incident markers

Do not bind product logic directly to one map SDK.

────────────────────────────────────────

MAP CAMERA

Support:

• Center
• Zoom
• Bearing where supported
• Pitch where supported
• Fit bounds
• Fit route
• Follow location
• Reset north
• Search-result centering

Use smooth transitions without harming accessibility or performance.

────────────────────────────────────────

MAP CONTROLS

Provide:

• Zoom
• Current location
• Layers
• Traffic
• Fullscreen
• Style switch
• Directions
• Save
• Share

Controls must be keyboard accessible.

────────────────────────────────────────

MAP LAYERS

Support:

• Base map
• Traffic
• Incidents
• Closures
• Transit foundation
• Saved places
• Search results
• Route
• Alternative routes
• Geofences

Allow layer visibility to be controlled independently.

────────────────────────────────────────

MAP PERFORMANCE

Optimize for:

• Initial map load
• Tile rendering
• Pan/zoom
• Marker rendering
• Route rendering
• Search result updates
• Traffic overlay

Use:

• Vector tiles
• CDN
• Clustering
• Virtualization where applicable
• Debouncing
• Limited DOM overlays

Do not create one DOM node per geographic object at global scale.

────────────────────────────────────────

SEARCH EXPERIENCE

Build global search.

Support:

• Search input
• Autocomplete
• Recent searches
• Search suggestions
• Search categories
• Search results
• Nearby results
• Query refinement

Search input should remain available while the map is visible.

────────────────────────────────────────

AUTOCOMPLETE

Support:

• Debouncing
• Request cancellation
• Geographic bias
• Region
• Language
• Categories
• Places
• Businesses
• Addresses
• Roads

Ignore stale responses.

────────────────────────────────────────

SEARCH RESULTS

Display:

• Place name
• Address
• Category
• Distance
• Business status
• Rating
• Relevant metadata

Results should update the map.

────────────────────────────────────────

SEARCH RESULT MAP INTERACTION

When a result is selected:

• Center map
• Zoom appropriately
• Highlight marker
• Open details panel
• Preserve search context

Support multiple selected results.

────────────────────────────────────────

PLACE DETAILS

Display:

• Name
• Category
• Address
• Coordinates
• Hours
• Special hours
• Contact
• Website
• Photos
• Rating
• Reviews
• Directions
• Save
• Share
• Report
• Contributions

Respect place status.

────────────────────────────────────────

BUSINESS DETAILS

Display:

• Business name
• Address
• Hours
• Special hours
• Phone
• Website
• Categories
• Attributes
• Photos
• Reviews
• Rating
• Directions
• Save
• Share

────────────────────────────────────────

OPEN-NOW

Calculate display state using server-provided hours and place time zone.

Do not infer business opening state solely from the browser's local timezone.

────────────────────────────────────────

DIRECTIONS

Build directions interface.

Support:

• Origin
• Destination
• Waypoints
• Travel mode
• Preferences
• Departure time
• Arrival time

Travel modes:

• Driving
• Walking
• Cycling
• Transit foundation

────────────────────────────────────────

ROUTE OPTIONS

Support:

• Fastest
• Shortest
• Avoid tolls
• Avoid highways
• Avoid ferries
• Accessible route

Use backend-supported options only.

────────────────────────────────────────

ROUTE RESULTS

Display:

• Primary route
• Alternatives
• Distance
• Duration
• ETA
• Traffic impact
• Warnings
• Toll references
• Turn-by-turn preview

Do not calculate routes in the browser.

────────────────────────────────────────

ROUTE VISUALIZATION

Display:

• Route polyline
• Alternative routes
• Origin
• Destination
• Waypoints
• Incident markers
• Traffic conditions

Use route fit bounds.

────────────────────────────────────────

ROUTE SELECTION

When user selects an alternative:

• Update route
• Update ETA
• Update summary
• Update step list
• Update map styling

────────────────────────────────────────

TRAFFIC

Display:

• Traffic layer
• Congestion
• Incidents
• Closures
• Construction

Use backend-provided traffic state.

Do not infer traffic solely from visible line color.

────────────────────────────────────────

TRAFFIC LEGEND

Provide accessible legend for:

• Normal
• Moderate
• Heavy
• Severe
• Unknown/stale

Avoid color-only communication.

────────────────────────────────────────

INCIDENTS

Display:

• Marker
• Type
• Severity
• Description
• Effective status
• Expiration if available

Provide accessible alternative information.

────────────────────────────────────────

NAVIGATION PREVIEW

Provide desktop route-preview experience.

Support:

• Step list
• Current step preview
• ETA
• Remaining distance
• Traffic
• Route alternatives
• Reroute indication

Actual continuous background navigation belongs primarily to mobile.

────────────────────────────────────────

TURN-BY-TURN UI

Display:

• Maneuver
• Street
• Distance
• Estimated time
• Warnings

Support:

• Continue
• Left
• Right
• U-turn
• Merge
• Roundabout
• Exit
• Destination

────────────────────────────────────────

CURRENT LOCATION

Support:

• Request location permission
• Show current location
• Center map
• Accuracy circle where appropriate

Do not continuously track user location without explicit product/permission requirements.

────────────────────────────────────────

LOCATION PERMISSION

Explain clearly:

• Why location is requested
• Whether it is required
• What happens if denied

Never attempt to bypass browser permissions.

────────────────────────────────────────

LOCATION SHARING

Support:

• Create share
• Select recipient/access
• Set expiration
• Copy secure share
• Revoke
• View status

Never expose raw permanent location URLs.

────────────────────────────────────────

TRIP SHARING

Support:

• Share route
• ETA
• Current location
• Destination
• Trip state
• Expiration
• Revoke

Display privacy warnings appropriately.

────────────────────────────────────────

SAVED PLACES

Support:

• Save
• Unsave
• Home
• Work
• Favorites
• Custom labels

Require authentication.

────────────────────────────────────────

SENSITIVE LOCATIONS

Treat Home and Work as highly sensitive.

Do not expose them through:

• Search history
• URL query
• Public sharing
• Analytics

────────────────────────────────────────

COLLECTIONS

Support:

• Create
• Rename
• Delete
• Add place
• Remove place
• Reorder
• Share if backend allows

Respect collection visibility.

────────────────────────────────────────

REVIEWS

Support:

• List reviews
• Create review
• Edit own
• Delete own
• Rating
• Photos
• Report

Use cursor pagination.

────────────────────────────────────────

REVIEW COMPOSER

Support:

• Rating
• Text
• Photo upload
• Validation
• Submit
• Draft where useful
• Error/retry

Do not expose moderation internals.

────────────────────────────────────────

PHOTO GALLERY

Support:

• Thumbnail
• Full-resolution viewing
• Pagination
• Upload where authorized
• Delete own photos
• Report

Use optimized image loading.

────────────────────────────────────────

CONTRIBUTIONS

Support:

• Add place
• Edit place
• Suggest closure
• Suggest road issue
• Add photo
• Report inaccurate information

Show:

• Draft
• Submitted
• Under review
• Approved
• Rejected
• Published
• Reverted

────────────────────────────────────────

GEOFENCES

Support map-based geofence UI:

• Create
• Edit
• Delete
• Circle
• Polygon
• Trigger type
• Expiration

Provide visual geometry editor.

────────────────────────────────────────

OFFLINE MAPS

Web should expose offline-map management where supported by product.

Support:

• Region browser
• Package metadata
• Version
• Download status
• Update
• Delete

Actual offline storage capability is primarily mobile.

────────────────────────────────────────

BUSINESS DASHBOARD

Support:

• Business profile
• Claim
• Verification state
• Hours
• Attributes
• Photos
• Reviews
• Analytics

────────────────────────────────────────

BUSINESS CLAIM

Workflow:

Claim
→ Verification
→ Pending
→ Approved/Rejected

Show authoritative server state.

────────────────────────────────────────

BUSINESS ANALYTICS

Display aggregate:

• Views
• Searches
• Directions
• Saves
• Reviews

Do not expose individual user location history.

────────────────────────────────────────

ADMIN APPLICATION

Create sections:

• Dashboard
• Places
• Businesses
• Reviews
• Contributions
• Roads
• Map datasets
• Routing graphs
• Traffic
• Incidents
• Search
• Offline packages
• Moderation
• Fraud
• Analytics
• Feature flags
• Configuration
• Audit
• Privacy

────────────────────────────────────────

ADMIN MAP

Provide operational map for:

• Search
• Place selection
• Road selection
• Incident visualization
• Closure visualization
• Geofence inspection
• Dataset coverage
• Routing graph status

────────────────────────────────────────

MAP DATA OPERATIONS

Display:

• Dataset
• Version
• Region
• Build status
• QA
• Publication
• Current version
• Previous version
• Rollback

────────────────────────────────────────

ROUTING OPERATIONS

Display:

• Graph version
• Region
• Active state
• Canary state
• Rollout percentage
• Performance
• Rollback controls

────────────────────────────────────────

TRAFFIC OPERATIONS

Display:

• Current traffic health
• Data freshness
• Provider status
• Segment anomalies
• Incident feeds

────────────────────────────────────────

SEARCH OPERATIONS

Support:

• Index status
• Version
• Document counts
• Freshness
• Reindex
• Alias state

────────────────────────────────────────

FEATURE FLAGS

Admin UI:

• Flag list
• Environment
• Region
• Platform
• Percentage
• Cohort
• Version history
• Kill switch
• Audit

Never treat feature flags as authorization.

────────────────────────────────────────

SYSTEM CONFIGURATION

Support:

• View
• Edit
• Validate
• Submit
• Activate
• Rollback
• History

Never expose secrets.

────────────────────────────────────────

AUDIT

Display:

• Actor
• Role
• Action
• Resource
• Reason
• Region
• Timestamp
• Correlation ID
• Result

Audit is read-only.

────────────────────────────────────────

PRIVACY

Consumer settings:

• Location permission guidance
• Location-history controls
• Search-history controls
• Saved-place controls
• Sharing controls
• Data export
• Data deletion
• Account deletion

────────────────────────────────────────

SEO

Public pages may be indexed:

• Public places
• Public businesses
• Public reviews where policy allows
• Help

Do not index:

• Saved places
• Collections
• Live shares
• Trip shares
• Search history
• Admin
• Moderation
• Privacy data

────────────────────────────────────────

PERFORMANCE

Optimize:

• Initial load
• Map rendering
• Search
• Autocomplete
• Place details
• Route rendering
• Large result sets
• Admin tables

Use:

• Server Components
• Streaming
• Suspense
• Dynamic imports
• Code splitting
• Virtualization
• CDN resources
• Image optimization
• Debouncing
• Memoization

────────────────────────────────────────

RESPONSIVE DESIGN

Support:

• Desktop
• Tablet
• Mobile web

Desktop prioritizes:

• Map + search
• Directions
• Place details

Mobile web prioritizes:

• Search
• Map
• Place details
• Directions

────────────────────────────────────────

ACCESSIBILITY

Target WCAG 2.2 AA.

Support:

• Keyboard navigation
• Screen readers
• Focus management
• Accessible map alternatives
• Accessible search
• Accessible route instructions
• Captions where needed
• Reduced motion
• High contrast
• No color-only indicators

Maps must have accessible non-map alternatives for critical information.

────────────────────────────────────────

LOCALIZATION

Support:

• Multiple languages
• RTL
• Locale
• Dates
• Times
• Numbers
• Distances
• Units
• Currency
• Time zones

Do not hard-code strings.

────────────────────────────────────────

UNITS

Support:

• Metric
• Imperial

Format:

• Distance
• Speed
• Temperature where later relevant
• Elevation where applicable

Use user preference and locale rules.

────────────────────────────────────────

ERROR HANDLING

Handle:

• Map load failure
• Tile failure
• Search failure
• Autocomplete failure
• Geocoding failure
• Routing failure
• Traffic failure
• Location denial
• Share failure
• Review failure
• Contribution failure
• Offline package failure
• Authentication failure

Provide clear recovery.

────────────────────────────────────────

SECURITY

Implement:

• Protected routes
• Permission-aware navigation
• Safe URL handling
• XSS-safe rendering
• Sensitive-data minimization
• Secure share-link handling
• Secure admin access
• Safe photo uploads
• Authentication-aware location access

Frontend security never replaces backend authorization.

────────────────────────────────────────

TESTING

UNIT:

• Map state
• Route state
• Search state
• Location state
• Geofence state
• Saved-place state
• Review state
• Permission helpers

COMPONENT:

• Map controls
• Search
• Autocomplete
• Place card
• Business card
• Route panel
• Traffic layer
• Incident card
• Review
• Collection
• Share dialog
• Geofence editor
• Admin tables

INTEGRATION:

• API client
• TanStack Query
• Map provider abstraction
• Search
• Directions
• Location
• Sharing
• Reviews

E2E:

CONSUMER

• Search place
• Open place
• Save place
• Create collection
• Search business
• Get directions
• Select route
• View traffic
• Write review
• Share location
• Request privacy export

BUSINESS

• Claim
• Verify
• Update profile
• Update hours
• Add photo
• View analytics

ADMIN

• Search place
• Edit approved field
• Review contribution
• Publish dataset
• Inspect routing graph
• View audit
• Change feature flag
• Roll back configuration

────────────────────────────────────────

PERFORMANCE TESTING

Measure:

• Initial render
• Map startup
• Pan/zoom responsiveness
• Search latency
• Autocomplete latency
• Place-detail load
• Route visualization
• Large result rendering
• Admin-table performance

────────────────────────────────────────

ACCESSIBILITY TESTING

Validate:

• Keyboard
• Screen reader
• Focus
• Search
• Directions
• Route steps
• Tables
• Dialogs
• Map alternatives
• Color contrast
• Reduced motion

────────────────────────────────────────

PROJECT INDEX

Update the frontend Project Index with:

• Applications
• Routes
• Consumer features
• Business features
• Admin features
• Moderation features
• Operations features
• Map renderer
• Map controls
• Map layers
• Search
• Autocomplete
• Places
• Businesses
• Addresses
• Directions
• Routes
• ETA
• Traffic
• Incidents
• Navigation preview
• Current location
• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Contributions
• Geofences
• Location sharing
• Trip sharing
• Offline maps
• Analytics
• Privacy
• Feature flags
• Configuration
• Audit
• API client
• TanStack Query
• Zustand
• Tests
• Accessibility
• Localization
• Performance
• Security
• Generated files
• Modified files
• Remaining work
• Current milestone
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

FRONTEND MILESTONE 1

Next.js foundation, route groups, design system, API client, authentication, themes, error handling, localization, accessibility, and responsive layout.

FRONTEND MILESTONE 2

Map rendering, vector tiles, raster fallback, map controls, styles, layers, markers, clustering, current location, and map performance.

FRONTEND MILESTONE 3

Search, autocomplete, result lists, place details, business details, addresses, categories, hours, photos, and SEO.

FRONTEND MILESTONE 4

Directions, route requests, alternative routes, route visualization, ETA, route steps, traffic, incidents, closures, and navigation preview.

FRONTEND MILESTONE 5

Saved places, favorites, home/work, collections, reviews, ratings, photos, contributions, reports, and geofences.

FRONTEND MILESTONE 6

Location sharing, trip sharing, notifications, privacy settings, location-history controls, data export, deletion, and account management.

FRONTEND MILESTONE 7

Business management, claims, verification, business profile, hours, attributes, photos, reviews, and business analytics.

FRONTEND MILESTONE 8

Administration, map operations, routing operations, traffic operations, search operations, moderation, fraud, analytics, feature flags, configuration, audit, and privacy administration.

FRONTEND MILESTONE 9

Performance optimization, responsive optimization, accessibility hardening, localization, SEO, security hardening, error recovery, and browser compatibility.

FRONTEND MILESTONE 10

Unit tests, component tests, integration tests, E2E tests, accessibility tests, performance tests, security tests, regression tests, production smoke tests, documentation, and Project Index completion.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must compile before proceeding.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate files.

Never summarize source code instead of generating it.

Never generate pseudo-code.

Never generate placeholders.

Never generate TODO implementations.

When modifying an existing file:

1. Provide the exact file path.
2. State why it must change.
3. Provide the complete updated file.

Never regenerate unchanged files.

────────────────────────────────────────

SCOPE RESTRICTION

This prompt covers the production web frontend.

Do not implement:

• Backend
• Mobile
• Infrastructure
• Terraform
• Kubernetes
• CI/CD

Consume the approved backend APIs exactly.

Do not redesign geospatial data structures, routing algorithms, database models, or server-side authorization.

────────────────────────────────────────

QUALITY BAR

Treat the web application as a production global mapping platform supporting:

• Hundreds of millions of users
• Billions of map-tile requests
• Massive search traffic
• Large routing workloads
• Millions of active map sessions
• Large place datasets
• Business platforms
• Location-sharing workloads
• Multiple regions
• Multiple languages
• Strict privacy
• Strict security

Prioritize:

• Fast map startup
• Smooth map interaction
• Low-latency search
• Fast autocomplete
• Clear directions
• Reliable route visualization
• Strong location privacy
• Accessible map alternatives
• Responsive layouts
• Secure sharing
• Maintainability
• Scalability
• Production readiness
