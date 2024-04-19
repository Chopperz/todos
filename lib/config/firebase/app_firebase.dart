import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import './firebase_options.dart';

export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_database/firebase_database.dart';

class AppFirebase {
  static AppFirebase instance = AppFirebase._();

  AppFirebase._();

  Future<void> configs() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseAuth.instance..useAuthEmulator("localhost", 9099);
  }

  User? get user => FirebaseAuth.instance.currentUser;

  DatabaseReference database({String? path}) => FirebaseDatabase.instance.ref(path);
}