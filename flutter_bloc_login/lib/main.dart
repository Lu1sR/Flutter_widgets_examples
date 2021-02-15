import 'package:flutter/material.dart';

import 'app.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/repositories/user_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
