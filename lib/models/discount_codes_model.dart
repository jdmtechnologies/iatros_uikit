class DiscountCodesModel {
    final String id;
    final String code;
    final int discount;
    final String createdAt;

    DiscountCodesModel({
        required this.id,
        required this.code,
        required this.discount,
        required this.createdAt,
    });

    DiscountCodesModel copyWith({
        String? id,
        String? code,
        int? discount,
        String? createdAt,
    }) => 
        DiscountCodesModel(
            id: id ?? this.id,
            code: code ?? this.code,
            discount: discount ?? this.discount,
            createdAt: createdAt ?? this.createdAt,
        );

    factory DiscountCodesModel.fromJson(Map<String, dynamic> json) => DiscountCodesModel(
        id: json["id"],
        code: json["code"],
        discount: json["discount"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount": discount,
        "created_at": createdAt,
    };
}
