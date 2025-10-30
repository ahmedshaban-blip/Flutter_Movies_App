// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favorite/presentation/pages/shared_pref.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final sharedPref = SharedPref();
  late Future<List<Movie>> favMoviesFuture;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit()..getMovies(),
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
            title: const Text('Favorite Page',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FavoriteFailure) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is FavoriteLoaded) {
                return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    var movie = state.result[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF1a1a2e),
                                const Color(0xFF16213e),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFFe94560).withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                                spreadRadius: -5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // صورة الفيلم مع تراكب Gradient
                              Stack(
                                children: [
                                  Hero(
                                    tag: 'movie-${movie.id}',
                                    child: Container(
                                      height: 280,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                      ),
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0.95),
                                          ],
                                        ).createShader(bounds),
                                        blendMode: BlendMode.dstIn,
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${movie.poster_path}',
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFFe94560),
                                                ),
                                                strokeWidth: 3,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.movie_outlined,
                                                    color: Colors.white38,
                                                    size: 64,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Image not available',
                                                    style: TextStyle(
                                                      color: Colors.white38,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Enhanced Gradient Overlay
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.4),
                                          Colors.black.withOpacity(0.8),
                                        ],
                                        stops: [0.0, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                  // شارة التقييم
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            _getRatingColor(movie.vote_average),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _getRatingColor(
                                                    movie.vote_average)
                                                .withOpacity(0.4),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            movie.vote_average
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // شارة الشعبية
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFFe94560),
                                            const Color(0xFFff6b9d),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFe94560)
                                                .withOpacity(0.5),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.local_fire_department_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            movie.popularity.toStringAsFixed(0),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // معلومات الفيلم
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0f3460)
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color(0xFFe94560)
                                                  .withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_rounded,
                                                size: 14,
                                                color: Colors.white70,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0f3460)
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color(0xFFe94560)
                                                  .withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.people_rounded,
                                                size: 15,
                                                color: const Color(0xFFe94560),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                ' votes',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.05),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        movie.overview,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.8),
                                          height: 1.6,
                                          letterSpacing: 0.2,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFe94560),
                                        const Color(0xFFd63447),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFe94560)
                                            .withOpacity(0.4),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 16,
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<FavoriteCubit>()
                                          .removeMovie(movie);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.heart_broken_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Remove From Favorite",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              
              return Center(
                child: Text(
                  'No favorite movies found.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) {
      return const Color(0xFF00e676); // أخضر للتقييمات الممتازة
    } else if (rating >= 6.0) {
      return const Color(0xFFffd600); // أصفر للتقييمات الجيدة
    } else {
      return const Color(0xFFff6b6b); // أحمر للتقييمات المنخفضة
    }
  }
}
