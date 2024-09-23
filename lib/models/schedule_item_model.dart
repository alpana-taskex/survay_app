class ScheduleItemModel {
  final String jobId;
  final String customerName;
  final String location;
  final DateTime date;
  final String timeRange;
  final String items;
  final String? men;

  ScheduleItemModel({
    required this.jobId,
    required this.customerName,
    required this.location,
    required this.date,
    required this.timeRange,
    required this.items,
    this.men,
  });

  // Convert a ScheduleItemModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'customerName': customerName,  // Fixed typo
      'location': location,
      'date': date.toIso8601String(),
      'timeRange': timeRange,
      'items': items,
      'men': men,  // Will be null if not set
    };
  }

  // Create a ScheduleItemModel instance from a JSON map
  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    return ScheduleItemModel(
      jobId: json['jobId'],
      customerName: json['customerName'],  // Fixed typo
      location: json['location'],
      date: DateTime.parse(json['date']),
      timeRange: json['timeRange'],
      items: json['items'],
      men: json['men'],  // Can be null
    );
  }
}