import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/movie_model.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  static final List<MovieModel> movies = [
    const MovieModel(
      title: "The Shawshank Redemption",
      year: 1994,
      genre: "Drama",
      director: "Frank Darabont",
      rating: 9.3,
    ),
    const MovieModel(
      title: "Inception",
      year: 2010,
      genre: "Sci-Fi",
      director: "Christopher Nolan",
      rating: 7.8,
    ),
    const MovieModel(
      title: "Disaster Movie",
      year: 2008,
      genre: "Comedy",
      director: "Jason Friedberg",
      rating: 1.9,
    ),
  ];

  void _showRatingFeedback(BuildContext context, MovieModel movie) {
    final String message;
    if (movie.rating > 8.0) {
      message = "This is a highly rated movie!";
    } else if (movie.rating >= 6.0 && movie.rating <= 8.0) {
      message = "This is a good movie";
    } else {
      message = "This movie might need improvement";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies List"),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isHighRated = movie.rating >= 7.0;

          return ListTile(
            leading: Icon(
              Icons.movie,
              color: isHighRated
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isHighRated
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${movie.year} • ${movie.genre}',
                  style: TextStyle(
                    color: isHighRated
                        ? colorScheme.secondary
                        : colorScheme.onSurfaceVariant,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  "Director: ${movie.director}",
                  style: TextStyle(
                    color: isHighRated
                        ? colorScheme.secondary
                        : colorScheme.onSurfaceVariant,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: isHighRated
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  size: 16.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  movie.rating.toString(),
                  style: TextStyle(
                    color: isHighRated
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () => _showRatingFeedback(context, movie),
          );
        },
      ),
    );
  }
}
