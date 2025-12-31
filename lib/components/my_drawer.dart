import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/drawer_tile.dart';
import 'package:thydelivery_mobileapp/page/order/orders_page.dart';
import 'package:thydelivery_mobileapp/page/profile/favorites_page.dart';
import 'package:thydelivery_mobileapp/page/profile/profile_page.dart';
import 'package:thydelivery_mobileapp/page/settings/settings_page.dart';
import 'package:thydelivery_mobileapp/page/profile/vouchers_page.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';
import 'package:thydelivery_mobileapp/theme/fade_page_route.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      FadePageRoute(child: const SettingsPage()),
    );
  }

  void logOut() {
    AuthService authService = AuthService();
    authService.signOut();
  }

  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Icon(
              Icons.lock_clock_outlined,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(25),
            child: Divider(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          DrawerTile(
            title: 'H O M E',
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'M Y  O R D E R S',
            icon: Icons.receipt_long_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                FadePageRoute(child: const OrdersPage()),
              );
            },
          ),
          DrawerTile(
            title: 'M Y  R E W A R D S',
            icon: Icons.card_giftcard_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                FadePageRoute(child: const VouchersPage()),
              );
            },
          ),
          DrawerTile(
            title: 'F A V O R I T E S',
            icon: Icons.favorite_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                FadePageRoute(child: const FavoritesPage()),
              );
            },
          ),
          DrawerTile(
            title: 'P R O F I L E',
            icon: Icons.person_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                FadePageRoute(child: const ProfilePage()),
              );
            },
          ),
          DrawerTile(
            title: 'S E T T I N G S',
            icon: Icons.settings,
            onTap: () => goToSettings(context),
          ),

          Spacer(),
          DrawerTile(
            title: 'L O G O U T ',
            icon: Icons.logout,
            onTap: () {
              logOut();
            },
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
