import 'package:flutter/material.dart';
import 'package:football_news/models/menu_item.dart';
import 'package:football_news/screens/news_form_page.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/widgets/news_card.dart';
import 'package:football_news/utils/constants.dart';
import 'package:football_news/utils/routes.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const _profileDetails = <({String label, String value})>[
    (label: 'NPM', value: '2406352424'),
    (label: 'Nama', value: 'Haekal Alexander Dinova'),
    (label: 'Class', value: 'C'),
  ];

  static const _menuItems = <MenuItemData>[
    MenuItemData(
      title: 'See Football News',
      icon: Icons.newspaper_rounded,
      color: Color(0xFF1976D2),
      message: 'Kamu telah menekan tombol See Football News',
      action: MenuAction.viewNews,
    ),
    MenuItemData(
      title: 'Add News',
      icon: Icons.post_add_rounded,
      color: Color(0xFF2E7D32),
      message: 'Kamu telah menekan tombol Add News',
      action: MenuAction.addNews,
    ),
    MenuItemData(
      title: 'Logout',
      icon: Icons.logout_rounded,
      color: Color(0xFFC62828),
      message: 'Kamu telah menekan tombol Logout',
      action: MenuAction.logout,
    ),
  ];

  Future<void> _handleMenuTap(BuildContext context, MenuItemData item) async {
    final request = context.read<CookieRequest>();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(item.message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

    switch (item.action) {
      case MenuAction.viewNews:
        Navigator.pushNamed(context, newsListRoute);
        break;
      case MenuAction.addNews:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewsFormPage()),
        );
        break;
      case MenuAction.logout:
        final response = await request.logout('$baseUrl/auth/logout/');
        if (!context.mounted) return;

        if (response['status'] == true) {
          final username = response['username'] ?? 'user';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${response['message'] ?? 'Logged out successfully!'} '
                'See you again, $username.',
              ),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            loginRoute,
            (route) => false,
          );
        } else {
          final error = response['message'] ?? 'Logout failed.';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football News',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const LeftDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 720;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProfileSection(isNarrow: isNarrow),
                const SizedBox(height: 32),
                const Text(
                  'Selamat datang di Football News',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Dapatkan kabar terkini, transfer terbaru, dan cerita eksklusif seputar dunia sepak bola favoritmu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 36),
                _MenuSection(
                  isNarrow: isNarrow,
                  onTap: (item) => _handleMenuTap(context, item),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    final cards = MyHomePage._profileDetails
        .map((entry) => InfoCard(label: entry.label, value: entry.value))
        .toList();

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(child: cards[i]),
          if (i != cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.isNarrow, required this.onTap});

  final bool isNarrow;
  final Future<void> Function(MenuItemData) onTap;

  @override
  Widget build(BuildContext context) {
    final cards = MyHomePage._menuItems
        .map(
          (item) => NewsCard(
            item: item,
            onTap: () {
              onTap(item);
            },
          ),
        )
        .toList();

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(child: cards[i]),
          if (i != cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
