Naiki Mobile Application
Complete Technical Documentation
________________________________________
Table of Contents
1.	Project Introduction
2.	Technology Stack
3.	App Architecture
4.	State Management with Riverpod
5.	Screens Overview
6.	Features & Functionality
7.	Models Used
8.	Navigation Flow
9.	Scalability, Maintainability & Reusability
10.	Conclusion
________________________________________
1. Project Introduction
1.1 What is Naiki?
Naiki (also known as Charity Bridge) is a comprehensive mobile charity platform built with Flutter that connects underprivileged women recipients (Mustahiq) with generous donors (Mutasaddiq) in a transparent, secure, and efficient manner. The platform facilitates Islamic charitable giving including Sadqah, Zakat, Khairat, and Fitra through a modern, user-friendly mobile interface.
1.2 Purpose and Vision
The Naiki app was created to address the critical gap in Pakistan's charitable ecosystem where deserving recipients, particularly women, struggle to access financial assistance while potential donors lack transparent channels to ensure their contributions reach those genuinely in need. Traditional charity methods often lack accountability, verification, and direct connection between givers and recipients.
1.3 Target Users
The application serves three distinct user roles:
Recipients (Mustahiq)
•	Underprivileged women seeking financial assistance
•	Individuals requiring support for specific needs (medical, education, housing, business)
•	Verified beneficiaries who can create charity requests and share their stories
Donors (Mutasaddiq)
•	Individuals committed to Islamic charitable giving
•	Philanthropists seeking transparent and accountable donation channels
•	Users wanting direct connection with recipients and impact visibility
Administrators
•	Platform managers responsible for user verification
•	Quality control personnel ensuring authenticity of requests
•	Support staff managing platform integrity and user assistance
1.4 Problem Statement
The app addresses several critical challenges:
•	Lack of Transparency: Traditional charity channels often lack visibility into where donations go and how they are used
•	Verification Challenges: Difficulty in verifying the authenticity of recipients and their needs
•	Limited Access: Deserving women recipients face barriers in accessing charitable resources
•	Donor Trust Issues: Donors are uncertain whether their contributions reach genuine beneficiaries
•	No Impact Tracking: Absence of mechanisms to see the real-world impact of donations
•	Payment Complexity: Complicated payment processes discourage charitable giving
1.5 Key Objectives
The Naiki mobile application aims to achieve the following objectives:
1.	Enable Transparent Charity: Create a clear, verifiable pathway from donor to recipient with complete visibility
2.	Simplify Donation Process: Provide an intuitive mobile interface supporting multiple payment methods (Easypaisa, JazzCash, bank transfers)
3.	Ensure Authenticity: Implement rigorous verification processes including CNIC verification, document validation, and photo uploads
4.	Empower Recipients: Give women recipients a dignified platform to share their stories and requests
5.	Build Trust: Foster confidence through verification badges, thank-you messages, and impact updates
6.	Support Islamic Values: Facilitate Zakat calculation, Sadqah giving, and other forms of Islamic charity
7.	Enable Impact Tracking: Allow donors to see tangible results of their contributions
8.	Provide Multi-Language Support: Offer Urdu and English interfaces to maximize accessibility
9.	Ensure Offline Capability: Support offline data caching for areas with limited connectivity
10.	Scale for Growth: Build an architecture that can accommodate thousands of users and requests
________________________________________
2. Technology Stack
2.1 Core Framework
Flutter (Cross-Platform Framework)
Flutter serves as the foundation of the Naiki mobile application, providing several critical advantages:
•	Single Codebase: Develop simultaneously for both iOS and Android platforms, reducing development time and maintenance overhead by approximately 50%
•	Native Performance: Compiled to native ARM code ensures smooth animations and fast rendering comparable to native applications
•	Rich UI Components: Material Design and Cupertino widgets enable creation of beautiful, platform-specific interfaces
•	Hot Reload: Instant preview of changes during development accelerates the iteration process
•	Growing Ecosystem: Access to thousands of packages and plugins through pub.dev
•	Strong Community: Backed by Google with extensive documentation and community support
Dart Programming Language
Dart serves as the programming language, offering:
•	Type Safety: Strong typing reduces runtime errors and improves code reliability
•	Asynchronous Programming: Built-in async/await pattern simplifies handling of network requests and database operations
•	Null Safety: Sound null safety eliminates null reference errors
•	Performance: Ahead-of-time compilation produces efficient native code
•	Readability: Clean, modern syntax enhances code maintainability
2.2 State Management
Riverpod
Riverpod is the chosen state management solution for Naiki, selected over alternatives like Provider, Bloc, and GetX for several compelling reasons:
Why Riverpod?
1.	Compile-Time Safety: Riverpod provides compile-time error checking, catching state management issues before runtime
2.	No BuildContext Dependency: Unlike Provider, Riverpod can be accessed without BuildContext, enabling cleaner service layer code
3.	Testability: Complete separation of business logic from UI makes unit testing straightforward
4.	Performance: Automatic optimization rebuilds only affected widgets when state changes
5.	Scoping: Easy creation of scoped providers for feature-specific state management
6.	DevTools Integration: Excellent debugging capabilities through Riverpod Inspector
7.	Future-Proof: Modern approach that aligns with Flutter's evolution
Riverpod Benefits for Naiki
•	Scalability: As the app grows with more features (payment gateways, advanced analytics, real-time notifications), Riverpod's architecture accommodates expansion seamlessly
•	Readability: Clear separation between UI, business logic, and state makes the codebase approachable for new developers
•	Maintainability: Modular provider structure allows updating specific features without affecting others
•	Performance Optimization: Fine-grained reactivity ensures smooth performance even with complex state
2.3 Additional Libraries and Tools
Network & API
•	Dio: Advanced HTTP client for API requests with interceptor support for authentication, logging, and error handling
•	JSON Annotation: Automatic JSON serialization and deserialization for API responses
Local Storage
•	Flutter Secure Storage: Encrypted storage for sensitive information like authentication tokens and user credentials
Media Handling
•	Image Picker: Capture and select photos from camera or gallery for profile pictures and document uploads
•	File Picker: Select documents, PDFs, and other files for CNIC and verification document uploads
UI Components
•	Flutter Localizations: Built-in internationalization support for Urdu and English languages
•	Intl: Formatting utilities for dates, currencies, and phone numbers according to Pakistani standards
Payment Integration
•	Custom Payment Flow: Manual payment confirmation
Development Tools
•	Build Runner: Code generation for JSON serialization and Riverpod providers
•	Flutter Lints: Code quality enforcement through static analysis
•	Logger: Structured logging for debugging and error tracking
________________________________________
3. App Architecture
3.1 Architectural Philosophy
The Naiki app follows a Feature-First, Layered Architecture approach that combines the benefits of modular feature organization with clean separation of concerns across layers. This architecture ensures:
•	Separation of Concerns: Each layer has distinct responsibilities
•	Testability: Isolated layers can be tested independently
•	Scalability: New features can be added without affecting existing code
•	Maintainability: Clear structure makes the codebase easy to navigate and modify
•	Reusability: Shared components and utilities reduce code duplication
3.2 Project Structure Overview
The project is organized into five main directories under the lib folder:
Core: Foundation layer containing configuration, networking, platform utilities, and shared constants
Data: Data layer managing models, repositories, and service classes for API communication
Features: Feature-first modules where each major feature (auth, recipient, donor) is self-contained
Shared: Reusable UI components, widgets, and constants used across features
Providers: Global application-level providers for authentication state, user roles, and environment configuration
3.3 Detailed Layer Structure
Core Layer (lib/core/)
The core layer provides fundamental infrastructure used throughout the application:
Configuration (core/config/)
•	app_routes.dart: Centralized route definitions for navigation, maintaining all screen paths in one location
•	app_theme.dart: Theme configuration defining color roles for primary, recipient, donor, and admin interfaces
•	env.dart: Environment management for development and production flags, API base URLs
Network (core/network/)
•	api_base.dart: Base URL configuration for different environments (dev, staging, production)
•	base_api_service.dart: Low-level HTTP wrapper handling request/response lifecycle
•	api_service.dart: High-level service with authentication, token refresh, and centralized request handling
Platform (core/platform/)
•	secure_storage.dart: Secure encrypted storage for authentication tokens and sensitive user metadata
•	local_db.dart: Hive/SQLite wrapper for offline data caching and persistence
•	file_picker.dart: Unified interface for document and photo selection across platforms
Utilities (core/utils/)
•	date_utils.dart: Date formatting and manipulation utilities
•	formatters.dart: Currency formatting (PKR), phone number formatting (+92)
•	validators.dart: Input validation for CNIC, phone numbers, email addresses, IBAN
Constants (core/constants/)
•	api_endpoints.dart: API endpoint definitions for all backend services
•	app_constants.dart: Application-wide constants
•	charity_types.dart: Definitions for Sadqah, Zakat, Khairat, Fitra types
Exceptions (core/exceptions/)
•	api_exception.dart: Custom exception classes for API errors
•	verification_exception.dart: Specific exceptions for verification process failures
Data Layer (lib/data/)
The data layer manages all data-related operations including API communication, local storage, and data transformation:
Models (data/models/)
Models represent the data structures used throughout the application:
•	user_model.dart: Base user model with common properties (ID, name, phone, role)
•	recipient_model.dart: Extended model for women recipients including story, verification status, location
•	donor_model.dart: Donor-specific model with donation preferences and history
•	verification_model.dart: Verification status, document references, approval/rejection data
•	charity_request_model.dart: Charity request details including amount, purpose, urgency, progress
•	donation_model.dart: Donation records linking donors to recipients with amount and payment method
•	thank_you_model.dart: Thank you messages from recipients to donors with text and optional media
•	impact_update_model.dart: Progress updates showing how donated funds were utilized
•	document_model.dart: Document metadata for CNIC, utility bills, photos
•	notification_model.dart: Push notification data structure
•	payment_model.dart: Payment transaction details for Easypaisa, JazzCash, bank transfers
Repositories (data/repositories/)
Repositories implement business logic and coordinate between services and the UI layer:
•	auth_repository.dart: Authentication logic, token management, session handling
•	recipient_repository.dart: Recipient profile operations, request management
•	donor_repository.dart: Donor profile operations, browsing, filtering
•	verification_repository.dart: Verification submission and status checking
•	charity_request_repository.dart: Request creation, editing, status updates
•	donation_repository.dart: Donation processing, history retrieval
•	payment_repository.dart: Payment gateway integration and transaction handling
•	notification_repository.dart: Notification fetching and management
•	admin_repository.dart: Admin operations for verification and moderation
Services (data/services/)
Services handle direct API communication and external integrations:
•	auth_service.dart: API calls for login, registration, logout
•	otp_service.dart: OTP generation, verification, resend functionality
•	recipient_service.dart: Recipient API endpoints
•	donor_service.dart: Donor API endpoints
•	verification_service.dart: Document upload and verification checking
•	charity_request_service.dart: Request CRUD operations
•	donation_service.dart: Donation submission and retrieval
•	payment_service.dart: Payment gateway integration (Easypaisa, JazzCash)
•	file_upload_service.dart: Multipart file upload handling
•	notification_service.dart: Push notification registration and handling
•	admin_service.dart: Admin-specific API operations
Features Layer (lib/features/)
The features layer is organized by user journey, with each feature being self-contained:
Authentication (features/auth/)
Handles user onboarding and authentication:
•	Splash screen with app logo and initialization
•	Onboarding screens explaining app features
•	Role selection (Recipient vs Donor)
•	Phone number registration with country code
•	OTP verification with resend functionality
•	Login for returning users
•	Password recovery flow
Recipient Module (features/recipient/)
Complete recipient workflow including:
•	Profile creation wizard (4 steps: personal info, contact, story writing, review)
•	Verification process (pending, approved, rejected states)
•	Dashboard showing active requests and received donations
•	Request creation with multi-step forms
•	Thank you message submission after receiving donations
•	Impact update creation to show how funds were used
•	Profile editing and history viewing
Donor Module (features/donor/)
Complete donor workflow including:
•	Profile creation with donation preferences
•	Dashboard showing donation summary and impact metrics
•	Browse verified recipients with filtering by need type, location, urgency
•	View detailed recipient profiles and their stories
•	Select donation amount with suggested amounts for different charity types
•	Payment method selection (Easypaisa, JazzCash, Bank Transfer)
•	Payment confirmation and receipt generation
•	Recurring donation setup
•	View received thank you messages and impact updates
•	Complete donation history
Notifications (features/notifications/)
•	Notification center displaying all app notifications
•	Notification settings for customizing alert preferences
Shared Screens (features/shared_screens/)
•	Error screens for various error types
•	No internet connection screen
•	Maintenance mode screen
Shared Layer (lib/shared/)
Contains reusable UI components used across features:
Widgets (shared/widgets/)
Organized into categories:
•	Common: Buttons, text fields, dropdowns, loaders, dialogs
•	Forms: Form progress indicators, specialized input fields (CNIC, phone, currency)
•	Cards: Stats cards, badges, info cards
•	Navigation: Bottom navigation bar, app bars, drawers
•	Charity-Specific: Progress bars, amount displays, charity type chips, urgency indicators
Components (shared/components/)
Small presentational widgets like avatars, dividers, spacers
Constants (shared/constants/)
UI-related constants including colors, text styles, dimensions
Providers Layer (lib/providers/)
Global application-level providers:
•	app_providers.dart: Singleton providers for app-wide services
•	auth_state_provider.dart: Global authentication state
•	user_role_provider.dart: Current user role (recipient/donor/admin)
•	env_providers.dart: Environment and feature flag providers
3.4 Data Flow Architecture
The application follows a unidirectional data flow pattern:
User Interaction → UI Layer → Provider/Notifier → Repository → Service → API → Backend
Response Flow (Reverse Direction):
Backend → API Response → Service → Repository → Provider/Notifier → UI Update
Example Flow: Creating a Charity Request
1.	UI Layer: User fills out the create request form and taps "Submit"
2.	Provider Layer: UI calls method on CharityRequestNotifier
3.	Notifier Layer: Notifier changes state to loading and calls repository
4.	Repository Layer: Transforms UI data into API request format, handles business logic
5.	Service Layer: Makes HTTP POST request to backend API
6.	Backend Processing: Server validates, saves to database, returns response
7.	Service Layer: Receives response, handles errors if any
8.	Repository Layer: Transforms API response into domain model
9.	Notifier Layer: Updates state with new data or error
10.	UI Layer: Rebuilds automatically showing success message or error
This architecture ensures:
•	Clear separation of concerns at each layer
•	Easy testing of business logic without UI dependencies
•	Consistent error handling across the application
•	Predictable state updates and UI rendering
________________________________________
4. State Management with Riverpod
4.1 Introduction to Riverpod
Riverpod (an anagram of "Provider") is a reactive state management and dependency injection framework for Flutter. It builds upon the concepts of the Provider package while addressing its limitations and adding powerful new capabilities.
4.2 Why Riverpod for Naiki?
Traditional Provider Limitations:
•	BuildContext dependency makes it difficult to access state in service layers
•	Runtime errors for provider access mistakes
•	Limited compile-time safety
•	Challenging to test providers in isolation
Riverpod Solutions:
•	No BuildContext required for reading state
•	Compile-time safety catches errors before runtime
•	Excellent testability with provider overrides
•	Better performance through automatic optimization
•	Enhanced debugging capabilities
4.3 Provider Types Used in Naiki
Provider
The most basic provider type, used for exposing immutable objects or services:
Usage in Naiki:
•	Exposing repository instances
•	Providing service singletons
•	Sharing utility classes
Example Scenario: Exposing the authentication repository for use across the app
StateProvider
A simple provider that exposes a way to modify its state:
Usage in Naiki:
•	Simple toggles and flags
•	Current language selection (Urdu/English)
•	Filter selections in donor browse screen
Example Scenario: Managing the currently selected charity type filter
StateNotifierProvider
The most commonly used provider in Naiki, combines state with business logic:
Usage in Naiki:
•	Authentication state with login/logout logic
•	Recipient profile creation with multi-step form state
•	Donor donation flow with payment processing
•	Request creation and management
Example Scenario: Managing the entire recipient profile creation flow including form validation, step progression, and API submission
FutureProvider
Automatically handles async operations and provides loading/data/error states:
Usage in Naiki:
•	Fetching user profile on app launch
•	Loading donation history
•	Retrieving verification status
Example Scenario: Loading the recipient's request list when the dashboard opens
StreamProvider
Similar to FutureProvider but for continuous data streams:
Usage in Naiki:
•	Real-time notification updates
•	Live donation progress updates
•	Payment status monitoring
Example Scenario: Listening to real-time updates on request funding progress
4.4 State Management Patterns in Naiki
Feature State Pattern
Each feature module follows a consistent pattern:
State Definition:
•	Immutable state classes using Freezed or manual immutability
•	Include loading, success, and error states
•	Type-safe state representation
Notifier Implementation:
•	Extends StateNotifier or AsyncNotifier
•	Encapsulates all business logic for the feature
•	Communicates with repository layer
•	Updates state based on operation results
Provider Declaration:
•	Creates StateNotifierProvider linking notifier and state
•	Configured with auto-dispose when appropriate
•	Family providers for parameterized instances
UI Consumption:
•	Widgets use ref.watch() to react to state changes
•	Buttons and forms use ref.read() to trigger actions
•	Loading indicators shown during async operations
•	Error messages displayed when operations fail
Authentication State Management
Structure:
•	AuthState includes user object, authentication status, loading flags
•	AuthNotifier handles login, logout, registration, token refresh
•	Persists tokens to secure storage
•	Updates global auth state affecting navigation
Flow:
1.	User enters credentials on login screen
2.	UI calls authNotifier.login(phone, password)
3.	Notifier sets loading state
4.	Calls authRepository.login()
5.	Repository calls authService API
6.	On success: Save token, update state with user data
7.	On error: Update state with error message
8.	UI rebuilds showing dashboard or error
Recipient Profile State Management
Structure:
•	RecipientProfileState contains form data for all steps
•	RecipientProfileNotifier manages wizard progression
•	Validates each step before allowing advancement
•	Coordinates document uploads
Multi-Step Form Handling:
•	State tracks current step (1-4)
•	Each step's data stored in state
•	Progress indicator calculated from completed steps
•	Final review compiles all data before submission
Donor Browse State Management
Structure:
•	BrowseState includes recipient list, filters, pagination
•	BrowseNotifier handles searching, filtering, sorting
•	Caches results for performance
•	Implements infinite scroll pagination
Filtering System:
•	Multiple filter criteria (need type, location, urgency, verification status)
•	Real-time filter application
•	Preserves scroll position during filter changes
4.5 Scalability Through Riverpod
Clean Architecture: Riverpod enforces separation between UI, business logic, and data layers, making the codebase modular and maintainable.
Easy Testing: Providers can be overridden in tests, allowing complete isolation of logic being tested without complex mocking.
Performance Optimization: Riverpod rebuilds only the widgets that depend on changed state, ensuring smooth performance even with complex screens.
Feature Expansion: Adding new features requires only creating new providers without modifying existing ones, reducing regression risk.
Dependency Injection: All dependencies are managed through providers, making the entire dependency graph visible and modifiable.
4.6 Reading and Updating State in UI
Reading State:
Widgets access state using three main methods:
•	ref.watch(): Rebuilds widget when state changes (reactive)
•	ref.read(): One-time access without rebuilding (for callbacks)
•	ref.listen(): Execute side effects when state changes (show snackbar, navigate)
Updating State:
Actions trigger state updates through notifier methods:
•	User interactions call notifier methods
•	Notifiers perform operations and update state
•	UI automatically rebuilds reflecting new state
Example Pattern:
A donation button demonstrates the complete cycle:
•	Button displays current donation state (idle, processing, success, error)
•	On tap, calls ref.read(donationProvider.notifier).submitDonation()
•	Notifier updates state to loading
•	UI shows loading indicator on button
•	After API call, state updates to success or error
•	UI displays confirmation or error message
4.7 Why This Architecture is Clean and Maintainable
Single Responsibility: Each provider handles one concern, making code easy to understand and modify.
Testability: Business logic lives in notifiers, completely separate from UI, enabling comprehensive unit testing.
Reusability: Providers can be shared across features, reducing duplication.
Type Safety: Compile-time checking catches state access errors early.
Documentation: Provider declarations serve as documentation showing data flow and dependencies.
Debugging: Riverpod DevTools provides visibility into state changes and provider lifecycle.
Future-Proof: Architecture accommodates new features, payment methods, and integrations without major refactoring.
________________________________________
5. Screens Overview
5.1 Authentication Flow Screens
Splash Screen
Purpose: Initial app loading screen displaying the Naiki logo while performing initialization tasks.
UI Elements:
•	Naiki logo prominently displayed in center
•	App name and tagline
•	Loading indicator at bottom
•	Gradient background reflecting brand colors
Actions:
•	Check for existing authentication token in secure storage
•	Initialize app configuration and locale
•	Load cached user data if available
•	Determine appropriate navigation route
Provider Connection:
•	Watches AuthStateProvider to check authentication status
•	Reads UserRoleProvider to determine user type
Navigation:
•	If authenticated: Navigate to role-specific dashboard (recipient/donor)
•	If not authenticated but has seen onboarding: Navigate to login screen
•	If first launch: Navigate to onboarding screens
Onboarding Screens
Purpose: Introduce new users to Naiki's features and value proposition through a multi-page swipeable interface.
UI Elements:
•	Page indicator dots showing progress
•	Beautiful illustrations explaining key features
•	"Skip" button in top-right corner
•	"Next" button to advance pages
•	"Get Started" button on final page
Pages Include:
1.	Welcome page explaining Naiki's mission
2.	Recipient benefits page showing how women can receive help
3.	Donor benefits page showing transparent giving
4.	Verification and trust page highlighting security
Actions:
•	Swipe between pages
•	Skip to role selection
•	Complete onboarding and proceed to role selection
Provider Connection:
•	Updates onboarding completion status in preferences
•	No complex state management required
Navigation:
•	Completed: Navigate to role selection screen
•	Skipped: Navigate to role selection screen
Role Selection Screen
Purpose: Allow new users to identify their primary app usage as either a Recipient or Donor.
UI Elements:
•	Two prominent cards representing each role
•	Recipient card with description: "I need help and want to create requests"
•	Donor card with description: "I want to donate and help others"
•	Icons and colors differentiating the roles
•	Continue button becomes active after selection
Actions:
•	Select role by tapping card
•	Confirm selection and proceed to registration
Provider Connection:
•	Updates UserRoleProvider with selected role
•	Role determines subsequent navigation flow
Navigation:
•	Recipient selected: Navigate to recipient phone registration
•	Donor selected: Navigate to donor phone registration
Recipient Registration Phone Screen
Purpose: Collect user's information for account creation and OTP verification.
UI Elements:
•	Full name input field
•	CNIC number input with auto-formatting (xxxxx-xxxxxxx-x)
•	Date of birth picker
•	Gender selection
•	Marital status dropdown
•	Number of dependents input
•	"SignUp" button
Actions:
•	Submit phone number to receive OTP
•	Switch to login if already registered
Provider Connection:
•	Calls AuthNotifier.sendOTP(phoneNumber)
•	Watches loading state to show button spinner
Navigation:
•	OTP sent successfully: Navigate to OTP verification with phone number passed
•	Already registered error: Show dialog suggesting login
•	Validation errors: Display inline error messages
OTP Verification Screen
Purpose: Verify user's phone number through one-time password sent via SMS.
UI Elements:
•	Phone number display showing where OTP was sent
•	Six-digit OTP input boxes with auto-advance
•	Countdown timer for OTP validity (5 minutes)
•	"Resend OTP" button enabled after countdown
•	"Verify" button to submit OTP
•	Edit phone number option
Actions:
•	Enter 6-digit OTP
•	Auto-submit when all digits entered
•	Resend OTP if expired or not received
•	Go back to edit phone number
Provider Connection:
•	Calls AuthNotifier.verifyOTP(phoneNumber, otp)
•	Manages resend cooldown state
•	Updates auth state on successful verification
Navigation:
•	Verification successful (new user): Navigate to role-specific profile creation
•	Verification successful (existing user): Navigate to role-specific dashboard
•	Verification failed: Show error message and allow retry
Login Screen
Purpose: Allow returning users to authenticate and access their accounts.
UI Elements:
•	Input CNIC
•	Generate OTP
•	"Login" button
Actions:
•	Enter credentials
•	Submit login form
•	Navigate to registration
Provider Connection:
•	Calls AuthNotifier.login(phone, password)
•	Watches auth state for loading and errors
Navigation:
•	Login successful: Navigate to role-specific dashboard
•	Login failed: Display error message
5.2 Recipient Flow Screens
Verification Pending Screen
Purpose: Inform recipient that their profile is under review and provide status updates.
UI Elements:
•	Large pending icon/animation
•	Status message: "Your profile is under review"
•	Estimated review time (24-48 hours)
•	What happens next explanation
•	Checklist of verification steps
•	Notification bell icon to enable alerts
•	"Go to Dashboard" button
Actions:
•	Enable push notifications for verification updates
•	Navigate to
Provider Connection:
•	Watches VerificationNotifier for status updates
•	Polls verification status periodically
Navigation:
•	Status changed to approved: Navigate to Verification Approved screen
•	Status changed to rejected: Navigate to Verification Rejected screen
•	Dashboard: Navigate to limited recipient dashboard
Verification Approved Screen
Purpose: Congratulate recipient on successful verification and introduce them to the platform.
UI Elements:
•	Success icon with animation
•	Congratulations message
•	Verification badge display
•	"What You Can Do Now" feature list
•	"Get Started" button
•	Share success option (optional)
Actions:
•	Acknowledge approval
•	Proceed to full dashboard
•	Share achievement on social media (optional)
Provider Connection:
•	Updates VerificationNotifier status
•	Enables full recipient features
Navigation:
•	Get Started: Navigate to Recipient Dashboard with welcome tour
Verification Rejected Screen
Purpose: Inform recipient of rejection with clear reasons and next steps.
UI Elements:
•	Rejection icon (empathetic, not harsh)
•	Rejection reason display from admin
•	List of issues identified
•	"Update Profile" button
•	"Contact Support" button
•	FAQ section for common issues
Actions:
•	Read rejection reasons
•	Navigate to profile editing
•	Contact support for assistance
•	View help articles
Provider Connection:
•	Reads rejection details from VerificationNotifier
•	Allows profile re-submission
Navigation:
•	Update Profile: Navigate to profile editing with issues highlighted
•	Contact Support: Navigate to support screen with pre-filled context
•	Re-submit: Return to Verification Pending after updates
Recipient Dashboard Screen
Purpose: Central hub for recipients showing their status, active requests, and received donations.
UI Elements:
•	Welcome header with recipient name and verification badge
•	Profile completion percentage (if incomplete)
•	Quick stats cards (Active Requests, Total Received, Pending Thank-Yous)
•	"Create New Request" prominent button
•	Active requests list with progress bars
•	Recent donations section
•	Pending actions section (thank-yous to send, impact updates needed)
•	Bottom navigation bar
Actions:
•	Create new charity request
•	View request details
•	Send thank-you messages
•	Submit impact updates
•	Access profile
•	View donation history
Provider Connection:
•	Watches RecipientDashboardNotifier for data
•	Loads requests, donations, and stats
•	Pulls to refresh data
Navigation:
•	Create Request: Navigate to request creation flow
•	Request card: Navigate to request details screen
•	Donation card: Navigate to thank-you creation
•	Profile icon: Navigate to profile screen
•	Bottom nav: Navigate to respective sections
My Profile Screen
Purpose: Display recipient's complete profile information and verification status.
UI Elements:
•	Profile photo with edit option
•	Name and verification badge
•	Personal information sections
•	Contact information
•	Story section with photos
•	CNIC and documents (secure display)
•	"Edit Profile" button
•	"Share Profile" option
Actions:
•	View complete profile
•	Edit profile sections
•	Update profile photo
•	Share profile link (for donors)
Provider Connection:
•	Reads RecipientProfileNotifier state
•	Allows profile updates
Navigation:
•	Edit: Navigate to profile editing screen
•	Share: Open share dialog
Profile Edit Screen
Purpose: Allow recipients to update their profile information while maintaining verification.
UI Elements:
•	Editable fields matching profile creation
•	Warning message if editing affects verification
•	Save button
•	Cancel button
•	Field-specific help text
Actions:
•	Modify profile information
•	Update photos
•	Save changes
•	Discard changes
Provider Connection:
•	Loads current RecipientProfileNotifier data
•	Calls update methods on save
•	May trigger re-verification if significant changes
Navigation:
•	Save successful: Return to profile screen with success message
•	Cancel: Return to profile screen without changes
•	Re-verification needed: Show warning dialog
Create Request - Step 1 Screen
Purpose: Capture essential request details including need type and amount.
UI Elements:
•	Request title input
•	Charity type selector (Sadqah, Zakat, Khairat, Fitra)
•	Need category dropdown (Medical, Education, Housing, Business, Emergency)
•	Amount needed input with currency formatting
•	Urgency level selector (Low, Medium, High, Critical)
•	Brief description input (100-300 characters)
•	"Next" button
Actions:
•	Enter request details
•	Select charity and need types
•	Set urgency level
•	Proceed to detailed description
Provider Connection:
•	Updates CharityRequestNotifier with basic request data
•	Validates amount and required fields
Navigation:
•	All fields valid: Navigate to Create Request Step 2
•	Validation errors: Show inline messages
Create Request - Step 2 Screen
Purpose: Collect detailed description and supporting documents for the request.
UI Elements:
•	Detailed description text area (500-1500 characters)
•	Character counter
•	Document upload section (utility bills, medical reports, etc.)
•	Photo upload section (up to 5 photos)
•	Uploaded files preview with remove option
•	Expected completion date picker
•	"Back" and "Submit Request" buttons
Actions:
•	Write detailed explanation
•	Upload supporting documents
•	Add photos showing need
•	Set completion timeline
•	Submit complete request
Provider Connection:
•	Completes CharityRequestNotifier state
•	Handles file uploads
•	Submits request to backend
Navigation:
•	Submit successful: Navigate to Request Submitted confirmation
•	Submit failed: Show error with retry option
•	Back: Return to Step 1 with data preserved
Request Submitted Screen
Purpose: Confirm successful request submission and explain next steps.
UI Elements:
•	Success animation
•	Confirmation message
•	Request reference number
•	"What Happens Next" timeline
•	Estimated approval time
•	"View Request" button
•	"Create Another Request" button
•	"Go to Dashboard" button
Actions:
•	View submitted request details
•	Create another request
•	Return to dashboard
Provider Connection:
•	Reads newly created request from CharityRequestNotifier
•	Refreshes dashboard data
Navigation:
•	View Request: Navigate to request details screen
•	Create Another: Navigate to request creation step 1
•	Dashboard: Navigate to recipient dashboard
Request Details Screen
Purpose: Display complete information about a specific charity request including funding progress.
UI Elements:
•	Request title and urgency badge
•	Progress bar showing funded percentage
•	Amount needed vs amount received
•	Donor count
•	Request description and story
•	Supporting photos gallery
•	Documents section (if admin approved visibility)
•	Donor list (anonymized or named based on donor preference)
•	Timeline of donations
•	Edit button (if request not fully funded)
•	Share button to share with potential donors
Actions:
•	View complete request details
•	Monitor funding progress
•	Edit request (before full funding)
•	Share request link
•	View donor list
•	Thank donors
Provider Connection:
•	Watches CharityRequestNotifier for specific request
•	Updates in real-time as donations arrive
•	Loads donation details
Navigation:
•	Edit: Navigate to edit request screen (if allowed)
•	Donor profile: Navigate to donor thank-you creation
•	Back: Return to dashboard or request list
Edit Request Screen
Purpose: Allow recipients to modify request details before full funding or after admin feedback.
UI Elements:
•	Pre-filled form with current request data
•	All fields editable except amount (if partially funded)
•	Warning messages for restricted edits
•	Save button
•	Cancel button
Actions:
•	Modify request information
•	Update photos and documents
•	Save changes
•	Discard changes
Provider Connection:
•	Loads CharityRequestNotifier for specific request
•	Validates changes
•	Submits updates
Navigation:
•	Save successful: Return to request details with confirmation
•	Cancel: Return to request details without changes
•	Requires re-approval: Show warning dialog
Donation Received Screen
Purpose: Notify recipient of new donation and prompt thank-you message.
UI Elements:
•	Celebration animation
•	Donation amount display
•	Donor name (or "Anonymous" if donor prefers)
•	Request title that was funded
•	Message from donor (if included)
•	"Send Thank You" prominent button
•	"View Request Progress" button
•	"Later" option
Actions:
•	Read donation details
•	Send immediate thank-you
•	View updated request progress
•	Dismiss for later
Provider Connection:
•	Receives donation data from DonationNotifier
•	Opens thank-you creation with pre-filled donor info
Navigation:
•	Send Thank You: Navigate to thank-you creation screen
•	View Progress: Navigate to request details screen
•	Later: Return to dashboard (adds to pending thank-yous)
Thank You Screen
Purpose: Enable recipients to compose heartfelt thank-you messages for donors.
UI Elements:
•	Donor name display (or Anonymous)
•	Donation amount and date
•	Message text area (100-500 characters)
•	Character counter
•	Optional: Add photo showing appreciation
•	Photo upload and preview
•	Suggested message templates (optional)
•	"Send Thank You" button
•	"Save Draft" option
Actions:
•	Write personalized thank-you message
•	Add appreciation photo
•	Use template or write custom message
•	Send thank-you to donor
•	Save as draft for later
Provider Connection:
•	Creates ThankYouModel and sends via DonationNotifier
•	Marks thank-you as sent
•	Updates pending thank-you count
Navigation:
•	Send successful: Navigate to Thank You Sent confirmation
•	Save draft: Return to dashboard with draft saved
•	Cancel: Confirm discard and return
Thank You Sent Screen
Purpose: Confirm successful thank-you delivery to donor.
UI Elements:
•	Success icon
•	Confirmation message
•	Preview of sent message
•	"Send Another" button
•	"Go to Dashboard" button
Actions:
•	Acknowledge confirmation
•	Send more thank-yous if pending
•	Return to dashboard
Provider Connection:
•	Refreshes pending thank-you list
Navigation:
•	Send Another: Navigate to thank-you screen for next pending donor
•	Dashboard: Return to recipient dashboard
Impact Update Request Screen
Purpose: Prompt recipients to share how donated funds were utilized.
UI Elements:
•	Request reference that funding was for
•	Total amount received display
•	"How did you use the funds?" text area
•	Before and after photo upload sections
•	Results achieved description
•	Receipts or proof upload (optional)
•	"Submit Update" button
Actions:
•	Describe fund usage
•	Upload before/after photos
•	Add receipts or proof of purchase
•	Submit impact update
Provider Connection:
•	Creates ImpactUpdateModel via DonationNotifier
•	Links update to specific request and donors
•	Uploads photos and documents
Navigation:
•	Submit successful: Navigate to Impact Update Submitted confirmation
•	Cancel: Confirm discard and return to dashboard
Impact Update Submitted Screen
Purpose: Confirm impact update submission and delivery to donors.
UI Elements:
•	Success animation
•	Confirmation message
•	Preview of submitted update
•	"Donors will be notified" message
•	"Submit Another Update" button
•	"Go to Dashboard" button
Actions:
•	Acknowledge submission
•	Submit more updates if needed
•	Return to dashboard
Provider Connection:
•	Refreshes dashboard data
•	Updates pending impact update count
Navigation:
•	Submit Another: Navigate to impact update request for another request
•	Dashboard: Return to recipient dashboard
Donation History Screen
Purpose: Display complete history of all donations received by the recipient.
UI Elements:
•	Total donations received summary
•	Monthly/yearly breakdown chart
•	Filterable list of all donations
•	Each donation card shows: amount, date, donor name, request title, thank-you status
•	Filter options (date range, request, donor)
•	Search functionality
Actions:
•	View donation history
•	Filter by criteria
•	Search for specific donations
•	Send pending thank-yous
•	Export data
Provider Connection:
•	Loads donation data from DonationRepository
•	Filters and sorts locally
•	Manages pagination for large lists
Navigation:
•	Donation card: Navigate to specific donation details
•	Thank you pending: Navigate to thank-you creation
•	Back: Return to dashboard
5.3 Donor Flow Screens
Donor SignUp Screen
Purpose: Collect essential information to create a donor account.
UI Elements:
•	Full name input field
•	CNIC number input with auto-formatting (xxxxx-xxxxxxx-x)
•	Date of birth picker
•	Gender selection
•	Source of income
•	Number of dependents input
•	"Next" button
Actions:
•	Fill donor information
•	Set donation preferences
•	Upload profile photo
•	Submit profile
Provider Connection:
•	Creates DonorProfileNotifier with profile data
•	Saves preferences for personalized browsing
Navigation:
•	Profile created: Navigate to Donor Dashboard with welcome tour
•	Validation errors: Show inline messages
Donor Dashboard Screen
Purpose: Central hub showing donation impact, suggested recipients, and quick actions.
UI Elements:
•	Welcome header with donor name
•	Impact summary cards (Total Donated, Lives Helped, Active Contributions)
•	Featured verified recipients carousel
•	Urgent requests section
•	Recent activity feed (thank-yous, impact updates)
•	"Browse Recipients" button
•	"My Donations" button
•	Quick donate section
•	Bottom navigation bar
Actions:
•	Browse all recipients
•	View urgent requests
•	Quick donate to featured recipient
•	View donation history
•	Read thank-you messages and impact updates
•	Access profile
Provider Connection:
•	Watches DonorDashboardNotifier for data
•	Loads impact metrics, featured recipients, recent activity
•	Supports pull-to-refresh
Navigation:
•	Browse: Navigate to browse women screen
•	Recipient card: Navigate to woman profile screen
•	Request card: Navigate to request details screen
•	My Donations: Navigate to donation history screen
•	Thank-you notification: Navigate to thank-you view screen
•	Bottom nav: Navigate to respective sections
Browse Women Screen
Purpose: Display list of verified recipients available for donation with filtering capabilities.
UI Elements:
•	Search bar
•	Filter button (opens filters screen)
•	Active filters chips with remove option
•	Recipient cards grid/list showing: 
o	Photo and name
o	Verification badge
o	Location
o	Brief story excerpt
o	Active request count
o	Urgency indicator
•	Sort dropdown (Newest, Most Urgent, Closest to Goal)
•	Load more/infinite scroll
•	Empty state if no results
Actions:
•	Search by name or keyword
•	Apply filters
•	Sort results
•	Remove active filters
•	View recipient profile
•	Load more results
Provider Connection:
•	Managed by BrowseNotifier
•	Handles search, filter, sort logic
•	Implements pagination
•	Caches results for performance
Navigation:
•	Recipient card: Navigate to woman profile screen
•	Filters: Navigate to filters screen
•	Search results: Updates current screen with results
Filters Screen
Purpose: Provide comprehensive filtering options to help donors find recipients matching their criteria.
UI Elements:
•	Need category checkboxes (Medical, Education, Housing, etc.)
•	Charity type selectors (Sadqah, Zakat, Khairat, Fitra)
•	Location filters (Province, City)
•	Urgency level selectors
•	Amount range slider
•	Verification status toggle
•	"Apply Filters" button
•	"Clear All" button
•	Active filter count badge
Actions:
•	Select/deselect filter criteria
•	Adjust amount range
•	Apply all filters
•	Clear all selections
•	See filter count
Provider Connection:
•	Updates BrowseNotifier filter state
•	Applies filters to recipient list
Navigation:
•	Apply: Return to browse screen with filtered results
•	Cancel: Return to browse screen without changes
•	Clear All: Remove all filters and return
Woman Profile Screen
Purpose: Display comprehensive recipient profile for donor evaluation and decision-making.
UI Elements:
•	Profile photo and verification badge
•	Name and location
•	Story section with photos
•	Personal circumstances summary
•	Active requests section with cards showing: 
o	Request title and type
o	Amount needed vs raised
o	Progress bar
o	Urgency level
o	Time remaining
•	Completed requests history
•	Impact achieved section (from past donations)
•	Thank-you messages from recipient (if received donations before)
•	"Donate" button (sticky at bottom)
•	Share profile option
Actions:
•	Read complete recipient story
•	View active requests
•	Select specific request to donate to
•	View past impact
•	Share profile with others
•	Start donation process
Provider Connection:
•	Loads recipient data from RecipientRepository
•	Shows real-time request progress
•	Displays past donation impact
Navigation:
•	Donate button: Navigate to request selection (if multiple) or directly to choose amount screen
•	Request card: Navigate to detailed request view
•	Back: Return to browse screen
•	Share: Open share dialog
Request Details Screen (Donor View)
Purpose: Show complete details of a specific charity request to inform donation decision.
UI Elements:
•	Request title and urgency badge
•	Recipient name with verification badge and photo
•	Progress bar with amount raised/needed
•	Donor count and most recent donations
•	Detailed request description
•	Supporting photos gallery
•	Documents section (if shared by recipient)
•	Timeline showing donation history
•	"Donate to This Request" button
•	Share button
•	Report concern option
Actions:
•	View complete request information
•	Read recipient's story
•	View supporting documents
•	Check funding progress
•	Donate to request
•	Share request
•	Report if suspicious
Provider Connection:
•	Loads request details from CharityRequestRepository
•	Real-time progress updates
•	Tracks donor engagement
Navigation:
•	Donate: Navigate to choose amount screen with request pre-selected
•	Recipient name: Navigate to complete woman profile
•	Share: Open share dialog
•	Report: Open report form
•	Back: Return to woman profile or browse screen
Choose Amount Screen
Purpose: Allow donors to select donation amount with guidance for different charity types.
UI Elements:
•	Selected request summary card at top
•	Charity type indicator (affects suggested amounts)
•	Suggested amount buttons based on: 
o	Zakat: Calculated percentages
o	Sadqah: Flexible amounts
o	Specific need: Partial or full funding
•	Custom amount input field
•	Amount needed vs amount raised display
•	"This will complete the request" message if full funding selected
•	Anonymous donation checkbox
•	Add message to recipient text field (optional)
•	Impact preview: "Your donation will help [recipient name] with [need]"
•	"Continue to Payment" button
Actions:
•	Select suggested amount
•	Enter custom amount
•	Choose to donate anonymously
•	Add personal message
•	Proceed to payment
Provider Connection:
•	Updates DonationNotifier with amount and details
•	Validates amount against request need
•	Calculates impact
Navigation:
•	Continue: Navigate to payment method screen
•	Back: Return to request details
•	Edit request: Return to woman profile to select different request
Payment Method Screen
Purpose: Allow donors to select their preferred payment method for donation.
UI Elements:
•	Donation summary card (amount, recipient, request)
•	Payment method tiles: 
o	Bank Transfer (with account details)
•	Selected payment method highlighted
•	Payment instructions section
•	Recurring donation toggle
•	"Proceed to Pay" button
•	Secure payment badges
Actions:
•	Select payment method
•	View payment instructions
•	Enable recurring donation
•	Proceed to payment slip or instructions
•	Save payment method for future (optional)
Provider Connection:
•	Updates PaymentNotifier with selected method
•	Handles payment gateway integration
•	Manages recurring donation setup
Navigation:
•	Bank Transfer: Just manually Transfer to the Recipient Screen and attach the Image
•	Card: Launches card payment form
•	Success: Navigate to payment confirmation screen
•	Failure: Shows error with retry option
Payment Confirmation Screen
Purpose: Confirm successful donation and provide receipt.
UI Elements:
•	Success animation
•	"Thank you for your donation!" message
•	Donation summary: 
o	Amount donated
o	Recipient name
o	Request title
o	Payment method
o	Transaction ID
o	Date and time
•	Receipt preview
•	"Download Receipt" button
•	"Share Your Good Deed" social sharing option
•	"View Request Progress" button
•	"Donate Again" button
•	"Go to Dashboard" button
Actions:
•	Download PDF receipt
•	Share donation (respects anonymous preference)
•	View updated request progress
•	Make another donation
•	Return to dashboard
Provider Connection:
•	Confirms donation through DonationNotifier
•	Generates receipt via PaymentNotifier
•	Updates donor impact metrics
Navigation:
•	View Progress: Navigate to request details showing donation
•	Donate Again: Navigate to browse screen
•	Dashboard: Navigate to donor dashboard with updated metrics
Recurring Donation Setup Screen
Purpose: Configure automatic recurring donations for ongoing support.
UI Elements:
•	Selected recipient and request information
•	Recurring amount input
•	Frequency selector (Weekly, Monthly, Quarterly)
•	Start date picker
•	Payment method selection
•	"Until request is fulfilled" or "Indefinite" option
•	Recurring donation summary
•	Terms and conditions
•	"Set Up Recurring Donation" button
Actions:
•	Set donation amount and frequency
•	Choose payment method
•	Select duration
•	Confirm setup
•	Manage existing recurring donations
Provider Connection:
•	Creates recurring donation through PaymentNotifier
•	Schedules automatic payments
•	Manages payment method storage
Navigation:
•	Setup successful: Navigate to confirmation screen
•	Manage recurring: Navigate to recurring donations management screen
•	Cancel: Return to payment method screen

