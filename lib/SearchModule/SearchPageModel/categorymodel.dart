// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  int total;
  int totalPages;
  List<Result> results;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        total: json["total"],
        totalPages: json["total_pages"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    required this.user,
    required this.tags,
  });

  String id;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  Urls urls;
  ResultLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions topicSubmissions;
  User user;
  List<Tag> tags;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        description: json["description"] == null ? null : json["description"],
        altDescription: json["alt_description"],
        urls: Urls.fromJson(json["urls"]),
        links: ResultLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections:
            List<dynamic>.from(json["current_user_collections"].map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: TopicSubmissions.fromJson(json["topic_submissions"]),
        user: User.fromJson(json["user"]),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "promoted_at":
            promotedAt == null ? null : promotedAt!.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "description": description == null ? null : description,
        "alt_description": altDescription,
        "urls": urls.toJson(),
        "links": links.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections":
            List<dynamic>.from(currentUserCollections.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions.toJson(),
        "user": user.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class ResultLinks {
  ResultLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory ResultLinks.fromJson(Map<String, dynamic> json) => ResultLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Tag {
  Tag({
    required this.type,
    required this.title,
    required this.source,
  });
  Type? type;
  TagTitle? title;
  Source? source;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        type: typeValues.map[json["type"]],
        title: tagTitleValues.map[json["title"]],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "title": tagTitleValues.reverse[title],
        "source": source == null ? null : source!.toJson(),
      };
}

class Source {
  Source({
    required this.ancestry,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.coverPhoto,
  });

  Ancestry ancestry;
  SourceTitle? title;
  Subtitle? subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  CoverPhoto coverPhoto;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        ancestry: Ancestry.fromJson(json["ancestry"]),
        title: sourceTitleValues.map[json["title"]],
        subtitle: subtitleValues.map[json["subtitle"]],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
      );

  Map<String, dynamic> toJson() => {
        "ancestry": ancestry.toJson(),
        "title": sourceTitleValues.reverse[title],
        "subtitle": subtitleValues.reverse[subtitle],
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "cover_photo": coverPhoto.toJson(),
      };
}

class Ancestry {
  Ancestry({
    required this.type,
    required this.category,
    required this.subcategory,
  });

  Category type;
  Category category;
  Category? subcategory;

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
        type: Category.fromJson(json["type"]),
        category: Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Category.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type.toJson(),
        "category": category.toJson(),
        "subcategory": subcategory == null ? null : subcategory!.toJson(),
      };
}

class Category {
  Category({
    required this.slug,
    required this.prettySlug,
  });

  Slug? slug;
  PrettySlug? prettySlug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        slug: slugValues.map[json["slug"]],
        prettySlug: prettySlugValues.map[json["pretty_slug"]],
      );

  Map<String, dynamic> toJson() => {
        "slug": slugValues.reverse[slug],
        "pretty_slug": prettySlugValues.reverse[prettySlug],
      };
}

enum PrettySlug { ANIMALS, DOG, IMAGES }

final prettySlugValues = EnumValues({
  "Animals": PrettySlug.ANIMALS,
  "Dog": PrettySlug.DOG,
  "Images": PrettySlug.IMAGES
});

enum Slug { ANIMALS, DOG, IMAGES }

final slugValues = EnumValues(
    {"animals": Slug.ANIMALS, "dog": Slug.DOG, "images": Slug.IMAGES});

class CoverPhoto {
  CoverPhoto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    required this.premium,
    required this.user,
  });
  Id? id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  Color? color;
  BlurHash? blurHash;
  String description;
  AltDescription? altDescription;
  Urls urls;
  ResultLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions topicSubmissions;
  bool premium;
  User user;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
        id: idValues.map[json["id"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promotedAt: DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: colorValues.map[json["color"]],
        blurHash: blurHashValues.map[json["blur_hash"]],
        description: json["description"],
        altDescription: altDescriptionValues.map[json["alt_description"]],
        urls: Urls.fromJson(json["urls"]),
        links: ResultLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections:
            List<dynamic>.from(json["current_user_collections"].map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: TopicSubmissions.fromJson(json["topic_submissions"]),
        premium: json["premium"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promoted_at": promotedAt.toIso8601String(),
        "width": width,
        "height": height,
        "color": colorValues.reverse[color],
        "blur_hash": blurHashValues.reverse[blurHash],
        "description": description,
        "alt_description": altDescriptionValues.reverse[altDescription],
        "urls": urls.toJson(),
        "links": links.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections":
            List<dynamic>.from(currentUserCollections.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions.toJson(),
        "premium": premium,
        "user": user.toJson(),
      };
}

enum AltDescription {
  SHORT_COATED_BROWN_DOG,
  SELECTIVE_FOCUS_PHOTOGRAPHY_OF_GIRAFFE
}

final altDescriptionValues = EnumValues({
  "selective focus photography of giraffe":
      AltDescription.SELECTIVE_FOCUS_PHOTOGRAPHY_OF_GIRAFFE,
  "short-coated brown dog": AltDescription.SHORT_COATED_BROWN_DOG
});

enum BlurHash {
  LQ_DC_H_SM_X9_NH_NNG_LF_QX_RK_PJ,
  LPR_0_EXT_P_IU_MRQM_M_LOZ_IBM
}

final blurHashValues = EnumValues({
  "LPR{0ext~pIU%MRQM{%M%LozIBM|": BlurHash.LPR_0_EXT_P_IU_MRQM_M_LOZ_IBM,
  "LQDcH.smX9NH_NNG%LfQx^Rk-pj@": BlurHash.LQ_DC_H_SM_X9_NH_NNG_LF_QX_RK_PJ
});

enum Color { THE_262626, F3_F3_C0 }

final colorValues =
    EnumValues({"#f3f3c0": Color.F3_F3_C0, "#262626": Color.THE_262626});

enum Id { T_GBR_QW52_THW, YOZ_NE_HM8_MA_A }

final idValues = EnumValues(
    {"tGBRQw52Thw": Id.T_GBR_QW52_THW, "YozNeHM8MaA": Id.YOZ_NE_HM8_MA_A});

class TopicSubmissions {
  TopicSubmissions({
    @required this.animals,
  });

  Animals? animals;

  factory TopicSubmissions.fromJson(Map<String, dynamic> json) =>
      TopicSubmissions(
        animals:
            json["animals"] == null ? null : Animals.fromJson(json["animals"]),
      );

  Map<String, dynamic> toJson() => {
        "animals": animals == null ? null : animals!.toJson(),
      };
}

class Animals {
  Animals({
    required this.status,
    required this.approvedOn,
  });

  String status;
  DateTime? approvedOn;

  factory Animals.fromJson(Map<String, dynamic> json) => Animals(
        status: json["status"],
        approvedOn: json["approved_on"] == null
            ? null
            : DateTime.parse(json["approved_on"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "approved_on":
            approvedOn == null ? null : approvedOn!.toIso8601String(),
      };
}

class Urls {
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}

class User {
  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.profileImage,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  UserLinks links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;
  bool forHire;
  Social social;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        twitterUsername:
            json["twitter_username"] == null ? null : json["twitter_username"],
        portfolioUrl:
            json["portfolio_url"] == null ? null : json["portfolio_url"],
        bio: json["bio"] == null ? null : json["bio"],
        location: json["location"] == null ? null : json["location"],
        links: UserLinks.fromJson(json["links"]),
        profileImage: ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"] == null
            ? null
            : json["instagram_username"],
        totalCollections: json["total_collections"],
        totalLikes: json["total_likes"],
        totalPhotos: json["total_photos"],
        acceptedTos: json["accepted_tos"],
        forHire: json["for_hire"],
        social: Social.fromJson(json["social"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName == null ? null : lastName,
        "twitter_username": twitterUsername == null ? null : twitterUsername,
        "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
        "bio": bio == null ? null : bio,
        "location": location == null ? null : location,
        "links": links.toJson(),
        "profile_image": profileImage.toJson(),
        "instagram_username":
            instagramUsername == null ? null : instagramUsername,
        "total_collections": totalCollections,
        "total_likes": totalLikes,
        "total_photos": totalPhotos,
        "accepted_tos": acceptedTos,
        "for_hire": forHire,
        "social": social.toJson(),
      };
}

class UserLinks {
  UserLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.following,
    required this.followers,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        likes: json["likes"],
        portfolio: json["portfolio"],
        following: json["following"],
        followers: json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "likes": likes,
        "portfolio": portfolio,
        "following": following,
        "followers": followers,
      };
}

class ProfileImage {
  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class Social {
  Social({
    required this.instagramUsername,
    required this.portfolioUrl,
    required this.twitterUsername,
    required this.paypalEmail,
  });

  String instagramUsername;
  String portfolioUrl;
  String twitterUsername;
  dynamic paypalEmail;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        instagramUsername: json["instagram_username"] == null
            ? null
            : json["instagram_username"],
        portfolioUrl:
            json["portfolio_url"] == null ? null : json["portfolio_url"],
        twitterUsername:
            json["twitter_username"] == null ? null : json["twitter_username"],
        paypalEmail: json["paypal_email"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_username":
            instagramUsername == null ? null : instagramUsername,
        "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
        "twitter_username": twitterUsername == null ? null : twitterUsername,
        "paypal_email": paypalEmail,
      };
}

enum Subtitle { DOWNLOAD_FREE_DOG_IMAGES, DOWNLOAD_FREE_ANIMALS_IMAGES }

final subtitleValues = EnumValues({
  "Download free animals images": Subtitle.DOWNLOAD_FREE_ANIMALS_IMAGES,
  "Download free dog images": Subtitle.DOWNLOAD_FREE_DOG_IMAGES
});

enum SourceTitle { DOG_IMAGES_PICTURES, ANIMALS_IMAGES_PICTURES }

final sourceTitleValues = EnumValues({
  "Animals images & pictures": SourceTitle.ANIMALS_IMAGES_PICTURES,
  "Dog images & pictures": SourceTitle.DOG_IMAGES_PICTURES
});

enum TagTitle { DOG, ANIMAL, AUSTIN }

final tagTitleValues = EnumValues({
  "animal": TagTitle.ANIMAL,
  "austin": TagTitle.AUSTIN,
  "dog": TagTitle.DOG
});

enum Type { LANDING_PAGE, SEARCH }

final typeValues =
    EnumValues({"landing_page": Type.LANDING_PAGE, "search": Type.SEARCH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
