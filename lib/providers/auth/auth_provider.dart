import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:state_notifier/state_notifier.dart';

import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvider() : super(AuthState.unknown());

  @override
  void update(Locator watch) {
    final user = watch<fb_auth.User?>();

    if (user != null) {
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
      );
    } else {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
      );
    }
    print('[디버깅] authState: $state');

    super.update(watch);
  }

  void signout() async {
    await read<AuthRepository>().signout();
  }
}
