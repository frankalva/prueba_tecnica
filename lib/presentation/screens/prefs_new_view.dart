import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/item.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_state.dart';
import 'package:go_router/go_router.dart';

class PrefsNewView extends StatefulWidget {
  final Item? item;
  PrefsNewView({Key? key, this.item}) : super(key: key);

  @override
  State<PrefsNewView> createState() => _PrefsNewViewState();
}

class _PrefsNewViewState extends State<PrefsNewView> {
  Item? _selectedItem;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.item;
    if (_selectedItem != null) {
      _nameController.text = _selectedItem!.title;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Preference')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecciona un ítem de la API'),
            const SizedBox(height: 8),
            BlocBuilder<ApiCubit, ApiState>(
              builder: (context, state) {
                if (state is ApiLoading)
                  return const CircularProgressIndicator();
                if (state is ApiLoaded) {
                  return DropdownButton<Item>(
                    isExpanded: true,
                    value: _selectedItem,
                    hint: const Text('Elige un ítem'),
                    items: state.items
                        .map(
                          (i) =>
                              DropdownMenuItem(value: i, child: Text(i.title)),
                        )
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedItem = v;
                        _nameController.text = v?.title ?? '';
                      });
                    },
                  );
                }
                if (state is ApiError) return Text(state.message);
                return const SizedBox();
              },
            ),
            const SizedBox(height: 12),
            const Text('Nombre personalizado'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_selectedItem == null) return;
                    final pref = Preference(
                      apiId: _selectedItem!.id,
                      customName: _nameController.text.trim().isEmpty
                          ? _selectedItem!.title
                          : _nameController.text.trim(),
                      thumbnailUrl: _selectedItem!.thumbnailUrl,
                    );
                    context.read<PrefsCubit>().addPreference(pref);
                    // go to prefs list
                    context.push('/prefs');
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/api-list');
                    }
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
