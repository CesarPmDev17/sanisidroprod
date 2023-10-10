// To parse this JSON data, do
//
//     final youtubeSearchResponse = youtubeSearchResponseFromJson(jsonString);

import 'dart:convert';

YoutubeSearchResponse youtubeSearchResponseFromJson(String str) =>
    YoutubeSearchResponse.fromJson(json.decode(str));

String youtubeSearchResponseToJson(YoutubeSearchResponse data) =>
    json.encode(data.toJson());

class YoutubeSearchResponse {
  YoutubeSearchResponse({
    required this.kind,
    required this.etag,
    this.nextPageToken,
    this.prevPageToken,
    required this.items,
    required this.pageInfo,
  });

  final String kind;
  final String etag;
  final String? nextPageToken;
  final String? prevPageToken;
  final List<Item> items;
  final PageInfo pageInfo;

  factory YoutubeSearchResponse.fromJson(Map<String, dynamic> json) =>
      YoutubeSearchResponse(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        prevPageToken: json["prevPageToken"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "prevPageToken": prevPageToken,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };
}

class Item {
  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  final String kind;
  final String etag;
  final String id;
  final Snippet snippet;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
      };
}

class Snippet {
  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.playlistId,
    required this.position,
    required this.resourceId,
    required this.videoOwnerChannelTitle,
    required this.videoOwnerChannelId,
  });

  final DateTime publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final String channelTitle;
  final String playlistId;
  final int position;
  final ResourceId resourceId;
  final String videoOwnerChannelTitle;
  final String videoOwnerChannelId;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        playlistId: json["playlistId"],
        position: json["position"],
        resourceId: ResourceId.fromJson(json["resourceId"]),
        videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
        videoOwnerChannelId: json["videoOwnerChannelId"],
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "playlistId": playlistId,
        "position": position,
        "resourceId": resourceId.toJson(),
        "videoOwnerChannelTitle": videoOwnerChannelTitle,
        "videoOwnerChannelId": videoOwnerChannelId,
      };
}

class ResourceId {
  ResourceId({
    required this.kind,
    required this.videoId,
  });

  final String kind;
  final String videoId;

  factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
        kind: json["kind"],
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "videoId": videoId,
      };
}

class Thumbnails {
  Thumbnails({
    required this.tDefault,
    required this.tMedium,
    required this.tHigh,
  });

  final ThumbnailSize tDefault;
  final ThumbnailSize tMedium;
  final ThumbnailSize tHigh;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        tDefault: ThumbnailSize.fromJson(json["default"]),
        tMedium: ThumbnailSize.fromJson(json["medium"]),
        tHigh: ThumbnailSize.fromJson(json["high"]),
      );

  Map<String, dynamic> toJson() => {
        "default": tDefault.toJson(),
        "medium": tMedium.toJson(),
        "high": tHigh.toJson(),
      };
}

class ThumbnailSize {
  ThumbnailSize({
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final int width;
  final int height;

  factory ThumbnailSize.fromJson(Map<String, dynamic> json) => ThumbnailSize(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class PageInfo {
  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  final int totalResults;
  final int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
      };
}
