import 'package:flutter/material.dart';
import 'package:football_news/screens/login_page.dart';
import 'package:football_news/screens/menu.dart';
import 'package:football_news/screens/news_entry_list.dart';
import 'package:football_news/utils/routes.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FootballNewsApp());
}

class FootballNewsApp extends StatelessWidget {
  const FootballNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
      scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      useMaterial3: false,
    );

    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'Football News',
        theme: theme,
        debugShowCheckedModeBanner: false,
        initialRoute: loginRoute,
        routes: {
          loginRoute: (context) => const LoginPage(),
          homeRoute: (context) => const MyHomePage(),
          newsListRoute: (context) => const NewsEntryListPage(),
        },
      ),
    );
  }
}
