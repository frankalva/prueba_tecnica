import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_state.dart';
import 'package:flutter_application_1/presentation/widgets/error_widget.dart';
import 'package:flutter_application_1/presentation/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ApiListView extends StatefulWidget {
  const ApiListView({Key? key}) : super(key: key);

  @override
  State<ApiListView> createState() => _ApiListViewState();
}

class _ApiListViewState extends State<ApiListView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    setState(() {
      _isSearching = true;
    });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _query = val.toLowerCase();
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Items'),
        actions: [
          IconButton(
            onPressed: () => context.push('/prefs'),
            icon: const Icon(Icons.bookmark),
            tooltip: 'Preferences',
          ),
        ],
      ),
      body: BlocBuilder<ApiCubit, ApiState>(
        builder: (context, state) {
          if (state is ApiLoading) {
            return ProgressWidget();
          } else if (state is ApiLoaded) {
            final items = state.items
                .where((it) => it.title.toLowerCase().contains(_query))
                .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search items',
                      suffix: _isSearching
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Text(
                            _query.isEmpty
                                ? 'No items found'
                                : 'No results for "$_query"',
                          ),
                        )
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              //leading: Image.network(item.thumbnailUrl, width: 56, height: 56, fit: BoxFit.contain),
                              title: Text(item.title),
                              subtitle: Text('ID: ${item.id}'),
                              trailing: ElevatedButton(
                                onPressed: () =>
                                    context.go('/prefs/new', extra: item),
                                child: const Text('Select'),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (state is ApiError) {
            return ErrorScreen(
              message: state.message,
              onRetry: () => context.read<ApiCubit>().fetchItems(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
