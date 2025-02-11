
import 'package:hollat/main/domain/entities/ticket/old_ticket/file.dart';

class FileModel extends File{
 const FileModel({required super.addedByCustomer, required super.createdAt, required super.creatorId,
   required super.deletedAt, required super.fileName, required super.id, required super.ticketId, required super.updatedAt});

  factory FileModel.fromJson(Map<String,dynamic>json)=>
      FileModel(addedByCustomer: json['added_by_customer'] as int,createdAt: json['created_at'] as String,
        creatorId:json['creator_id'] as String?,deletedAt: json['deleted_at'] as String?,fileName: json['file_name'] as String,
          id: json['id'] as int,ticketId: json['ticket_id'] as int,updatedAt: json['updated_at'] as String?
      );
}