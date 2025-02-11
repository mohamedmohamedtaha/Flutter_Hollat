import 'package:equatable/equatable.dart';

class File extends Equatable {
  final int addedByCustomer; // 1
  final String createdAt; // 2023-10-29 11:26:08
  final String? creatorId; // null
  final String? deletedAt; // null
  final String fileName; // /storage/tickets_files/1698567968-WhatsApp Image 2023-10-29 at 11.22.10 AM.pdf
  final int id; // 312371
  final int ticketId; // 688414
  final String? updatedAt;

  const File({required this.addedByCustomer, required this.createdAt, required this.creatorId,required  this.deletedAt,
    required this.fileName, required this.id, required this.ticketId,required this.updatedAt}); //


  @override
  List<Object?> get props =>
      [
        addedByCustomer,
        createdAt,
        creatorId,
        deletedAt,
        fileName,
        id,
        ticketId,
        updatedAt,
      ];
}