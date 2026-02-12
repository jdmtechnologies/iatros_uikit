import 'dart:convert';

class SuscriptionSettingsModel {
    final String? id;
    final int price;
    final String title;
    final String description;
    final double discount;
    final int rangeMonth;
    final bool mostRecommended;
    final DateTime? createdAt;
    final DateTime? updateAt;

    SuscriptionSettingsModel({
        this.id,
        required this.price,
        required this.title,
        required this.description,
        required this.discount,
        required this.rangeMonth,
        this.mostRecommended = false,
        this.createdAt,
        this.updateAt,
    });

    SuscriptionSettingsModel copyWith({
        String? id,
        int? price,
        String? title,
        String? description,
        double? discount,
        int? rangeMonth,
        bool? mostRecommended,
        DateTime? createdAt,
        DateTime? updateAt,
    }) =>
        SuscriptionSettingsModel(
            id: id ?? this.id,
            price: price ?? this.price,
            title: title ?? this.title,
            description: description ?? this.description,
            discount: discount ?? this.discount,
            rangeMonth: rangeMonth ?? this.rangeMonth,
            mostRecommended: mostRecommended ?? this.mostRecommended,
            createdAt: createdAt ?? this.createdAt,
            updateAt: updateAt ?? this.updateAt,
        );

    factory SuscriptionSettingsModel.fromRawJson(String str) =>
        SuscriptionSettingsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    static DateTime? _parseDateTime(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    /// Acepta id como String, int (serial de Supabase) o null.
    static String? _parseId(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      if (value is int) return value.toString();
      return null;
    }

    factory SuscriptionSettingsModel.fromJson(Map<String, dynamic> json) =>
        SuscriptionSettingsModel(
          id: _parseId(json["id"]),
          price: (json["price"] as num).toInt(),
          title: json["title"] as String,
          description: json["description"] as String,
          discount: (json["discount"] as num).toDouble(),
          rangeMonth: (json["range_month"] as num).toInt(),
          mostRecommended: json["most_recommended"] == true ||
              json["most_recommended"] == 1,
          createdAt: _parseDateTime(json["created_at"]),
          updateAt: _parseDateTime(json["update_at"]),
        );

    Map<String, dynamic> toJson() {
      final map = <String, dynamic>{
        "price": price,
        "title": title,
        "discount": discount,
        "range_month": rangeMonth,
        "description": description,
        "most_recommended": mostRecommended,
      };
      if (id != null && id!.isNotEmpty) map["id"] = id;
      if (updateAt != null) map["update_at"] = updateAt!.toIso8601String();
      if (createdAt != null) map["created_at"] = createdAt!.toIso8601String();
      return map;
    }
}
