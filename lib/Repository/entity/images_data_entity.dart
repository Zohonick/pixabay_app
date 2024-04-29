import 'package:json_annotation/json_annotation.dart';

part 'images_data_entity.g.dart';

@JsonSerializable()
class ImagesData {
  int? total;
  int? totalHits;
  List<Hits>? hits;

  ImagesData({this.total, this.totalHits, this.hits});

  factory ImagesData.fromJson(Map<String, dynamic> json) =>
      _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class Hits {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
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
  String? userImageURL;

  Hits(
      {this.id,
      this.pageURL,
      this.type,
      this.tags,
      this.previewURL,
      this.previewWidth,
      this.previewHeight,
      this.webformatURL,
      this.webformatWidth,
      this.webformatHeight,
      this.largeImageURL,
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
      this.userImageURL});

  factory Hits.fromJson(Map<String, dynamic> json) => _$HitsFromJson(json);

  Map<String, dynamic> toJson() => _$HitsToJson(this);
}
