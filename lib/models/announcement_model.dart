import 'dart:convert';

class AnnouncementModel {
    final String id;
    final String title;
    final DateTime dateEnd;
    final String description;

    AnnouncementModel({
        required this.id,
        required this.title,
        required this.dateEnd,
        required this.description,
    });

    AnnouncementModel copyWith({
        String? id,
        String? title,
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
        description: json["description"],
        dateEnd: DateTime.parse(json["date_end"]),
    );

    factory AnnouncementModel.init() => AnnouncementModel(
        id: "",
        title: "",
        description: "",
        dateEnd: DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_end": dateEnd.toIso8601String(),
    };
}
