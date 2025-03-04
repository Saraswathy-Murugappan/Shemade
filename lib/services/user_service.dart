import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geolocator/geolocator.dart';



class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> updateUserLocation(String uid, String location) async {
    await _db.collection('users').doc(uid).update({'location': location});
  }

  static Future<String?> fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return "${position.latitude}, ${position.longitude}";
    } catch (e) {
      return null;
    }
  }
}
