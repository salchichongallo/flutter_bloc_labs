import 'dart:async';

enum AuthStatus { unknown, authenticated, guess }

class AuthenticationRepo {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.guess;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthStatus.guess);
  }

  void dispose() => _controller.close();
}
