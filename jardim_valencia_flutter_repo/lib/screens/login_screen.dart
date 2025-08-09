import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> _login() async {
    setState(() { loading = true; error = null; });
    try {
      await AuthService.signIn(email.text.trim(), pass.text.trim());
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => error = 'Falha ao entrar. Verifique credenciais.');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24, width: 1.2),
                    ),
                    child: const Center(child: Icon(Icons.circle_outlined, size: 28)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Jardim de Valência',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 32),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Entrar', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'E-mail')),
                    const SizedBox(height: 12),
                    TextField(controller: pass, obscureText: true, decoration: const InputDecoration(hintText: 'Senha')),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: loading ? null : _login,
                      child: loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Continuar'),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 8),
                      Text(error!, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.redAccent)),
                    ],
                    const SizedBox(height: 4),
                    Text('Acesso restrito a moradores e equipe.
Condomínio: Jardim de Valência',
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
              const Spacer(),
              Text('Design minimalista • vidro • preto/branco', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white38)),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
