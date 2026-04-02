class TotalMeetingMapModel {
  final int id;
  final String title;
  final String placeText;
  final double placeLat;
  final double placeLng;

  TotalMeetingMapModel({
    required this.id,
    required this.title,
    required this.placeText,
    required this.placeLat,
    required this.placeLng,
  });

  factory TotalMeetingMapModel.fromJson(Map<String, dynamic> json) {
    return TotalMeetingMapModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] as String,
      placeText: json['placeText'] as String,
      placeLat: double.parse(json['placeLat'].toString()),
      placeLng: double.parse(json['placeLng'].toString()),
    );
  }
}
