class AddressLocationModel {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;
  final double? lat;
  final double? lng;

  AddressLocationModel({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
    this.lat,
    this.lng,
  });

  factory AddressLocationModel.fromJson(Map<String, dynamic> json) {
    final structuredFormatting = json['structured_formatting'] ?? {};
    return AddressLocationModel(
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
      mainText: structuredFormatting['main_text'] ?? '',
      secondaryText: structuredFormatting['secondary_text'] ?? '',
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : null,
      lng: json['lng'] != null ? double.tryParse(json['lng'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'description': description,
      'main_text': mainText,
      'secondary_text': secondaryText,
      'lat': lat,
      'lng': lng,
    };
  }
}