import 'package:flutter/material.dart';
import 'package:folder_stuture/core/extensions/extensions.dart';
import 'package:folder_stuture/core/theme/theme_vm.dart';
import 'package:provider/provider.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            onPressed: () {
              final theme = context.read<ThemeVM>();
              if (theme.mode == ThemeMode.dark) {
                theme.setMode(ThemeMode.light);
              } else {
                theme.setMode(ThemeMode.dark);
              }
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(child: LoginForm()).px16,
    );
  }
}
