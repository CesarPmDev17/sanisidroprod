import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/data/providers/youtube_provider.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideosListaController extends GetxController {
  late VideosListaController _self;

  // Youtube videos
  final _youtubeProvider = YoutubeProvider();

  final CancelToken cancelToken = CancelToken();

  // Ej: _scrollThreshold = 200. Hará llamadas a partir de
  // los 200 pixeles previos a terminar la lista.
  final _scrollThreshold = 200.0;
  final _scrollController = ScrollController();
  final RxDouble _scrollDifference = RxDouble(0.0);
  bool hasReachedMax = false;
  ScrollController get scrollController => this._scrollController;

  int pageSize = 20;
  List<Item> listaVideos = [];

  bool fetchError = false;
  bool fetchFinish = false;
  bool fetchLoading = false;

  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  @override
  void onClose() {
    _scrollController.dispose();
    cancelToken.cancel();
    super.onClose();
  }

  void _init() {
    _scrollController.addListener(_onScroll);

    _fetchData(pageSize);

    debounce<double>(_scrollDifference, (difference) {
      if (difference <= _scrollThreshold) {
        _fetchData(pageSize);
      }
    }, time: Duration(milliseconds: 200));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    this._scrollDifference.value = maxScroll - currentScroll;
  }

  String? nextPageToken;
  void _fetchData(int pageSize) async {
    if (fetchLoading || hasReachedMax) return;

    if (fetchError) {
      fetchError = false;
      fetchFinish = false;
      update();
    }

    try {
      fetchLoading = true;
      if (listaVideos.isEmpty) {
        await Helpers.sleep(600);
      }
      final resp = await _youtubeProvider.videosRecientes(
        pageSize: pageSize,
        pageToken: nextPageToken,
      );
      if (_self.isClosed) return;

      listaVideos = listaVideos + resp.items;
      if (resp.nextPageToken != null) {
        nextPageToken = resp.nextPageToken;
      } else {
        hasReachedMax = true;
      }
    } on ApiException catch (e) {
      fetchError = true;
      errorMessage = e.message;
      Helpers.logger.e(errorMessage);
    } catch (e) {
      fetchError = true;
      errorMessage = 'Parece que hubo un error obteniendo la lista de videos.';
      Helpers.logger.e(errorMessage);
    } finally {
      fetchFinish = true;
      fetchLoading = false;
      update();
    }
  }

  void retryFetch() {
    _fetchData(pageSize);
  }
}
