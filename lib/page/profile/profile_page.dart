import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/profile_menu_item.dart';
import 'package:thydelivery_mobileapp/page/profile/favorites_page.dart';
import 'package:thydelivery_mobileapp/page/profile/help_center_page.dart';
import 'package:thydelivery_mobileapp/page/profile/notifications_page.dart';
import 'package:thydelivery_mobileapp/page/profile/referral_page.dart';
import 'package:thydelivery_mobileapp/page/order/orders_page.dart';
import 'package:thydelivery_mobileapp/page/profile/saved_addresses_page.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Profile Header
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 4,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Thyon Mengesha',
              style: AppTextStyles.h2,
            ),
            Text(
              'thyon@example.com',
              style: AppTextStyles.bodyM.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            
            const SizedBox(height: 40),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersPage())),
                  child: _buildStatItem('Orders', '24'),
                ),
                _buildDivider(),
                _buildStatItem('Reviews', '12'),
                _buildDivider(),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage())),
                  child: _buildStatItem('Favorites', '8'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Menu groups
            _buildGroupTitle('Account Settings'),
            const SizedBox(height: 8),
            ProfileMenuItem(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedAddressesPage())),
            ),
            ProfileMenuItem(
              icon: Icons.payment_rounded,
              title: 'Payment Methods',
              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.share_rounded,
              title: 'Refer & Earn',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReferralPage())),
            ),
            const SizedBox(height: 24),
            _buildGroupTitle('Preferences'),
            const SizedBox(height: 8),
            ProfileMenuItem(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage())),
            ),
            ProfileMenuItem(
              icon: Icons.language_rounded,
              title: 'Language',
              subtitle: 'English',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              onTap: () {},
              trailing: Switch(
                value: true, // Mock value
                onChanged: (val) {},
              ),
            ),

            const SizedBox(height: 24),
            _buildGroupTitle('Support'),
            const SizedBox(height: 8),
            ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help Center',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterPage())),
            ),
            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About Us',
              onTap: () {},
            ),

            const SizedBox(height: 40),
            
            // Logout
            ProfileMenuItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              color: Colors.red,
              onTap: () {},
              trailing: const SizedBox.shrink(),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h3.copyWith(fontSize: 20),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildGroupTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}


