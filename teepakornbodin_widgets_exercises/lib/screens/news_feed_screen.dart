import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/article_model.dart';
import 'package:teepakornbodin_widgets_exercises/utils/responsive.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  static const List<Article> articles = [
    Article(
      title: 'Introduction to Flutter',
      description: 'Learn the basics of Flutter development...',
      date: '2024-01-05',
      readingTimeMinutes: 5,
    ),
    Article(
      title: 'Advanced Widget Patterns',
      description: 'Discover advanced patterns in Flutter...',
      date: '2024-01-04',
      readingTimeMinutes: 8,
    ),
    Article(
      title: 'State Management in Flutter',
      description: 'Explore different state management approaches...',
      date: '2024-01-03',
      readingTimeMinutes: 12,
    ),
    Article(
      title: 'Building Responsive UIs',
      description: 'Create apps that work on any screen size...',
      date: '2024-01-02',
      readingTimeMinutes: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Feed'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final columnCount = Responsive.getColumnCount(width);

            if (Responsive.isMobile(width)) {
              return _buildListView();
            } else {
              return _buildGridView(columnCount);
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: articles.length,
      itemBuilder: (context, index) =>
          _buildArticleCard(context, articles[index]),
    );
  }

  Widget _buildGridView(int columnCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 2,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) =>
          _buildArticleCard(context, articles[index]),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${article.readingTimeMinutes} min read',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
