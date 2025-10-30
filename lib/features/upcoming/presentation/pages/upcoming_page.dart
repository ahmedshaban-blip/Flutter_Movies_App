import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/routing/routes.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import '../cubit/upcoming_cubit.dart';
import '../cubit/upcoming_state.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return BlocProvider(
      create: (_) => UpcomingCubit()..doSomething(),
      child: Scaffold(
        backgroundColor: scheme.background,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.upcoming_outlined, size: 28, color: scheme.onSurface),
              const SizedBox(width: 8),
              Text(
                'Upcoming Movies',
                style: textTheme.titleLarge?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon:
                  Icon(Icons.search, color: scheme.onSurface.withOpacity(0.7)),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<UpcomingCubit, UpcomingState>(
          builder: (context, state) {
            if (state is UpcomingLoading) {
              return Center(
                child: CircularProgressIndicator(color: scheme.primary),
              );
            } else if (state is UpcomingFailure) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: scheme.onBackground),
                ),
              );
            } else if (state is UpcomingSuccess) {
              final result = state.result;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradients.bgGradient,
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.detailsScreen,
                            arguments: movie,
                          );
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: gradients.cardGradient,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Hero(
                                      tag: 'movie-${movie.id}',
                                      child: Container(
                                        height: 280,
                                        width: double.infinity,
                                        color: scheme.surface,
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
                                                strokeWidth: 2,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(
                                                Icons.error_outline,
                                                color: scheme.onSurface
                                                    .withOpacity(0.6),
                                                size: 48,
                                              ),
                                            );
                                          },
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
                                            scheme.scrim.withOpacity(0.7),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: _ratingColor(
                                                  movie.vote_average, semantic)
                                              .withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.white, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              movie.vote_average
                                                  .toStringAsFixed(1),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color:
                                              scheme.secondary.withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.trending_up,
                                                color: scheme.onSecondary,
                                                size: 14),
                                            const SizedBox(width: 4),
                                            Text(
                                              movie.popularity
                                                  .toStringAsFixed(0),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    color: scheme.onSecondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: textTheme.titleLarge?.copyWith(
                                          color: scheme.onSurface,
                                          letterSpacing: 0.3,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              size: 16,
                                              color: scheme.onSurface
                                                  .withOpacity(0.6)),
                                          const SizedBox(width: 6),
                                          Text(
                                            movie.release_date,
                                            style:
                                                textTheme.bodyMedium?.copyWith(
                                              color: scheme.onSurface
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: scheme.surface,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: scheme.primary
                                                    .withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.people,
                                                    size: 14,
                                                    color: scheme.onSurface
                                                        .withOpacity(0.7)),
                                                const SizedBox(width: 4),
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
                                      const SizedBox(height: 12),
                                      if (movie.overview.isNotEmpty)
                                        Text(
                                          movie.overview,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: scheme.onSurface
                                                .withOpacity(0.7),
                                            height: 1.4,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: Text(
                'Upcoming Page',
                style: textTheme.bodyMedium
                    ?.copyWith(color: scheme.onBackground.withOpacity(0.7)),
              ),
            );
          },
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
