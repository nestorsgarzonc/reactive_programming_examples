import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_reactive_flutter/view/chat_screen.dart';
import 'package:front_reactive_flutter/view/on_boarding_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reactive Programming demo',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => _UnfocusWidget(child: child),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      initialRoute: OnBoardingScreen.route,
      navigatorKey: navKey,
      routes: {
        ChatScreen.route: (_) => const ChatScreen(),
        OnBoardingScreen.route: (_) => OnBoardingScreen(),
      },
    );
  }
}

class _UnfocusWidget extends StatelessWidget {
  const _UnfocusWidget({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}
