import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/storage/local_storage.dart';
import 'features/packages/presentation/screens/packages_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: JsonPackagesApp(),
    ),
  );
}

class JsonPackagesApp extends ConsumerWidget {
  const JsonPackagesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageAsync = ref.watch(sharedPreferencesProvider);
    final dirAsync = ref.watch(packagesDirectoryProvider);

    return MaterialApp(
      title: 'JSON Packages Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: storageAsync.when(
        data: (_) => dirAsync.when(
          data: (_) => const PackagesScreen(),
          loading: () => const _LoadingScreen(),
          error: (e, _) => _ErrorScreen(error: e.toString()),
        ),
        loading: () => const _LoadingScreen(),
        error: (e, _) => _ErrorScreen(error: e.toString()),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String error;

  const _ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to initialize app',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}