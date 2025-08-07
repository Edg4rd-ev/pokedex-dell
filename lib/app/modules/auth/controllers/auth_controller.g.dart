// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on AuthControllerBase, Store {
  late final _$loadingAtom = Atom(
    name: 'AuthControllerBase.loading',
    context: context,
  );

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'AuthControllerBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    'AuthControllerBase.login',
    context: context,
  );

  @override
  Future<bool> login(String email, String pass) {
    return _$loginAsyncAction.run(() => super.login(email, pass));
  }

  late final _$signupAsyncAction = AsyncAction(
    'AuthControllerBase.signup',
    context: context,
  );

  @override
  Future<bool> signup(String email, String pass) {
    return _$signupAsyncAction.run(() => super.signup(email, pass));
  }

  late final _$loginWithGoogleAsyncAction = AsyncAction(
    'AuthControllerBase.loginWithGoogle',
    context: context,
  );

  @override
  Future<bool> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}
