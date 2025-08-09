import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../services/auth_service.dart';
import '../services/packages_repo.dart';
import '../models/package.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> myApts = [];
  Stream<List<JVPackage>>? pending$;
  Stream<List<JVPackage>>? picked$;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    myApts = await AuthService.getUserApartmentIds();
    setState(() {
      pending$ = PackagesRepo.streamMyPending(myApts);
      picked$  = PackagesRepo.streamMyPicked(myApts);
    });
  }

  String fmt(DateTime d) => DateFormat('dd/MM/yyyy HH:mm').format(d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Encomendas')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Text('Pendentes', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            StreamBuilder<List<JVPackage>>(
              stream: pending$,
              builder: (_, snap) {
                final items = snap.data ?? [];
                return Column(children: items.map((pkg) => GlassCard(
                  onTap: () => Navigator.pushNamed(context, '/package-detail', arguments: {'pkgId': pkg.id}),
                  child: Row(
                    children: [
                      Container(width: 48, height: 48, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white24)), child: const Icon(Icons.all_inbox_outlined)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(pkg.id, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text('Apto: ${pkg.apartmentId}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                      ])),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                )).toList());
              },
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            Text('Retiradas', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            StreamBuilder<List<JVPackage>>(
              stream: picked$,
              builder: (_, snap) {
                final items = snap.data ?? [];
                return Column(children: items.map((pkg) => GlassCard(
                  child: Row(children: [
                    Container(width: 48, height: 48, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white24)), child: const Icon(Icons.check_circle_outline)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(pkg.id, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(pkg.pickedUpAt == null ? '' : 'Retirada: ${fmt(pkg.pickedUpAt!)}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                    ])),
                  ]),
                )).toList());
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
