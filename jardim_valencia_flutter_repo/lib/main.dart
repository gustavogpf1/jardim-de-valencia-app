import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/package_detail_screen.dart';
import 'services/firebase_boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseBoot.init();
  runApp(const JardimValenciaApp());
}

class JardimValenciaApp extends StatelessWidget {
  const JardimValenciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jardim de Valência',
      theme: JVTheme.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == PackageDetailScreen.route) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => PackageDetailScreen(pkgId: args['pkgId']),
          );
        }
        return null;
      },
    );
  }
}
