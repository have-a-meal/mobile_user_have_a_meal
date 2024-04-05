class TicketModel {
  String ticketId;
  String ticketTime;
  String ticketCourse;
  String ticketPrice;

  TicketModel({
    required this.ticketId,
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] as String,
      ticketTime: json['ticketTime'] as String,
      ticketCourse: json['ticketCourse'] as String,
      ticketPrice: json['ticketPrice'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketTime': ticketTime,
      'ticketCourse': ticketCourse,
      'ticketPrice': ticketPrice,
    };
  }
}
