import 'dart:convert';

List<NewsEntry> newsEntryListFromJson(String str) =>
    List<NewsEntry>.from(json.decode(str).map((x) => NewsEntry.fromJson(x)));

String newsEntryListToJson(List<NewsEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsEntry {
  const NewsEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.thumbnail,
    required this.newsViews,
    required this.isFeatured,
    this.createdAt,
    this.userId,
  });

  final String id;
  final String title;
  final String content;
  final String category;
  final String thumbnail;
  final int newsViews;
  final bool isFeatured;
  final DateTime? createdAt;
  final int? userId;

  factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    content: json["content"] ?? "",
    category: json["category"] ?? "update",
    thumbnail: json["thumbnail"] ?? "",
    newsViews: json["news_views"] ?? 0,
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    isFeatured: json["is_featured"] ?? false,
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "category": category,
    "thumbnail": thumbnail,
    "news_views": newsViews,
    "created_at": createdAt?.toIso8601String(),
    "is_featured": isFeatured,
    "user_id": userId,
  };
}
