import 'package:flutter/material.dart';

import 'package:football_news/widgets/left_drawer.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  static final List<Map<String, String>> _sampleNews = [
    {
      'title': 'Transfer Musim Panas',
      'category': 'transfer',
    },
    {
      'title': 'Analisis Laga Derby',
      'category': 'analysis',
    },
    {
      'title': 'Update Cedera Pemain',
      'category': 'update',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Berita',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sampleNews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final news = _sampleNews[index];
          return Card(
            child: ListTile(
              title: Text(news['title'] ?? '-'),
              subtitle: Text(
                'Kategori: ${news['category']}',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
