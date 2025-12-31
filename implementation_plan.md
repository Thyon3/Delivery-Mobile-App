# Rebuild UI - Delivery Application

## Overview
This plan outlines the steps to redesign and enhance the Delivery Application to a professional, production-level standard. We will aim for 110+ logical commits.

## Phases

### Phase 1: Foundation & Theme (Commits 1-15) [CURRENT]
- [x] Define new color palette (Primary: Vibrant Orange/Red, Secondary: Dark/Light backgrounds)
- [x] Create Design System constants (padding, radius, shadows)
- [x] Move components to proper directory
- [ ] Set up modern Typography (Google Fonts: Outfit/Poppins)
- [ ] Create specialized `AppTextStyles` utility
- [ ] Update `main.dart` to reflect new theme and typography
- [ ] Add global button theme in `ThemeData`
- [ ] Add global text theme in `ThemeData`

### Phase 2: Authentication & Onboarding (Commits 16-35)
- [ ] Create `OnboardingScreen` structure
- [ ] Add PageView for onboarding slides
- [ ] Design onboarding content (titles, descriptions, premium illustrations)
- [ ] Add "Get Started" button with animation
- [ ] Create `LoginHeader` with logo and welcome text
- [ ] Redesign `MyTextField` for modern look (borderless, soft shadows)
- [ ] Redesign Login Page layout with better spacing
- [ ] Add "Social Login" buttons (Google, Apple) - UI Only
- [ ] Redesign Register Page with matching aesthetics
- [ ] Add validations and error UI for Auth forms

### Phase 3: Home & Discovery Redesign (Commits 36-60)
- [ ] Create `CustomSliverAppBar` for Home
- [ ] Implement `CategoryPill` component with active states
- [ ] Refactor food categories into a horizontally scrollable list
- [ ] Create `PromoBanner` carousel for home page
- [ ] Redesign `FoodTile` (Horizontal layout for some sections)
- [ ] Implement Premium `FoodCard` (Vertical, large images, price badge)
- [ ] Add "Popular Near You" section with horizontal scroll
- [ ] Create "Quick Filter" chip group
- [ ] Implement Search Bar with micro-interactions

### Phase 4: Product Details (Commits 61-75)
- [ ] Design `SliverProductImage` with parallax effect
- [ ] Create `NutritionBadge` component
- [ ] Add `ExpandableDescription` widget
- [ ] Add `RatingStars` and `ReviewsSummary` UI
- [ ] Create interactive "Quantity Selector" with animations
- [ ] Implement Floating "Add to Cart" button with price summary

### Phase 5: Cart & Checkout (Commits 76-90)
- [ ] Create `CartItemCard` with swipe-to-remove
- [ ] Add "Order Summary" card with breakdown (Subtotal, Tax, Delivery)
- [ ] Design `AddressPicker` UI component
- [ ] Create `PaymentMethodTile` with selection logic
- [ ] Add "Promo Code" input with "Apply" button UI
- [ ] Implement "Checkout Timeline" stepper

### Phase 6: Order Tracking & History (Commits 91-105)
- [ ] Create `LiveTrackingMap` placeholder UI
- [ ] Design Delivery Stepper (Confirmed, Preparing, On the way, Delivered)
- [ ] Build `OrderHistoryTile` with status badges
- [ ] Create `OrderDetailScreen` layout
- [ ] Add "Reorder" button functionality UI
- [ ] Add "Rate your Meal" feedback modal

### Phase 7: Profile & Extras (Commits 106-120+)
- [ ] Create `ProfileHeader` with avatar and edit button
- [ ] Design `ProfileMenuItem` with icons and trailing arrows
- [ ] Add "Favorites" screen with grid layout
- [ ] Enhance Settings screen with toggle switches
- [ ] Create "Notifications" list with unread markers
- [ ] Final polishing: Hero animations, Page transitions, Micro-interactions

## Commit Strategy
- Every component change gets its own commit.
- Every page redesign is broken into smaller commits (structure, styling, data binding).
- Use prefix: `feat:`, `fix:`, `style:`, `refactor:`.
- Ensure each commit is buildable and functional.
