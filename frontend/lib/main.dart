import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/viewmodels/auth_state.dart';
import 'app/app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthState(), child: const App()),
  );
}
