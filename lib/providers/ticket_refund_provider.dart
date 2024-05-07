import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';

class TicketRefundProvider extends ChangeNotifier {
  Map<String, Map<String, List<TicketModel>>> _ticketMap = {
    "조식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "중식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "석식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
  };

  Map<String, Map<String, List<TicketModel>>> get ticketMap => _ticketMap;

  List<TicketModel> getTicketList(String ticketTime, String ticketCourse) {
    return _ticketMap[ticketTime]![ticketCourse]!;
  }

  Future<void> resetTicket() async {
    _ticketMap = {
      "조식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "중식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "석식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
    };
    notifyListeners();
  }

  Future<void> addTicket(List<TicketModel> ticketList) async {
    for (TicketModel ticketModel in ticketList) {
      _ticketMap[ticketModel.ticketTime]![ticketModel.ticketCourse]!
          .add(ticketModel);
    }

    notifyListeners();
    // return true;
  }

  Future<void> removeTicket(Set<TicketModel> ticketList) async {
    for (TicketModel ticketModel in ticketList) {
      _ticketMap[ticketModel.ticketTime]![ticketModel.ticketCourse]!
          .remove(ticketModel);
    }
    notifyListeners();
    // return true;
  }
}
