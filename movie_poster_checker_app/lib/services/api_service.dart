import "package:flutter_dotenv/flutter_dotenv.dart";
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/prediction_result.dart';

class ApiService {
  String? get baseURL => dotenv.env['baseURL'];
  String? get port => dotenv.env['port'];

  String get finalURL => '$baseURL:$port';

  Future<PredictionResult?> predictGenre(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$finalURL/predict'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return PredictionResult.fromJson(jsonResponse);
      } else {
        throw Exception(
          "Failed to predict genre. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
