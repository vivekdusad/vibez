// @dart=2.12
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Images {
  int page;
  int perPage;
  List<Photos> photos;
  int totalResults;
  String nextPage;
  Images({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  Images copyWith({
    int? page,
    int? perPage,
    List<Photos>? photos,
    int? totalResults,
    String? nextPage,
  }) {
    return Images(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      photos: photos ?? this.photos,
      totalResults: totalResults ?? this.totalResults,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'perPage': perPage,
      'photos': photos.map((x) => x.toMap()).toList(),
      'total_Results': totalResults,
      'nextPage': nextPage,
    };
  }

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      page: map['page'],
      perPage: map['per_page'],
      photos: List<Photos>.from(map['photos']?.map((x) => Photos.fromMap(x))),
      totalResults: map['total_results'],
      nextPage: map['next_page'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Images.fromJson(String source) => Images.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Images(page: $page, perPage: $perPage, photos: $photos, totalResults: $totalResults, nextPage: $nextPage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Images &&
      other.page == page &&
      other.perPage == perPage &&
      listEquals(other.photos, photos) &&
      other.totalResults == totalResults &&
      other.nextPage == nextPage;
  }

  @override
  int get hashCode {
    return page.hashCode ^
      perPage.hashCode ^
      photos.hashCode ^
      totalResults.hashCode ^
      nextPage.hashCode;
  }
}

class Photos {
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  String avgColor;
  Src src;
  bool liked;
  Photos({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
  });

  Photos copyWith({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
  }) {
    return Photos(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
      photographer: photographer ?? this.photographer,
      photographerUrl: photographerUrl ?? this.photographerUrl,
      photographerId: photographerId ?? this.photographerId,
      avgColor: avgColor ?? this.avgColor,
      src: src ?? this.src,
      liked: liked ?? this.liked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'width': width,
      'height': height,
      'url': url,
      'photographer': photographer,
      'photographerUrl': photographerUrl,
      'photographerId': photographerId,
      'avgColor': avgColor,
      'src': src.toMap(),
      'liked': liked,
    };
  }

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'],
      width: map['width'],
      height: map['height'],
      url: map['url'],
      photographer: map['photographer'],
      photographerUrl: map['photographer_url'],
      photographerId: map['photographer_id'],
      avgColor: map['avg_color'],
      src: Src.fromMap(map['src']),
      liked: map['liked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Photos.fromJson(String source) => Photos.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Photos(id: $id, width: $width, height: $height, url: $url, photographer: $photographer, photographerUrl: $photographerUrl, photographerId: $photographerId, avgColor: $avgColor, src: $src, liked: $liked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Photos &&
        other.id == id &&
        other.width == width &&
        other.height == height &&
        other.url == url &&
        other.photographer == photographer &&
        other.photographerUrl == photographerUrl &&
        other.photographerId == photographerId &&
        other.avgColor == avgColor &&
        other.src == src &&
        other.liked == liked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        width.hashCode ^
        height.hashCode ^
        url.hashCode ^
        photographer.hashCode ^
        photographerUrl.hashCode ^
        photographerId.hashCode ^
        avgColor.hashCode ^
        src.hashCode ^
        liked.hashCode;
  }
}

class Src {
  String original;
  String large2x;
  String large;
  String medium;
  String small;
  String portrait;
  String landscape;
  String tiny;
  Src({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  Src copyWith({
    String? original,
    String? large2x,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) {
    return Src(
      original: original ?? this.original,
      large2x: large2x ?? this.large2x,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
      portrait: portrait ?? this.portrait,
      landscape: landscape ?? this.landscape,
      tiny: tiny ?? this.tiny,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'original': original,
      'large2x': large2x,
      'large': large,
      'medium': medium,
      'small': small,
      'portrait': portrait,
      'landscape': landscape,
      'tiny': tiny,
    };
  }

  factory Src.fromMap(Map<String, dynamic> map) {
    return Src(
      original: map['original'],
      large2x: map['large2x'],
      large: map['large'],
      medium: map['medium'],
      small: map['small'],
      portrait: map['portrait'],
      landscape: map['landscape'],
      tiny: map['tiny'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Src.fromJson(String source) => Src.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Src(original: $original, large2x: $large2x, large: $large, medium: $medium, small: $small, portrait: $portrait, landscape: $landscape, tiny: $tiny)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Src &&
        other.original == original &&
        other.large2x == large2x &&
        other.large == large &&
        other.medium == medium &&
        other.small == small &&
        other.portrait == portrait &&
        other.landscape == landscape &&
        other.tiny == tiny;
  }

  @override
  int get hashCode {
    return original.hashCode ^
        large2x.hashCode ^
        large.hashCode ^
        medium.hashCode ^
        small.hashCode ^
        portrait.hashCode ^
        landscape.hashCode ^
        tiny.hashCode;
  }
}
