import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/cubit/theme/theme_cubit.dart';
import 'package:movie_app/core/theme/app_colors.dart';
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
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return BlocProvider(
      create: (_) => FavoriteCubit()..getMovies(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradients.bgGradient,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_rounded, color: scheme.onSurface, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Favorite Page',
                  style: textTheme.titleLarge?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            actions: [
              BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
                selector: (state) => state.themeMode,
                builder: (context, mode) {
                  return IconButton(
                    icon: Icon(
                      mode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return Center(
                  child: CircularProgressIndicator(color: scheme.primary),
                );
              } else if (state is FavoriteFailure) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: scheme.onBackground),
                  ),
                );
              } else if (state is FavoriteLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = state.result[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: gradients.cardGradient,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color: scheme.primary.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
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
                              Stack(
                                children: {
                                  Hero(
                                    tag: 'movie-${movie.id}',
                                    child: Container(
                                      height: 280,
                                      width: double.infinity,
                                      color: scheme.surface,
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0.95)
                                          ],
                                        ).createShader(bounds),
                                        blendMode: BlendMode.dstIn,
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${movie.poster_path}',
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(scheme.primary),
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
                                                  Icon(Icons.movie_outlined,
                                                      color: scheme.onSurface
                                                          .withOpacity(0.38),
                                                      size: 64),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Image not available',
                                                    style: textTheme.labelSmall
                                                        ?.copyWith(
                                                      color: scheme.onSurface
                                                          .withOpacity(0.38),
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
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          scheme.scrim.withOpacity(0.4),
                                          scheme.scrim.withOpacity(0.8),
                                        ],
                                        stops: const [0.0, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: _ratingColor(
                                            movie.vote_average, semantic),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _ratingColor(
                                                    movie.vote_average,
                                                    semantic)
                                                .withOpacity(0.4),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
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
                                          const Icon(Icons.star_rounded,
                                              color: Colors.white, size: 18),
                                          const SizedBox(width: 5),
                                          Text(
                                            movie.vote_average
                                                .toStringAsFixed(1),
                                            style:
                                                textTheme.labelLarge?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            scheme.secondary,
                                            scheme.secondaryContainer
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: scheme.secondary
                                                .withOpacity(0.5),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
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
                                          Icon(
                                              Icons
                                                  .local_fire_department_rounded,
                                              color:
                                                  scheme.onSecondaryContainer,
                                              size: 16),
                                          const SizedBox(width: 5),
                                          Text(
                                            movie.popularity.toStringAsFixed(0),
                                            style:
                                                textTheme.labelMedium?.copyWith(
                                              color:
                                                  scheme.onSecondaryContainer,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                }.toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: textTheme.titleLarge?.copyWith(
                                        color: scheme.onSurface,
                                        fontWeight: FontWeight.bold,
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
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color:
                                                scheme.surface.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: scheme.primary
                                                  .withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.calendar_today_rounded,
                                                  size: 14,
                                                  color: scheme.onSurface
                                                      .withOpacity(0.7)),
                                              const SizedBox(width: 6),
                                              Text(
                                                movie.release_date.isNotEmpty
                                                    ? movie.release_date
                                                    : '',
                                                style: textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: scheme.onSurface
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color:
                                                scheme.surface.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: scheme.primary
                                                  .withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.people_rounded,
                                                  size: 15,
                                                  color: scheme.primary),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${movie.vote_count.toInt()} votes',
                                                style: textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: scheme.onSurface
                                                      .withOpacity(0.7),
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
                                        color: scheme.surface.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: scheme.onSurface
                                              .withOpacity(0.05),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        movie.overview,
                                        style: textTheme.bodySmall?.copyWith(
                                          color:
                                              scheme.onSurface.withOpacity(0.8),
                                          height: 1.6,
                                          letterSpacing: 0.2,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [
                                              scheme.primary,
                                              scheme.secondary
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: scheme.primary
                                                  .withOpacity(0.4),
                                              blurRadius: 20,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 16),
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
                                              const Icon(
                                                  Icons.heart_broken_rounded,
                                                  color: Colors.white,
                                                  size: 20),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Remove From Favorite",
                                                style: textTheme.labelLarge
                                                    ?.copyWith(
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
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
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
                  style:
                      textTheme.bodyLarge?.copyWith(color: scheme.onBackground),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _ratingColor(double rating, AppSemanticColors semantic) {
    if (rating >= 8.0) return semantic.ratingHigh;
    if (rating >= 6.0) return semantic.ratingMid;
    return semantic.ratingLow;
  }
}
