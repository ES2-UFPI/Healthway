import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { patient, nutritionist }

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserType> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Check if the user is a patient or nutritionist
        DocumentSnapshot patientDoc =
            await _firestore.collection('paciente').doc(user.uid).get();
        if (patientDoc.exists) {
          return UserType.patient;
        }

        DocumentSnapshot nutritionistDoc =
            await _firestore.collection('nutricionista').doc(user.uid).get();
        if (nutritionistDoc.exists) {
          return UserType.nutritionist;
        }

        // If user is neither patient nor nutritionist, sign out and throw an error
        await _auth.signOut();
        throw Exception(
            'Usuário não encontrado como paciente ou nutricionista');
      }

      throw Exception('Falha ao fazer login');
    } catch (e) {
      print(e.toString());
      throw Exception('Falha ao fazer login: ${e.toString()}');
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
