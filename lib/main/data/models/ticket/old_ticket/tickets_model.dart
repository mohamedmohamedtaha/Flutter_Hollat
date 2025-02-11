import 'package:hollat/main/data/models/ticket/old_ticket/data_ticket_model.dart';
import 'package:hollat/main/domain/entities/ticket/old_ticket/tickets.dart';

class TicketsModel extends Tickets {
  const TicketsModel({required super.data});

  factory TicketsModel.fromJon(Map<String, dynamic> json) => TicketsModel(
      data: (json['data'] as List<dynamic>)
          .map((dataJson) => DataTicketModel.fromJson(dataJson))
          .toList());
}
