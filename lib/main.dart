import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/sources/api_service.dart';
import 'package:flutter_application_1/data/sources/hive_service.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:flutter_application_1/presentation/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final hiveService = HiveService();
  await hiveService.init();

  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;
  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiCubit>(
          create: (context) => ApiCubit(ApiService())..fetchItems(),
        ),
        BlocProvider<PrefsCubit>(
          create: (context) => PrefsCubit(hiveService)..loadPreferences(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: goRouter,
      ),
    );
  }
}
