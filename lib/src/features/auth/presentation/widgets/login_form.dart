// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:folder_stuture/core/bootstrap/app_bootstrap_vm.dart';
import 'package:folder_stuture/core/extensions/extensions.dart';
import 'package:folder_stuture/core/theme/app_colors.dart';
import 'package:folder_stuture/core/shared/widgets/custom_elevted_button.dart';
import 'package:provider/provider.dart';
import '../providers/login_vm.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginVM>();
    return AnimatedBuilder(
      animation: vm,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            8.vGap,
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            if (vm.isLoading) const CircularProgressIndicator(),
            if (vm.error != null)
              Text(
                vm.error!,
                style: const TextStyle(color: AppColors.dangerRed),
              ),
            if (!vm.isLoading)
              CustomElevatedButton(
                text: 'Login',
                onPressed: () async {
                  await vm.login(
                    context,
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    onLoggedIn: () => context.read<AppBootstrapVM>().reset(),
                  );

                  if (vm.user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successful')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.dangerRed,
                        content: Text(
                          vm.error ?? 'Error',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
          ],
        );
      },
    );
  }
}
