import 'package:equatable/equatable.dart';
import 'package:hollat/main/domain/entities/ticket/old_ticket/data_ticket.dart';

class Tickets extends Equatable {
  final List<DataTicket> data;

  const Tickets({required this.data});

  @override
  List<Object> get props => [data];
}