import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/prediction_result.dart';

class ResultCard extends StatelessWidget {
  final bool isLoading;
  final PredictionResult? predictionResult;

  const ResultCard({super.key, required this.isLoading, this.predictionResult});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      );
    }

    if (predictionResult == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 6,
      shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Przewidywane gatunki:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            ...predictionResult!.predictedGenres.map((genreProb) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      genreProb.genre,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      '${(genreProb.probability * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            if (predictionResult!.gradcamImageBase64 != null) ...[
              const SizedBox(height: 24),
              Text(
                'Widok Grad-CAM:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.memory(
                  base64Decode(predictionResult!.gradcamImageBase64!),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
