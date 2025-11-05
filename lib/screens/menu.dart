import 'package:flutter/material.dart';

import 'package:football_news/screens/news_list.dart';
import 'package:football_news/screens/newslist_form.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/widgets/news_card.dart';

class NewsMenuItem {
  const NewsMenuItem({
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });

  final String name;
  final IconData icon;
  final Color backgroundColor;
}

final List<NewsMenuItem> newsMenuItems = [
  const NewsMenuItem(
    name: 'See Football News',
    icon: Icons.article_outlined,
    backgroundColor: Color(0xFF3B82F6),
  ),
  const NewsMenuItem(
    name: 'Add News',
    icon: Icons.add,
    backgroundColor: Color(0xFF3B82F6),
  ),
  const NewsMenuItem(
    name: 'Logout',
    icon: Icons.logout,
    backgroundColor: Color(0xFF1E3A8A),
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _handleNavigation(BuildContext context, NewsMenuItem item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Kamu telah menekan tombol ${item.name}!'),
        ),
      );

    if (item.name == 'Add News') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewsFormPage(),
        ),
      );
    } else if (item.name == 'See Football News') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewsListPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _InfoSection(maxWidth: constraints.maxWidth),
                const SizedBox(height: 32),
                Text(
                  'Selamat datang di Football News',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),
                _MenuGrid(
                  maxWidth: constraints.maxWidth,
                  onTap: (item) => _handleNavigation(context, item),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.maxWidth});

  final double maxWidth;

  static const List<Map<String, String>> _infoData = [
    {'label': 'NPM', 'value': '2406275678'},
    {'label': 'Name', 'value': 'Lionel Messi'},
    {'label': 'Class', 'value': 'B'},
  ];

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    final useRow = maxWidth >= 600;
    final cardWidth =
        useRow ? (maxWidth - spacing * (_infoData.length - 1)) / _infoData.length : maxWidth;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: _infoData
          .map(
            (data) => SizedBox(
              width: cardWidth,
              child: _ProfileInfoCard(
                title: data['label'] ?? '-',
                value: data['value'] ?? '-',
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({
    required this.maxWidth,
    required this.onTap,
  });

  final double maxWidth;
  final ValueChanged<NewsMenuItem> onTap;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = maxWidth >= 700
        ? 3
        : maxWidth >= 480
            ? 2
            : 1;

    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: 1.1,
      children: [
        for (final item in newsMenuItems)
          NewsCard(
            item: item,
            onTap: () => onTap(item),
          ),
      ],
    );
  }
}
