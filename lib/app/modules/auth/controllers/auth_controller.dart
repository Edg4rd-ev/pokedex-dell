import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/firebase_service.dart';

part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  final FirebaseService _service;
  AuthControllerBase(this._service);

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @action
  Future<bool> login(String email, String pass) async {
    loading = true;
    errorMessage = null;
    try {
      final User? user = await _service.login(email, pass);
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      loading = false;
    }
  }

  @action
  Future<bool> signup(String email, String pass) async {
    loading = true;
    errorMessage = null;
    try {
      final User? user = await _service.signup(email, pass);
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      loading = false;
    }
  }

  @action
  Future<bool> loginWithGoogle() async {
    loading = true;
    errorMessage = null;
    try {
      final User? user = await _service.loginWithGoogle();
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      loading = false;
    }
  }
}
