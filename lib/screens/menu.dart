import 'package:flutter/material.dart';

import 'package:football_news/screens/news_list.dart';
import 'package:football_news/screens/newslist_form.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/widgets/news_card.dart';

class NewsMenuItem {
  const NewsMenuItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });

  final String name;
  final IconData icon;
  final Color color;
  final String description;
}

final List<NewsMenuItem> newsMenuItems = [
  const NewsMenuItem(
    name: 'Lihat Berita',
    icon: Icons.article,
    color: Colors.indigo,
    description: 'Baca rangkuman berita sepak bola terbaru.',
  ),
  const NewsMenuItem(
    name: 'Tambah Berita',
    icon: Icons.post_add,
    color: Colors.green,
    description: 'Tambahkan berita baru ke dalam daftar.',
  ),
  const NewsMenuItem(
    name: 'Berita Unggulan',
    icon: Icons.star_rate,
    color: Colors.orange,
    description: 'Lihat berita pilihan yang sedang trending.',
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

    if (item.name == 'Tambah Berita') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewsFormPage(),
        ),
      );
    } else if (item.name == 'Lihat Berita') {
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
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 1;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Mahasiswa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text('Nama: Haekal Alexander Dinova'),
                        Text('NPM: 2406352424'),
                        Text('Kelas: PBP C'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    for (final item in newsMenuItems)
                      NewsCard(
                        item: item,
                        onTap: () => _handleNavigation(context, item),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
