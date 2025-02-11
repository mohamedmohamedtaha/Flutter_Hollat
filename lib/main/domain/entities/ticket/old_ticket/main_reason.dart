import 'package:equatable/equatable.dart';

class MainReason extends Equatable {
  final int active; // 1
  final String? color; // null
  final String createdAt; // 2022-11-19 21:49:54
  final String? deletedAt; // null
  final String? icon; // null
  final int? id; // 5
  final int? requiredOther; // 0
  final String titleAr; // البطاقات الائتمانية
  final String titleEn; // Credit Cards
  final String? updatedAt;

  const MainReason(
  {required this.active,
    required this.createdAt,
    required this.deletedAt,
    required this.color,
    required this.icon,
    required this.id,
    required this.requiredOther,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt}); // 2022-11

  @override
  List<Object?> get props =>
      [
        active,
        color,
        createdAt,
        deletedAt,
        icon,
        id,
        requiredOther,
        titleAr,
        titleEn,
        updatedAt,
      ];

}