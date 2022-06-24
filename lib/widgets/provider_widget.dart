import 'package:flutter_eft/Screens/services/auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends InheritedWidget {
  final AuthService auth;

  const AuthProvider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthProvider>();
}
