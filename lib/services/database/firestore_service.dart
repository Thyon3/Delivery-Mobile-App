import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thydelivery_mobileapp/models/address.dart';

class FirestoreService {
  // get the collection
  final CollectionReference orders = FirebaseFirestore.instance.collection(
    'orders',
  );

  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  // add the orders to the collection

  Future<void> saveOrdersToFireStore(
    String reciept,
    String currentAddress,
  ) async {
    await orders.add({
      'date': DateTime.now(),
      'order': reciept,
      'delivery Address': currentAddress,
      'owner of the company': 'Thyon',
    });
  }

  Future<void> saveUsersToFirestore(
    String name,
    String email,
    String phoneNumber,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await users.doc(currentUser.uid).set({
        'Name': name,
        'Email': email,
        'Phone Number': phoneNumber,
      }, SetOptions(merge: true));
    }
  }

  // Favorites logic
  Future<void> toggleFavoriteInFirestore(String foodName, bool isFavorite) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userDoc = users.doc(currentUser.uid);
    if (isFavorite) {
      await userDoc.update({
        'favoriteFoodNames': FieldValue.arrayUnion([foodName])
      });
    } else {
      await userDoc.update({
        'favoriteFoodNames': FieldValue.arrayRemove([foodName])
      });
    }
  }

  Future<List<String>> getFavoritesFromFirestore() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final snapshot = await users.doc(currentUser.uid).get();
    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return List<String>.from(data['favoriteFoodNames'] ?? []);
    }
    return [];
  }

  // Address logic
  Future<void> saveAddressToFirestore(Address address) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userDoc = users.doc(currentUser.uid);
    await userDoc.update({
      'savedAddresses': FieldValue.arrayUnion([address.toMap()])
    });
  }

  Future<List<Address>> getAddressesFromFirestore() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final snapshot = await users.doc(currentUser.uid).get();
    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> addressMaps = data['savedAddresses'] ?? [];
      return addressMaps.map((map) => Address.fromMap(Map<String, dynamic>.from(map))).toList();
    }
    return [];
  }
}
