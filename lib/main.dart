import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/theme/custom_theme.dart';
import 'package:self_project/common/theme/custom_theme_app.dart';
import 'package:self_project/firebase_options.dart';
import 'package:self_project/fragment/fragment_teacher_profile.dart';
import 'package:self_project/object/object_extended_teacher_profile.dart';
import 'package:self_project/screen/screen_classify.dart';
import 'package:self_project/screen/screen_login.dart';
import 'package:self_project/screen/screen_main.dart';
import 'package:self_project/screen/screen_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      print(e);
    }
  }

  runApp(ProviderScope(child: App()));
}

class App extends StatefulWidget {
  static const defaultTheme = CustomTheme.lightTheme;
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const MainScreen(), routes: [
        GoRoute(
          path: 'teacher-profile/:id',
          builder: (context, state) => TeacherProfileFragment(
              state.pathParameters['id']!,
              extendedTeacher: state.extra as ExtendedTeacherProfile),
        )
      ]),
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
                path: 'initial',
                builder: (context, state) => const ClassifyScreen(),
                routes: [
                  GoRoute(
                    path: 'setup',
                    builder: (context, state) => const SetupScreen(),
                  )
                ]),
          ])
    ],
  );

  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return MaterialApp.router(
          theme: context.themeType.themeData,
          routerConfig: widget.router,
        );
      }),
    );
  }
}
