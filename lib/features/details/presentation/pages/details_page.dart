// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favorite/presentation/pages/shared_pref.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import '../cubit/details_cubit.dart';
import '../cubit/details_state.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;
  DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1a1a2e),
              const Color(0xFF16213e),
              const Color(0xFF0f3460),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                      onTap: () {
                        addtofav(movie);
                      },
                      child: const Icon(Icons.bookmark_border,
                          color: Colors.white)),
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DetailsFailure) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image Section
                    Stack(
                      children: [
                        Hero(
                          tag: 'movie-${movie.id}',
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.poster_path}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                    Colors.black.withOpacity(0.95),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Rating Badge
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5959),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFF5959).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  movie.vote_average.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Content Section
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Info Chips
                          Row(
                            children: [
                              _buildInfoChip(
                                icon: Icons.calendar_today,
                                label: movie.release_date.substring(0, 4),
                              ),
                              const SizedBox(width: 10),
                              _buildInfoChip(
                                icon: Icons.trending_up,
                                label: movie.popularity.toInt().toString(),
                              ),
                              const SizedBox(width: 10),
                              _buildInfoChip(
                                icon: Icons.people,
                                label: '${movie.vote_count.toInt()} votes',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Star Rating Display
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                double rating = movie.vote_average / 2;
                                if (index < rating.floor()) {
                                  return const Icon(
                                    Icons.star,
                                    color: Color(0xFFFF5959),
                                    size: 24,
                                  );
                                } else if (index < rating) {
                                  return const Icon(
                                    Icons.star_half,
                                    color: Color(0xFFFF5959),
                                    size: 24,
                                  );
                                } else {
                                  return Icon(
                                    Icons.star_border,
                                    color: Colors.grey[600],
                                    size: 24,
                                  );
                                }
                              }),
                              const SizedBox(width: 8),
                              Text(
                                '${movie.vote_average.toStringAsFixed(1)}/10',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Divider
                          Divider(
                            color: Colors.grey[800],
                            thickness: 1,
                          ),
                          const SizedBox(height: 20),

                          // Overview Section
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            movie.overview.isNotEmpty
                                ? movie.overview
                                : 'No overview available for this movie.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[300],
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 30),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Watch Trailer'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF5959),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                child: const Icon(Icons.share),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFFF5959), size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  SharedPref sharedPref = SharedPref();
  void addtofav(Movie movie) {
    sharedPref.addToFav(movie);
  }
}
