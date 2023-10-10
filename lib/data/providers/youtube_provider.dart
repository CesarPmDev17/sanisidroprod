import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/instance_binding.dart';
import 'package:get/instance_manager.dart';

class YoutubeProvider {
  final DioClientYoutube _dioYoutube = Get.find<DioClientYoutube>();
  final String apiKey = Config().youtuApiKey;

  Future<YoutubeSearchResponse> videosRecientes({
    String? pageToken,
    required int pageSize,
  }) async {
    final resp = await _dioYoutube.get('/playlistItems', queryParameters: {
      'key': apiKey,
      'part': 'snippet',
      // Upload playlist ID de San Isidro
      'playlistId': 'UUn2gaVv77AER_KNaJGZ28RQ',
      'maxResults': pageSize,
      'pageToken': pageToken ?? '',
    });
    return YoutubeSearchResponse.fromJson(resp);
  }
}
