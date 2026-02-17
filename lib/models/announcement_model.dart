import 'dart:convert';

class AnnouncementModel {
    final int title;
    final String id;
    final DateTime dateEnd;
    final String description;

    AnnouncementModel({
        required this.id,
        required this.title,
        required this.dateEnd,
        required this.description,
    });

    AnnouncementModel copyWith({
        int? title,
        String? id,
        DateTime? dateEnd,
        String? description,
    }) => 
        AnnouncementModel(
            id: id ?? this.id,
            title: title ?? this.title,
            dateEnd: dateEnd ?? this.dateEnd,
            description: description ?? this.description,
        );

    factory AnnouncementModel.fromRawJson(String str) => AnnouncementModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AnnouncementModel.fromJson(Map<String, dynamic> json) => AnnouncementModel(
        id: json["id"],
        title: json["title"],
        dateEnd: DateTime.parse(json["date_end"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_end": dateEnd.toIso8601String(),
    };
}
