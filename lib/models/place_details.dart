class PlaceDetails {
  final String placeId;
  final String formattedAddress;
  final double? latitude;
  final double? longitude;

  PlaceDetails({
    required this.placeId,
    required this.formattedAddress,
    this.latitude,
    this.longitude,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'] ?? {};
    final location = geometry['location'] ?? {};
    
    return PlaceDetails(
      placeId: json['place_id'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      latitude: location['lat']?.toDouble(),
      longitude: location['lng']?.toDouble(),
    );
  }
}

