# Rebuild UI - Delivery Application

## Overview
This plan outlines the steps to redesign and enhance the Delivery Application to a professional, production-level standard. We will aim for 110+ logical commits.

## Phases

### Phase 1: Foundation & Theme (Commits 1-15) [DONE]
- [x] Define new color palette (Primary: Vibrant Orange/Red, Secondary: Dark/Light backgrounds)
- [x] Create Design System constants (padding, radius, shadows)
- [x] Move components to proper directory
- [x] Set up modern Typography (Google Fonts: Outfit/Poppins)
- [x] Create specialized `AppTextStyles` utility
- [x] Update `main.dart` to reflect new theme and typography
- [x] Add global button theme in `ThemeData`
- [x] Add global text theme in `ThemeData`

### Phase 2: Authentication & Onboarding (Commits 16-35) [DONE]
- [x] Create `OnboardingScreen` structure
- [x] Add PageView for onboarding slides
- [x] Design onboarding content (titles, descriptions, premium illustrations)
- [x] Add "Get Started" button with animation
- [x] Create `LoginHeader` with logo and welcome text
- [x] Redesign `MyTextField` for modern look (borderless, soft shadows)
- [x] Redesign Login Page layout with better spacing
- [x] Add "Social Login" buttons (Google, Apple) - UI Only
- [x] Redesign Register Page with matching aesthetics
- [x] Add validations and error UI for Auth forms

### Phase 3: Home & Discovery Redesign (Commits 36-60) [DONE]
- [x] Create `CustomSliverAppBar` for Home
- [x] Implement `CategoryPill` component with active states
- [x] Refactor food categories into a horizontally scrollable list
- [x] Create `PromoBanner` carousel for home page
- [x] Redesign `FoodTile` (Horizontal layout for some sections)
- [x] Implement Premium `FoodCard` (Vertical, large images, price badge)
- [x] Add "Popular Near You" section with horizontal scroll
- [x] Create "Quick Filter" chip group
- [x] Implement Search Bar with micro-interactions

### Phase 4: Product Details & Customization (Commits 61-75) [DONE]
- [x] Premium `FoodDetails` layout (Full-width image, sticky header)
- [x] Implement Animated "Add to Cart" button
- [x] Customize `Addons` selection UI with checkboxes/radio buttons
- [x] Add "Quantity Selector" component with animations
- [x] Design "Nutritional Info" section
- [x] Implement "Similar Items" recommendation scroll
- [x] Implement Floating "Add to Cart" button with price summary
- [x] Add Hero animations for smooth page transitions

### Phase 5: Cart & Checkout (Commits 76-90) [DONE]
- [x] Create `CartItemCard` with swipe-to-remove
- [x] Add "Order Summary" card with breakdown (Subtotal, Tax, Delivery)
- [x] Design `AddressPicker` UI component
- [x] Create `PaymentMethodTile` with selection logic
- [x] Add "Promo Code" input with "Apply" button UI
- [x] Implement "Checkout Timeline" stepper
- [x] Redesign Cart page with premium layout
- [x] Redesign Payment page with multiple payment options

### Phase 6: Order Tracking & History (Commits 91-105) [DONE]
- [x] Create `LiveTrackingMap` placeholder UI
- [x] Design Delivery Stepper (Confirmed, Preparing, On the way, Delivered)
- [x] Build `OrderHistoryTile` with status badges
- [x] Create `OrdersPage` (History) and detailed modal
- [x] Add "Reorder" button functionality UI placeholder
- [x] Add "Rate your Meal" feedback modal
- [x] Redesign `Deliveryprogress` page with stepper and map
- [x] Link Orders history in the drawer

### Phase 7: Profile & Extras (Commits 106-120+) [DONE]
- [x] Create `ProfileHeader` with avatar and stats
- [x] Design `ProfileMenuItem` component for clean lists
- [x] Create `ProfilePage` with grouped settings
- [x] Add "Favorites" screen with grid layout
- [x] Redesign Settings screen with premium cards and toggles
- [x] Create "Notifications" list with status indicators
- [x] Link all new pages in the drawer and profile menu

## Commit Strategy
- Every component change gets its own commit.
- Every page redesign is broken into smaller commits (structure, styling, data binding).
- Use prefix: `feat:`, `fix:`, `style:`, `refactor:`.
- Ensure each commit is buildable and functional.
