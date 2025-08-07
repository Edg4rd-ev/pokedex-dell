import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> login(String email, String pass) =>
      auth.signInWithEmailAndPassword(email: email, password: pass)
          .then((cred) => cred.user);

  Future<User?> signup(String email, String pass) =>
      auth.createUserWithEmailAndPassword(email: email, password: pass)
          .then((cred) => cred.user);

  Future<User?> loginWithGoogle() async {
    await _googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    final googleAuth = googleUser.authentication;

    final authClient = _googleSignIn.authorizationClient;
    GoogleSignInClientAuthorization? authorization =
    await authClient.authorizationForScopes(['email']);
    authorization ??= await authClient.authorizeScopes(['email']);

    final credential = GoogleAuthProvider.credential(
      idToken:    googleAuth.idToken,
      accessToken: authorization.accessToken,
    );

    return auth.signInWithCredential(credential)
        .then((cred) => cred.user);
  }

  Future<void> logout() => auth.signOut();
}
