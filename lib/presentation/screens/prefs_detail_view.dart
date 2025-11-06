import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:go_router/go_router.dart';

class PrefsDetailView extends StatelessWidget {
  final Preference? preference;
  final int? index;

  const PrefsDetailView({Key? key, this.preference, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(preference?.customName ?? 'Preference Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (preference != null)
              Column(
                children: [
                  //Image.network(preference!.thumbnailUrl, height: 120, width: 120, fit: BoxFit.cover),
                  const SizedBox(height: 12),
                  Text(preference!.customName, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('API ID: ${preference!.apiId}'),
                ],
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    if (index != null) {
                      // delete and pop
                      context.read<PrefsCubit>().deletePreference(index!);
                    }
                    context.push('/api-list');
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => context.go('/prefs'),
                  child: const Text('Volver'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}