import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_state.dart';

class PrefsListView extends StatelessWidget {
  const PrefsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences List'),
        actions: [
          IconButton(
            onPressed: () => context.go('/api-list'),
            icon: const Icon(Icons.list),
            tooltip: 'API List',
          )
        ],
      ),
      body: BlocBuilder<PrefsCubit, PrefsState>(
        builder: (context, state) {
          if (state is PrefsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrefsLoaded) {
            if (state.preferences.isEmpty) {
              return Center(child: Text('No preferences saved yet'));
            }
            return ListView.builder(
              itemCount: state.preferences.length,
              itemBuilder: (context, index) {
                final pref = state.preferences[index];
                return ListTile(
                  //leading: pref.thumbnailUrl.isNotEmpty
                  //    ? Image.network(pref.thumbnailUrl, width: 48, height: 48, fit: BoxFit.cover)
                  //    : const Icon(Icons.image),
                  title: Text(pref.customName),
                  subtitle: Text('API id: ${pref.apiId}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => context.read<PrefsCubit>().deletePreference(index),
                  ),
                  onTap: () => context.go('/prefs/${index}', extra: {
                    'preference': pref,
                    'index': index,
                  }),
                );
              },
            );
          } else if (state is PrefsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}