import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/screen/screen_setting.dart';

import 'chat/screen_chat.dart';
import 'common/extension/extension_context.dart';
import 'common/theme/custom_theme.dart';
import 'common/theme/custom_theme_app.dart';
import 'firebase_options.dart';
import 'model/model_student.dart';
import 'onboarding/screen_onboarding.dart';
import 'review/screen_add_review.dart';
import 'setup/screen/screen_student_setup.dart';
import 'student/screen/screen_teacher_profile.dart';
import 'model/model_teacher.dart';
import 'setup/screen/screen_classify.dart';
import 'login/screen/screen_login.dart';
import 'screen/screen_main.dart';
import 'setup/screen/screen_teacher_setup.dart';
import 'teacher/screen/screen_student_profile.dart';
import 'review/screen_add_reply.dart';

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
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen()),
      GoRoute(
          path: '/',
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              path: 'teacher-profile/:id',
              name: 'teacher-profile',
              builder: (context, state) => TeacherProfileScreen(
                  id: state.pathParameters['id']!,
                  teacher: state.extra as Teacher),
            ),
            GoRoute(
              path: 'student-profile/:id',
              name: 'student-profile',
              builder: (context, state) => StudentProfileScreen(
                  id: state.pathParameters['id']!,
                  student: state.extra as Student),
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
                    path: 'teacher-setup',
                    builder: (context, state) => const TeacherSetupScreen(),
                  ),
                  GoRoute(
                    path: 'student-setup',
                    builder: (context, state) => const StudentSetupScreen(),
                  )
                ]),
          ]),
      GoRoute(
        path: '/new-review',
        name: 'new-review',
        builder: (context, state) => AddReviewScreen(
          teacher: state.extra as Teacher,
        ),
      ),
      GoRoute(
        path: '/new-reply/:email',
        name: 'new-reply',
        builder: (context, state) => AddReplyScreen(
          reviewer: state.pathParameters['email']!,
          teacher: state.extra as Teacher,
        ),
      ),
      GoRoute(
        path: '/chat/:email',
        name: 'chat',
        builder: ((context, state) {
          final data = state.extra! as Map<String, dynamic>;
          return ChatScreen(
            receiverEmail: state.pathParameters['email']!,
            name: data['name'],
            profileImage: data['profileImage'],
            docName: data['docName'],
            accountType: data['accountType'],
          );
        }),
      ),
      GoRoute(
          path: '/setting',
          builder: ((context, state) => const SettingScreen()))
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
