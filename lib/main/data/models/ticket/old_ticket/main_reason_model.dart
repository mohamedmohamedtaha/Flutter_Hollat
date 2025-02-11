import 'package:hollat/main/domain/entities/ticket/old_ticket/main_reason.dart';

class MainReasonModel extends MainReason{
 const MainReasonModel({required super.active, required super.createdAt, required super.deletedAt, required super.color,
   required super.icon, required super.id, required super.requiredOther, required super.titleAr, required super.titleEn,
   required super.updatedAt});
 factory MainReasonModel.fromJson(Map<String,dynamic>json)=>
     MainReasonModel(active: json['active']as int,color:  json['color'] as String?, createdAt: json['created_at'] as String,
     deletedAt: json['deleted_at']as String?, icon: json['icon'] as String?, id: json['id']as int,
     requiredOther: json['required_other'] as int, titleAr: json['title_ar']as String, titleEn: json['title_en']as String,
     updatedAt: json['updated_at']as String);

}