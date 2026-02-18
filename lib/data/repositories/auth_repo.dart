import 'package:firebase_auth/firebase_auth.dart';

import '../../core/services/auth_service.dart';
import '../models/signup_model.dart';
import '../models/user_model.dart';

class AuthRepository {
	final AuthService _service;

	AuthRepository(AuthService authService, {AuthService? service}) : _service = service ?? AuthService();

	// Attempts to sign in a user with [email] and [password].
	// Returns a [LoginModel] on success or throws on failure.
	Future<UserModel> getUserCredentials(String email, String password) async {
		try {
			final UserModel? user = await _service.login(email, password);
			if (user == null) throw Exception('Unable to login user');
			return UserModel(uid: user.uid, email: user.email);
		} on FirebaseAuthException catch (e) {
      throw e.message.toString();
		} catch (e) {
      rethrow;
    }
	}

	// Creates a new user account. [username] may be a single name; it will
	// be used as `firstName` and `lastName` will be empty.
	Future<SignupModel> createUserAccount(String username,  String email, String mobileNumber, String password) async {
		try {
			final names = username.split(' ');
			final firstName = names.isNotEmpty ? names.first : username;
			final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

			final UserModel? user = await _service.signup(firstName, lastName, email, mobileNumber, password);
			if (user == null) throw Exception('Unable to create account');

			return SignupModel(
				firstName: firstName,
				lastName: lastName,
				email: email,
				mobileNumber: mobileNumber,
				pwd: password,
				confirmPwd: password,
			);
		} catch (e) {
			rethrow;
		}
	}

	Future<void> signOut() async => _service.logout();

	Future<void> forgotPassword(String email) async => _service.passwordReset(email);
}

