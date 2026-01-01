import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/profile_menu_item.dart';
import 'package:thydelivery_mobileapp/page/profile/notifications_page.dart';
import 'package:thydelivery_mobileapp/theme/theme_provider.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGroupTitle('Preferences'),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.dark_mode_rounded,
                title: 'Dark Mode',
                onTap: () {},
                trailing: CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.notifications_active_rounded,
                title: 'Push Notifications',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage())),
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            _buildGroupTitle('Region'),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'English (US)',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.location_on_rounded,
                title: 'Location Services',
                onTap: () {},
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),

            const SizedBox(height: 32),
            _buildGroupTitle('Security'),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.lock_rounded,
                title: 'Change Password',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              child: ProfileMenuItem(
                icon: Icons.fingerprint_rounded,
                title: 'Biometric Login',
                onTap: () {},
                trailing: CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),

            const SizedBox(height: 40),
            Center(
              child: Text(
                'Version 1.0.2 (Build 452)',
                style: AppTextStyles.caption,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
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

  Widget _buildSettingCard(BuildContext context, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

