import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/like_repository.dart';
import 'package:flutter_application_1/data/repositories/post_repository.dart';
import 'package:flutter_application_1/data/sources/hive_service.dart';
import 'package:flutter_application_1/data/sources/like_local_service.dart';
import 'package:flutter_application_1/data/sources/post_api_service.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/post_cubit/post_cubit.dart';
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
        // Cubit para el fetch de posts 
        BlocProvider<PostCubit>(
          create: (_) =>
              PostCubit(PostRepository(PostApiService()))..fetchPosts(),
        ),
        // Cubit para gestionar likes con persistencia local
        BlocProvider<LikeCubit>(
          create: (_) =>
              LikeCubit(LikeRepository(LikeLocalService()))..loadLikes(),
        ),
      ],
      child: MaterialApp.router(
        title: 'eCommerce Posts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        routerConfig: goRouter,
      ),
    );
  }
}
