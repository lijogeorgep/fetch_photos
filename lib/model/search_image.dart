// To parse this JSON data, do
//
//     final searchImage = searchImageFromJson(jsonString);

import 'dart:convert';

SearchImage searchImageFromJson(String str) =>
    SearchImage.fromJson(json.decode(str));

String searchImageToJson(SearchImage data) => json.encode(data.toJson());

class SearchImage {
  SearchImage({
    this.total,
    this.totalHits,
    this.hits,
  });

  int? total;
  int? totalHits;
  List<Hit>? hits;

  factory SearchImage.fromJson(Map<String, dynamic> json) => SearchImage(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<dynamic>.from(hits!.map((x) => x.toJson())),
      };
}

class Hit {
  Hit({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.webformatUrl,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  int? id;
  String? pageUrl;
  Type? type;
  String? tags;
  String? previewUrl;
  int? previewWidth;
  int? previewHeight;
  String? webformatUrl;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageUrl;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageUrl;

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: typeValues.map[json["type"]],
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": typeValues.reverse[type],
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
      };
}

enum Type { PHOTO }

final typeValues = EnumValues({"photo": Type.PHOTO});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
