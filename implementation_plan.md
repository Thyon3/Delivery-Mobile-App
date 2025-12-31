# Rebuild UI - Delivery Application

## Overview
This plan outlines the steps to redesign and enhance the Delivery Application to a professional, production-level standard. We will aim for 90+ logical commits.

## Phases

### Phase 1: Foundation & Theme (Commits 1-10)
- [ ] Define new color palette (Primary: Vibrant Orange/Red, Secondary: Dark/Light backgrounds)
- [ ] Set up modern Typography (Outfit or Google Fonts)
- [ ] Create Design System constants (padding, radius, shadows)
- [ ] Move `my_button.dart` and `my_drawer.dart` from `page` to `components`
- [ ] Update `main.dart` to reflect new theme

### Phase 2: Authentication & Onboarding (Commits 11-25)
- [ ] Create Modern Onboarding Screen with animations
- [ ] Redesign Login Page (Glassmorphism or Clean Card design)
- [ ] Redesign Register Page
- [ ] Add Forgot Password Screen
- [ ] Add Social Login buttons (UI only for now)

### Phase 3: Home & Discovery Redesign (Commits 26-45)
- [ ] Redesign Home Page Layout (SliverAppBar, dynamic categories)
- [ ] Create high-quality Food Category widgets
- [ ] Redesign Food Cards (Shadows, better images, price tags)
- [ ] Add Search Bar with filters UI
- [ ] Create "Popular Near You" section

### Phase 4: Product Details (Commits 46-55)
- [ ] Redesign Food Details Screen (Hero animations)
- [ ] Add Nutrition facts UI
- [ ] Add Ratings and Reviews UI
- [ ] Enhance "Add to Cart" interaction

### Phase 5: Cart & Checkout (Commits 56-70)
- [ ] Redesign Cart Screen (Swipe to delete, item count animation)
- [ ] Create Address Selection UI
- [ ] Redesign Payment Methods UI
- [ ] Add "Apply Promo Code" UI

### Phase 6: Order Tracking & History (Commits 71-85)
- [ ] Redesign Delivery Progress with stepper or map-like UI
- [ ] Create Order History list
- [ ] Add Order Detail view from history
- [ ] Add "Rate your Meal" post-delivery screen

### Phase 7: Profile & Extras (Commits 86-100+)
- [ ] Redesign Profile Screen (Profile header, quick links)
- [ ] Add "Favorites" screen
- [ ] Enhance Settings screen
- [ ] Add Notifications screen
- [ ] Final polishing, micro-animations, and bug fixes

## Commit Strategy
- Every component change gets its own commit.
- Every page redesign is broken into smaller commits (structure, styling, data binding).
- New pages added incrementally.
