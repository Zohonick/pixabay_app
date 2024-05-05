import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pixabay/main.dart';
import 'package:pixabay/Repository/entity/images_data_entity.dart';

class PixabayRepository {
  final logger = getIt<Logger>();

  static const pixabayUrl = 'https://pixabay.com/api/';

  static const apiKey = '43575310-158581d45b9acbd15e76983b9';

  Future<ImagesData?> fetchImagesData(String query, int page) async {
    final url = Uri.parse('$pixabayUrl?key=$apiKey&q=$query&page=$page');
    logger.d(url);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        logger.t('Response: ${response.body}');
        final json = jsonDecode(response.body);
        final images = ImagesData.fromJson(json as Map<String, dynamic>);
        return images;
      } else {
        logger.e('Request failed with status: ${response.statusCode}');
        logger.e('Request failed with status: ${response.body}');
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
