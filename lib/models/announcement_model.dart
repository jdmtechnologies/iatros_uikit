import 'dart:convert';

class AnnouncementModel {
    final String id;
    final String title;
    final DateTime dateEnd;
    final String description;
    final List<String> useresExcluded;

    AnnouncementModel({
        required this.id,
        required this.title,
        required this.dateEnd,
        required this.description,
        required this.useresExcluded,
    });

    AnnouncementModel copyWith({
        String? id,
        String? title,
        DateTime? dateEnd,
        String? description,
        List<String>? useresExcluded,
    }) => 
        AnnouncementModel(
            id: id ?? this.id,
            title: title ?? this.title,
            dateEnd: dateEnd ?? this.dateEnd,
            description: description ?? this.description,
            useresExcluded: useresExcluded ?? this.useresExcluded,
        );

    factory AnnouncementModel.fromRawJson(String str) => AnnouncementModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AnnouncementModel.fromJson(Map<String, dynamic> json) => AnnouncementModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateEnd: DateTime.parse(json["date_end"]),
        useresExcluded: List<String>.from(json["useres_excluded"].map((x) => x)),
    );

    factory AnnouncementModel.init() => AnnouncementModel(
        id: "",
        title: "",
        description: "",
        dateEnd: DateTime.now(),
        useresExcluded: [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_end": dateEnd.toIso8601String(),
        "useres_excluded": useresExcluded.map((e) => e).toList(),
    };
}
