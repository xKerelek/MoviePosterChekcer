class GenreProbability {
  final String genre;
  final double probability;

  GenreProbability({required this.genre, required this.probability});

  factory GenreProbability.fromJson(Map<String, dynamic> json) {
    return GenreProbability(
      genre: json['genre'],
      probability: json['probability'].toDouble(),
    );
  }
}

class PredictionResult {
  final bool success;
  final List<GenreProbability> predictedGenres;
  final String? gradcamImageBase64;

  PredictionResult({
    required this.success,
    required this.predictedGenres,
    this.gradcamImageBase64,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    var list = json['predicted_genres'] as List? ?? [];
    List<GenreProbability> genresList = list
        .map((i) => GenreProbability.fromJson(i))
        .toList();

    return PredictionResult(
      success: json['success'] ?? false,
      predictedGenres: genresList,
      gradcamImageBase64: json['gradcam_image_base64'],
    );
  }
}
