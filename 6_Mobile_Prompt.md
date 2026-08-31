You are operating in Senior Engineering Team Mode.

Build the production-ready mobile applications for an enterprise-scale global mapping, places, search, directions, navigation, traffic, location, offline-map, and location-sharing platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

The mobile applications must consume the approved backend APIs and contracts for:

• Identity
• Accounts
• Profiles
• Devices
• Location
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
• Location sharing
• Trip sharing
• Geofences
• Offline maps
• Notifications
• Moderation
• Privacy
• Analytics
• Administration where applicable

Do not redesign the backend.

Do not implement backend code.

Do not implement web frontend code.

Do not implement infrastructure code.

Do not generate Terraform.

Do not generate Kubernetes manifests.

Do not generate CI/CD workflows.

────────────────────────────────────────

MISSION

Build production-ready iOS and Android applications supporting:

CONSUMER

• Interactive maps
• Current location
• Search
• Autocomplete
• Place discovery
• Place details
• Business details
• Nearby search
• Directions
• Route selection
• ETA
• Traffic
• Incidents
• Closures
• Turn-by-turn navigation
• Off-route detection
• Rerouting
• Saved places
• Favorites
• Home/work
• Collections
• Reviews
• Ratings
• Photos
• Location sharing
• Trip sharing
• Geofencing
• Offline maps
• Offline search
• Offline routing foundation
• Notifications
• Account settings
• Privacy controls

BUSINESS

• Business profile
• Business claim
• Verification status
• Hours
• Special hours
• Attributes
• Photos
• Reviews
• Analytics foundation

CONTRIBUTOR

• Add place
• Edit place
• Report incorrect information
• Suggest closure
• Suggest road correction
• Upload photo
• Contribution status

The applications must be:

• Fast
• Smooth
• Battery-conscious
• Data-efficient
• Secure
• Accessible
• Offline-aware
• Network-resilient
• Production-ready

────────────────────────────────────────

TECHNOLOGY STACK

Framework:

• React Native
• Expo
• TypeScript

Navigation:

• React Navigation

Server state:

• TanStack Query

Client state:

• Zustand

Forms:

• React Hook Form
• Zod

Secure storage:

• Expo Secure Store
• Platform-secure storage abstractions

Local persistence:

• SQLite or approved persistence layer

Maps:

• Provider-neutral native map abstraction

Location:

• Expo Location or approved native abstraction

Notifications:

• Firebase Cloud Messaging
• Apple Push Notification Service

Real-time:

• WebSockets
• Socket.IO client where appropriate

Media:

• Expo Image Picker
• Expo Media Library
• Camera APIs

Testing:

• Jest
• React Native Testing Library
• Detox or approved E2E framework

────────────────────────────────────────

MOBILE ARCHITECTURE

Use:

• Feature-first architecture
• Strict TypeScript
• Reusable components
• Explicit navigation boundaries
• Platform abstraction
• Secure-storage boundaries
• Local persistence boundaries
• Network abstraction
• Map abstraction
• Location abstraction
• Offline abstraction
• Real-time abstraction
• Server-state/client-state separation

Do not place backend business logic inside screens.

Do not make local mobile state authoritative over backend state.

────────────────────────────────────────

APPLICATION STRUCTURE

Create:

src/

features/

components/

navigation/

screens/

layouts/

providers/

hooks/

services/

stores/

database/

storage/

network/

map/

location/

routing/

navigation/

traffic/

search/

places/

businesses/

saved-places/

collections/

reviews/

photos/

contributions/

sharing/

geofencing/

offline/

notifications/

privacy/

analytics/

config/

types/

utils/

assets/

tests/

────────────────────────────────────────

EXPO FOUNDATION

Implement:

• Expo configuration
• iOS configuration
• Android configuration
• App metadata
• Bundle identifiers
• Deep links
• Universal links/app links
• Location permissions
• Background location configuration
• Notification configuration
• Map configuration
• Camera/media permissions
• Secure storage configuration
• Environment configuration

Separate:

• Development
• Test
• Staging
• Production

Never put private provider secrets in the mobile application.

────────────────────────────────────────

NAVIGATION

Use React Navigation.

Primary tabs:

• Explore
• Directions/Navigation
• Saved
• Contributions
• Profile

Support:

• Stack navigation
• Modal navigation
• Bottom sheets
• Search
• Place details
• Business details
• Route preview
• Navigation
• Settings

Navigation is never a security boundary.

────────────────────────────────────────

DESIGN SYSTEM

Create reusable components:

• Button
• IconButton
• TextInput
• SearchInput
• Avatar
• Badge
• BottomSheet
• Modal
• Dialog
• Snackbar
• Toast
• Tabs
• SegmentedControl
• Chip
• Card
• ListItem
• Progress
• Slider
• Skeleton
• EmptyState
• ErrorState
• LoadingState
• MapControl
• MapButton
• SearchResult
• PlaceCard
• BusinessCard
• RouteCard
• RouteSummary
• RouteOption
• TurnStep
• TrafficLegend
• IncidentCard
• SavedPlaceCard
• CollectionCard
• ReviewCard
• RatingDisplay
• PhotoGallery
• ContributionForm
• ShareSheet
• ReportSheet
• GeofenceEditor
• OfflineRegionCard
• DownloadProgress
• AnalyticsCard

Support:

• Safe areas
• Dynamic Type
• Dark mode
• Accessibility
• Haptics where appropriate

────────────────────────────────────────

THEME

Support:

• Light
• Dark
• System

Persist theme preference.

Respect:

• Reduced motion
• High contrast
• Dynamic Type
• Platform accessibility settings

────────────────────────────────────────

AUTHENTICATION

Implement:

• Registration
• Login
• Logout
• Session restoration
• Token refresh
• Email verification
• Password reset
• Password change
• Device registration
• Session expiration

Prepare for:

• OAuth
• MFA
• Passkeys

Store credentials only in secure storage.

────────────────────────────────────────

NETWORKING

Implement typed API client supporting:

• HTTPS
• Authentication
• Request IDs
• Correlation IDs
• Timeout
• Cancellation
• Retry where safe
• Error normalization
• Idempotency
• Cursor pagination

Never blindly retry:

• Place edits
• Reviews
• Contributions
• Navigation mutations
• Privacy actions

unless they use safe idempotency semantics.

────────────────────────────────────────

CONNECTIVITY

Handle:

• Online
• Offline
• Weak network
• High latency
• Packet loss
• Wi-Fi/cellular transition
• Reconnection

Provide centralized connectivity state.

On reconnect:

1. Refresh critical backend state.
2. Reconcile current route.
3. Reconcile navigation session.
4. Reconcile offline package versions.
5. Reconcile pending safe mutations.
6. Reconnect real-time channels.

────────────────────────────────────────

MAP RENDERING

Build a native map abstraction supporting:

• Vector maps
• Raster fallback
• Map styles
• Light
• Dark
• Accessibility style
• Markers
• Clusters
• Polylines
• Polygons
• Traffic
• Incidents
• Closures
• Route geometry
• Current location
• Saved places
• Geofences

Do not bind the entire application directly to one map provider.

────────────────────────────────────────

MAP CAMERA

Support:

• Center
• Zoom
• Bearing
• Pitch where available
• Fit bounds
• Fit route
• Follow location
• Reset orientation
• Search-result focus

Navigation mode should allow camera follow.

────────────────────────────────────────

MAP CONTROLS

Provide:

• Current location
• Zoom
• Compass
• Layers
• Traffic
• Directions
• Save
• Share
• Offline maps

Controls must be accessible.

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

────────────────────────────────────────

CURRENT LOCATION

Request location permission with clear explanation.

Display:

• Current coordinate
• Accuracy
• Heading where available

Do not continuously collect location when the product does not require it.

────────────────────────────────────────

LOCATION PERMISSIONS

Support:

• While using app
• Always/background where required

Explain:

• Why permission is required
• Whether it is optional
• What functionality changes if denied

Never attempt to bypass OS permissions.

────────────────────────────────────────

LOCATION UPDATES

During active navigation:

• Use appropriate update frequency
• Adapt to speed/travel mode
• Reduce frequency when stationary
• Handle weak GPS
• Handle indoor conditions

Avoid unnecessary battery consumption.

────────────────────────────────────────

MAP FOLLOW MODE

Support:

• Free exploration
• Follow location
• Navigation follow mode

When user pans the map during navigation:

• Pause automatic camera following
• Provide "recenter" control
• Restore follow on explicit action

────────────────────────────────────────

SEARCH

Implement global search.

Support:

• Search field
• Autocomplete
• Recent searches
• Places
• Businesses
• Addresses
• Roads
• Categories
• Nearby results

Debounce requests.

Cancel stale requests.

────────────────────────────────────────

AUTOCOMPLETE

Support:

• Geographic bias
• Current location
• Region
• Language
• Category
• Session

Display:

• Place
• Business
• Address
• Road

────────────────────────────────────────

SEARCH RESULTS

Display:

• Name
• Address
• Category
• Distance
• Rating
• Business status
• Relevant metadata

When selected:

• Center map
• Select marker
• Open place details

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

Respect status and visibility.

────────────────────────────────────────

BUSINESS DETAILS

Display:

• Name
• Address
• Hours
• Special hours
• Phone
• Website
• Categories
• Attributes
• Photos
• Rating
• Reviews
• Directions
• Save
• Share

────────────────────────────────────────

OPEN-NOW

Use backend/server-provided hours and the place's local timezone.

Do not determine business state only from device timezone.

────────────────────────────────────────

DIRECTIONS

Build route planning UI.

Support:

• Origin
• Destination
• Waypoints
• Driving
• Walking
• Cycling
• Transit foundation

Options:

• Fastest
• Shortest
• Avoid tolls
• Avoid highways
• Avoid ferries
• Accessible route

────────────────────────────────────────

ROUTE REQUEST

Send route requests to backend.

Display:

• Primary route
• Alternatives
• Distance
• Duration
• ETA
• Traffic
• Warnings
• Tolls

Never calculate the authoritative route entirely on the client.

────────────────────────────────────────

ROUTE VISUALIZATION

Render:

• Origin
• Destination
• Waypoints
• Primary route
• Alternative routes
• Traffic
• Incidents
• Closures

Automatically fit the route to the viewport.

────────────────────────────────────────

ROUTE SELECTION

When selecting route:

• Highlight selected route
• Update summary
• Update ETA
• Update route steps
• Update navigation state

────────────────────────────────────────

NAVIGATION

Implement full navigation experience.

Support:

• Start
• Pause
• Resume
• Cancel
• Complete
• Destination reached

Display:

• Current maneuver
• Next maneuver
• Distance
• ETA
• Remaining time
• Remaining distance
• Street
• Traffic warnings
• Closure warnings

────────────────────────────────────────

TURN-BY-TURN

Support maneuvers:

• Continue
• Left
• Right
• U-turn
• Merge
• Keep
• Fork
• Roundabout
• Exit
• Arrival

Provide spoken instructions where permitted.

────────────────────────────────────────

VOICE GUIDANCE

Create abstraction for voice/navigation instructions.

Support:

• Text-to-speech
• Language
• Volume
• Mute
• Guidance frequency
• Audio interruptions

Do not hard-code speech implementation into navigation business logic.

────────────────────────────────────────

AUDIO INTERRUPTIONS

Handle:

• Phone calls
• Music
• Podcasts
• Other audio
• Bluetooth
• Headphones

Navigation should resume guidance correctly.

────────────────────────────────────────

NAVIGATION CAMERA

Support:

• Follow current position
• Dynamic zoom
• Bearing
• Pitch
• Recenter
• Free map mode

Avoid excessive camera updates.

────────────────────────────────────────

OFF-ROUTE DETECTION

Use server-provided or client-supported navigation rules based on:

• Route geometry
• Current location
• Accuracy
• Heading
• Speed

Avoid rerouting caused by GPS jitter.

────────────────────────────────────────

REROUTING

Triggers:

• Confirmed off-route
• Road closure
• Major traffic change
• Destination change
• User deviation

During rerouting:

• Keep current navigation state
• Show rerouting indicator
• Avoid blank navigation screen
• Replace route only after valid result

────────────────────────────────────────

REROUTE RESILIENCE

If network unavailable:

• Continue using current route
• Use offline routing when available
• Preserve navigation state
• Retry online route updates when connected

────────────────────────────────────────

TRAFFIC

Display:

• Traffic layer
• Congestion
• Incidents
• Closures
• Construction

Use backend authoritative data.

────────────────────────────────────────

TRAFFIC LEGEND

Provide clear accessible legend:

• Normal
• Moderate
• Heavy
• Severe
• Unknown/stale

Do not rely on color alone.

────────────────────────────────────────

INCIDENTS

Display:

• Type
• Severity
• Description
• Location
• Effective state

Tap marker for details.

────────────────────────────────────────

ROAD CLOSURES

Show closure effects on:

• Map
• Route
• Navigation
• Rerouting

────────────────────────────────────────

SAVED PLACES

Support:

• Save
• Unsave
• Favorites
• Home
• Work
• Custom labels

Require authentication.

────────────────────────────────────────

HOME / WORK

Treat as sensitive.

Protect from:

• Public share
• URL exposure
• Search history exposure
• Analytics exposure

────────────────────────────────────────

COLLECTIONS

Support:

• Create
• Rename
• Delete
• Add place
• Remove place
• Reorder
• Share where backend allows

────────────────────────────────────────

REVIEWS

Support:

• Read reviews
• Write review
• Edit own review
• Delete own review
• Rating
• Photos
• Report

────────────────────────────────────────

REVIEW COMPOSER

Support:

• Rating
• Text
• Photo attachments
• Validation
• Submit
• Retry
• Draft

Do not lose user-entered review content due to temporary network failure.

────────────────────────────────────────

PHOTOS

Support:

• Select from device
• Camera
• Preview
• Upload
• Progress
• Retry
• Cancel
• Delete own photo

Use backend authorization.

────────────────────────────────────────

CONTRIBUTIONS

Support:

• Add place
• Edit place
• Report incorrect data
• Suggest closure
• Report road issue
• Add photo

Display:

• Draft
• Submitted
• Reviewing
• Approved
• Rejected
• Published
• Reverted

────────────────────────────────────────

BUSINESS MANAGEMENT

Support authorized business users:

• Profile
• Hours
• Special hours
• Attributes
• Photos
• Reviews
• Claim state
• Verification state
• Analytics

────────────────────────────────────────

LOCATION SHARING

Support:

• Current location share
• Live location
• Recipient/access
• Expiration
• Revoke
• Share status

Use short-lived secure access.

────────────────────────────────────────

TRIP SHARING

Support:

• Route
• ETA
• Current location
• Destination
• Navigation status
• Expiration
• Revoke

Never expose unrelated location history.

────────────────────────────────────────

GEOFENCING

Support:

• Circle
• Polygon
• Create
• Edit
• Delete
• Enable/disable
• Trigger type
• Expiration

Triggers:

• Enter
• Exit
• Dwell

────────────────────────────────────────

OFFLINE MAPS

Build offline-map UI.

Support:

• Region discovery
• Region selection
• Download
• Pause
• Resume
• Update
• Delete
• Storage information
• Version
• Package state

────────────────────────────────────────

OFFLINE DOWNLOAD

Display:

• Download size
• Progress
• Remaining size
• Wi-Fi-only setting
• Battery-aware behavior
• Failure/retry

Use checksums/package manifests to verify integrity.

────────────────────────────────────────

OFFLINE MAP STORAGE

Manage:

• Storage quota
• Used storage
• Available storage
• Package expiration
• Outdated versions

Warn before removing or replacing large packages.

────────────────────────────────────────

OFFLINE SEARCH

Where backend package supports it:

• Search within downloaded region
• Places
• Addresses
• Roads

Clearly indicate when results are offline-only.

────────────────────────────────────────

OFFLINE ROUTING

Support local routing when an appropriate regional routing package is installed.

Handle:

• Offline route
• Offline reroute
• Missing region
• Outdated graph
• Corrupt graph
• Reconnect to online routing

────────────────────────────────────────

OFFLINE NAVIGATION

During network loss:

• Continue active route
• Maintain turn instructions
• Maintain current route
• Use offline graph where available
• Degrade gracefully if unavailable

Never display fabricated traffic conditions while offline.

────────────────────────────────────────

NOTIFICATIONS

Support push notifications for:

• Traffic
• Route changes
• Navigation events
• Saved-place events
• Contribution status
• Business updates
• Security
• Privacy

Handle:

• Permission
• Device token
• Deep link
• Badge
• Foreground notification
• Background notification

────────────────────────────────────────

DEEP LINKS

Support links for:

• Places
• Businesses
• Addresses
• Routes
• Navigation
• Collections
• Reviews
• Contributions
• Offline regions
• Location shares
• Trip shares

Validate server authorization after opening.

────────────────────────────────────────

PRIVACY

Support:

• Location permission guidance
• Location-history controls
• Search-history controls
• Saved-place controls
• Location-sharing controls
• Geofence controls
• Data export
• Data deletion
• Account deletion

────────────────────────────────────────

DATA EXPORT

Allow:

• Request
• Status
• Progress
• Secure download when ready

Use backend-authoritative status.

────────────────────────────────────────

ACCOUNT DELETION

Support:

• Request
• Confirmation
• Re-authentication when required
• Status
• Cancellation where available

Do not imply immediate deletion if backend has retention periods.

────────────────────────────────────────

BACKGROUND PROCESSING

Handle:

• Background location
• Navigation
• Offline downloads
• Uploads where applicable

Respect:

• OS background limits
• Battery
• User settings
• Permissions

────────────────────────────────────────

BATTERY OPTIMIZATION

Navigation may require frequent location updates, but outside navigation:

• Reduce sampling
• Stop location when unnecessary
• Avoid continuous polling
• Minimize background work
• Suspend inactive WebSockets

────────────────────────────────────────

DATA USAGE

Support:

• Wi-Fi-only offline downloads
• Reduced data preference
• Limited prefetch
• Adaptive map quality
• Efficient tile loading

────────────────────────────────────────

MEMORY MANAGEMENT

Avoid:

• Keeping many map surfaces alive
• Unbounded search results
• Unbounded review lists
• Large image memory
• Duplicate route objects

Use:

• Virtualized lists
• Resource cleanup
• Cache limits
• Lifecycle-aware screens

────────────────────────────────────────

SECURITY

Implement:

• Secure storage
• Safe deep links
• Secure location sharing
• Secure offline package access
• Permission-aware UI
• Sensitive-data minimization
• Safe local persistence
• Token handling

Never store:

• Passwords
• Cloud credentials
• Permanent share tokens
• Provider secrets

────────────────────────────────────────

ACCESSIBILITY

Support:

• VoiceOver
• TalkBack
• Dynamic Type
• Large text
• Screen-reader labels
• Large touch targets
• Captions/visual equivalents where appropriate
• Reduced motion
• High contrast
• Accessible map alternatives

Navigation instructions must be accessible beyond map visualization alone.

────────────────────────────────────────

LOCALIZATION

Support:

• Multiple languages
• RTL
• Dates
• Times
• Numbers
• Distances
• Units
• Currency where business data uses it
• Time zones

Do not hard-code strings.

────────────────────────────────────────

UNITS

Support:

• Metric
• Imperial

Use backend/device/user preference appropriately.

────────────────────────────────────────

ERROR HANDLING

Handle:

• GPS unavailable
• Permission denied
• Weak GPS
• Map load failure
• Tile failure
• Search failure
• Geocoding failure
• Route failure
• Traffic failure
• Navigation failure
• Reroute failure
• Offline package failure
• Review failure
• Contribution failure
• Share failure
• Authentication failure

Provide useful recovery actions.

────────────────────────────────────────

TESTING

UNIT TESTS

Test:

• Coordinate utilities
• Route state
• Navigation state
• Offline state
• Search state
• Saved-place state
• Review state
• Contribution state
• Share state
• Permission helpers

COMPONENT TESTS

Test:

• Map controls
• Search
• Autocomplete
• Place card
• Business card
• Directions
• Route options
• Navigation header
• Turn step
• Traffic layer
• Reviews
• Collections
• Offline maps
• Geofence editor
• Sharing

INTEGRATION TESTS

Test:

• Authentication
• API client
• TanStack Query
• Map abstraction
• Location
• Routing
• Navigation
• Offline packages
• Notifications
• Deep links

────────────────────────────────────────

E2E TESTS

CONSUMER:

• Register
• Login
• Search a place
• Open place
• Save place
• Create collection
• Get directions
• Select route
• Start navigation
• Go off-route
• Reroute
• View traffic
• Write review
• Share location
• Share trip
• Download offline region
• Navigate offline
• Request privacy export

BUSINESS:

• Claim business
• View verification
• Update hours
• Update profile
• Add photo
• View reviews

CONTRIBUTOR:

• Add place
• Edit place
• Report issue
• Check contribution status

────────────────────────────────────────

LOCATION TESTING

Test:

• Permission granted
• Permission denied
• Approximate location
• Precise location
• GPS jitter
• Stale location
• Background behavior
• Navigation updates
• Battery impact

────────────────────────────────────────

NAVIGATION TESTING

Test:

• Start
• Pause
• Resume
• Destination reached
• Off-route
• Reroute
• Network loss
• GPS loss
• Tunnel-like connectivity loss
• Offline routing
• Traffic update
• Closure

────────────────────────────────────────

OFFLINE TESTING

Test:

• Download
• Pause
• Resume
• Corruption
• Checksum failure
• Version update
• Delete
• Storage exhaustion
• Offline search
• Offline routing
• Reconnect

────────────────────────────────────────

NETWORK TESTING

Simulate:

• Offline
• Weak cellular
• High latency
• Packet loss
• Wi-Fi/cellular transition
• Reconnect

Verify:

• No duplicate actions
• Navigation remains stable
• Downloads resume
• Reviews are not lost
• Contributions are not duplicated

────────────────────────────────────────

PLATFORM TESTING

Test across:

• Supported iOS versions
• Supported Android versions
• Small screens
• Large screens
• Different aspect ratios
• Low-memory devices
• Low-battery scenarios
• Poor-GPS scenarios

────────────────────────────────────────

PERFORMANCE TESTING

Measure:

• Cold startup
• Warm startup
• Map startup
• Search latency
• Autocomplete latency
• Route request latency
• Navigation frame rate
• Map rendering
• Memory
• Battery
• Tile/network usage
• Offline download throughput

────────────────────────────────────────

ACCESSIBILITY TESTING

Validate:

• VoiceOver
• TalkBack
• Dynamic Type
• Large text
• Focus
• Touch targets
• Screen-reader labels
• Navigation instructions
• Search
• Reviews
• Forms
• Offline-map management

────────────────────────────────────────

DOCUMENTATION

Generate:

• Mobile architecture
• Consumer application
• Business application
• Navigation
• Map rendering
• Search
• Autocomplete
• Places
• Businesses
• Directions
• Routing
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Turn-by-turn
• Voice guidance
• Location
• Location permissions
• Location sharing
• Trip sharing
• Geofencing
• Saved places
• Collections
• Reviews
• Photos
• Contributions
• Offline maps
• Offline search
• Offline routing
• Notifications
• Deep links
• Privacy
• Battery optimization
• Data usage
• Memory management
• Security
• Accessibility
• Localization
• Testing

────────────────────────────────────────

PROJECT INDEX

Update the mobile Project Index with:

• Consumer app
• Business app
• Contributor flows
• Screens
• Navigation
• Components
• Hooks
• Stores
• API client
• Map abstraction
• Location abstraction
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
• Closures
• Navigation
• Turn-by-turn
• Voice guidance
• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Contributions
• Location sharing
• Trip sharing
• Geofencing
• Offline maps
• Offline search
• Offline routing
• Notifications
• Deep links
• Privacy
• Secure storage
• Local database
• Tests
• Accessibility
• Performance
• Localization
• Security
• Dependencies
• Generated files
• Modified files
• Remaining work
• Current milestone

────────────────────────────────────────

IMPLEMENTATION MILESTONES

MOBILE MILESTONE 1

Expo foundation, navigation, design system, API client, authentication, secure storage, connectivity, theme, permissions, and error handling.

MOBILE MILESTONE 2

Map rendering, map styles, controls, layers, current location, search, autocomplete, places, businesses, and nearby discovery.

MOBILE MILESTONE 3

Directions, route requests, alternative routes, route visualization, ETA, traffic, incidents, closures, and route preview.

MOBILE MILESTONE 4

Full navigation, location updates, navigation camera, turn-by-turn, voice guidance, off-route detection, rerouting, and navigation resilience.

MOBILE MILESTONE 5

Saved places, favorites, home/work, collections, reviews, ratings, photos, contributions, and reporting.

MOBILE MILESTONE 6

Location sharing, trip sharing, geofencing, notifications, deep links, privacy settings, and account controls.

MOBILE MILESTONE 7

Offline regions, downloads, package validation, offline search, offline routing, offline navigation, storage management, and synchronization.

MOBILE MILESTONE 8

Business management, claims, verification, hours, attributes, photos, reviews, and business analytics.

MOBILE MILESTONE 9

Battery optimization, memory optimization, network resilience, background execution, accessibility, localization, performance, and security hardening.

MOBILE MILESTONE 10

Unit tests, component tests, integration tests, E2E tests, navigation tests, offline tests, accessibility tests, performance tests, security tests, production smoke tests, documentation, and Project Index completion.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must compile before proceeding.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate code.

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

This prompt covers the mobile consumer, business, and contribution experiences.

Do not implement:

• Backend
• Web frontend
• Infrastructure
• Terraform
• Kubernetes
• CI/CD

Consume the approved backend contracts exactly.

Do not redesign:

• Geospatial data models
• Routing APIs
• Navigation server contracts
• Search contracts
• Privacy policies
• Authorization rules
