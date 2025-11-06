import 'package:flutter_application_1/data/model/item.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';
import 'package:flutter_application_1/presentation/screens/api_list_view.dart';
import 'package:flutter_application_1/presentation/screens/prefs_detail_view.dart';
import 'package:flutter_application_1/presentation/screens/prefs_list_view.dart';
import 'package:flutter_application_1/presentation/screens/prefs_new_view.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/api-list',
  routes: [
    GoRoute(
      path: '/api-list',
      name: 'api-list',
      builder: (context, state) => const ApiListView(),
    ),
    GoRoute(
      path: '/prefs',
      name: 'prefs',
      builder: (context, state) => const PrefsListView(),
    ),
    GoRoute(
      path: '/prefs/new',
      name: 'prefs-new',
      builder: (context, state) {
        final item = state.extra as Item?;
        return PrefsNewView(item: item);
      },
    ),
    GoRoute(
      path: '/prefs/:id',
      name: 'prefs-detail',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map<String, dynamic>) {
          final pref = extra['preference'] as Preference?;
          final index = extra['index'] as int?;
          return PrefsDetailView(preference: pref, index: index);
        }
        final pref = state.extra as Preference?;
        return PrefsDetailView(preference: pref);
      },
    ),
  ],
);
