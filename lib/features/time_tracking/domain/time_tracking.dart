class TimeTracking {
  final String id;
  final String employeeId;
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;

  TimeTracking({
    required this.id,
    required this.employeeId,
    required this.date,
    this.checkIn,
    this.checkOut,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'employeeId': employeeId,
    'date': date.toIso8601String(),
    'checkIn': checkIn?.toIso8601String(),
    'checkOut': checkOut?.toIso8601String(),
  };

  factory TimeTracking.fromJson(Map<String, dynamic> json) => TimeTracking(
    id: json['id'],
    employeeId: json['employeeId'],
    date: DateTime.parse(json['date']),
    checkIn: json['checkIn'] != null ? DateTime.parse(json['checkIn']) : null,
    checkOut: json['checkOut'] != null ? DateTime.parse(json['checkOut']) : null,
  );
}
