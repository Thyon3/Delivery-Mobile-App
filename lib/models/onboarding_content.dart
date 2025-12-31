class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<OnboardingContent> onboardingContents = [
  OnboardingContent(
    title: 'Find your cravings',
    description: 'Explore the best restaurants in town with just a few clicks. Your favorite food is just a tap away.',
    image: 'assets/Images/Burgers/cheese_burger.png', // Placeholder for now
  ),
  OnboardingContent(
    title: 'Fast Delivery',
    description: 'Get your food delivered fresh and hot at your doorstep. We value your time.',
    image: 'assets/Images/Desserts/apple_pie.png', // Placeholder for now
  ),
  OnboardingContent(
    title: 'Track your Order',
    description: 'Know where your food is at all times. Real-time tracking from the restaurant to your door.',
    image: 'assets/Images/Drinks/coke.png', // Placeholder for now
  ),
];
