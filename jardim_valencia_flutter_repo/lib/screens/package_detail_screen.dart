import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../services/packages_repo.dart';
import '../services/auth_service.dart';

class PackageDetailScreen extends StatefulWidget {
  static const route = '/package-detail';
  final String pkgId;
  const PackageDetailScreen({super.key, required this.pkgId});
  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  Map<String, dynamic>? data;
  bool loading = true;
  bool marking = false;

  Future<void> _load() async {
    final d = await PackagesRepo.getById(widget.pkgId);
    setState(() { data = d; loading = false; });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _markPicked() async {
    setState(() => marking = true);
    await PackagesRepo.markPickedUp(widget.pkgId, AuthService.uid!);
    if (mounted) {
      setState(() => marking = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Encomenda marcada como retirada.')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final pkg = data!;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: ListView(
          children: [
            GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 56, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white24)), child: const Icon(Icons.all_inbox_outlined)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.pkgId, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(pkg['apartmentId'] ?? '-', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                ])),
              ]),
              const SizedBox(height: 12),
              const Divider(color: Colors.white24),
              const SizedBox(height: 12),
              if (pkg['createdAt'] != null) Text('Recebida: ${pkg['createdAt'].toDate().toString().substring(0,16)}'),
              if (pkg['notes'] != null && (pkg['notes'] as String).isNotEmpty) ...[const SizedBox(height: 8), Text('Notas: ${pkg['notes']}')],
            ])),
            const SizedBox(height: 16),
            if (pkg['status'] != 'picked_up')
              ElevatedButton(onPressed: marking ? null : _markPicked,
                child: marking ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Encomenda retirada'),
              )
            else
              GlassCard(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.check_circle_outline), SizedBox(width:8), Text('Encomenda já retirada')])),
          ],
        ),
      ),
    );
  }
}
