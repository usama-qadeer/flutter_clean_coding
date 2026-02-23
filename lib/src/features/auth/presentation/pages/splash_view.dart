// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:folder_stuture/features/auth/presentation/providers/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:folder_stuture/core/bootstrap/app_bootstrap_vm.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loadTriggered = false;

  @override
  void initState() {
    super.initState();

    // ✅ Run once after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _maybeStartBootstrap();
    });
  }

  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ If widget rebuilt by navigation, check again after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _maybeStartBootstrap();
    });
  }

  void _maybeStartBootstrap() {
    if (_loadTriggered) return;

    final auth = context.read<AuthState>();
    final bootstrap = context.read<AppBootstrapVM>();

    if (!auth.checking &&
        auth.isLoggedIn &&
        bootstrap.error == null &&
        !bootstrap.ready &&
        !bootstrap.loading) {
      _loadTriggered = true;
      bootstrap.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    // ✅ Listen ONLY to minimal fields (prevents extra rebuilds)
    final authChecking = context.select<AuthState, bool>((a) => a.checking);
    final isLoggedIn = context.select<AuthState, bool>((a) => a.isLoggedIn);

    final loading = context.select<AppBootstrapVM, bool>((b) => b.loading);
    final ready = context.select<AppBootstrapVM, bool>((b) => b.ready);
    final error = context.select<AppBootstrapVM, String?>((b) => b.error);

    // ✅ When auth changes (checking->false or login happens), try bootstrap
    // (defer to avoid build-phase issues)
    if (!authChecking &&
        isLoggedIn &&
        error == null &&
        !_loadTriggered &&
        !ready &&
        !loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _maybeStartBootstrap();
      });
    }

    String subtitle;
    if (authChecking) {
      subtitle = "Checking session…";
    } else if (!isLoggedIn) {
      subtitle = "Redirecting to login…";
    } else if (error != null) {
      subtitle = "Failed to load startup data";
    } else {
      subtitle = "Preparing your workspace…";
    }

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(Icons.storefront, size: 42, color: cs.primary),
                  ),
                  const SizedBox(height: 16),
                  Text("Code Art", style: tt.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  if (error != null) ...[
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        error,
                        textAlign: TextAlign.center,
                        style: tt.bodySmall?.copyWith(color: cs.error),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // ✅ Manual retry only when user taps
                        final bootstrap = context.read<AppBootstrapVM>();
                        bootstrap.reset();

                        _loadTriggered = false;

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          _maybeStartBootstrap();
                        });
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (error == null && isLoggedIn && !ready) ...[
                    const SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(strokeWidth: 2.6),
                    ),
                    const SizedBox(height: 10),
                  ],
                  Text(
                    subtitle,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
