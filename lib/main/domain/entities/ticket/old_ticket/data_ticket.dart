import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:hollat/main/domain/entities/ticket/old_ticket/file.dart';
import 'package:hollat/main/domain/entities/ticket/old_ticket/main_reason.dart';

class DataTicket extends Equatable {
  final int? addedByClient; // 1
  final String? address; // null
  final int? alreadyEscalated; // 0l
  final String? createdAt; // 2023-10-29 11:26:06
  final String? details; // تم محاولة اختراق للبطاقة الائتمانية الخاصة بي لدا بنك الراجحي ولله الحمد كانت فارغة ولا يوجد بها المبلغ المراد سحبه وتم التواصل مع البنك لغلق البطاقة ولكن فوجئت ان البنك قد قام  بتعطيل بطاقة مدى وليس البطاقة الائتمانية وتوجيهي الى اصدار بدل بطاقة اخرى وتم خصم حوالي 34 ريال وقمت بتقديم شكوى للبنك يوم الخميس الموافق 26-10-2023  ولكن البنك لم يتواصل معي الى الان علماً بأن البطاقة الائتمانية مازالت تعمل ولم يتم ايقافها ومعرض للأحتيال مره اخرى.
  final List<File>? files;
  final Long? id; // 688414
  final String? lastAssignedUserAt; // 2023-10-29 11:37:39
  final String? lastStatusUpdatedAt; // 2023-11-01 16:15:18
  final String? latitude; // null
  final String? locationUrl; // null
  final String? longitude; // null
  final MainReason? mainReason;
  final int? mainReasonId; // 1
  final String? mustRespondedBefore; // 2023-11-03 11:26:06
  final int? priorityId; // 3
  final int? requesterId; // 415270
  final String? resolvedAt; // 2023-11-01 15:52:34
  final int? responsibleOrganizationId; // 9
  final String? sectorReply; // عزيزنا العميل. إشارة إلى الشكوى المقدمة من قبلكم والمتضمنة اعتراضكم على رسوم بطاقة صراف نود الافادة انه بالرجوع الى النظام والتحقق نفيدكم انه تم اعادة الرسوم الى الحساب الجاري ومرفق لكم ذلك للتأكد  كما نفيدكم انه تم اشعاركم بالنتائج اعلاه وشكراً .
  final String? sequenceNumber; // 688414
  final int? slaId; // 5
  final int? slaStatusId; // 3
  final String? solution; // null
  final int? solvedBy; // 2200
  final int? sourceId; // 4
  final int? statusId; // 4
  final MainReason? subReason;

  final int? subReasonId; // 5
  final String? subReasonOther; // null
  final int? subSubReasonId; // 26
  final String? subSubSubReasonId; // null
  final String? ticketCreatedAt; // null
  final int? ticketNumber; // 688414
  final String? ticketReferenceNumber; // null
  final int? ticketTypeId; // 1
  final String? updatedAt; // 2023-11-02 03:05:12
  final int? userId; // 1
  final int? workflowStatusId;

 const DataTicket({
   required this.addedByClient,
   required this.address,
   required this.alreadyEscalated,
   required this.createdAt,
   required this.details,
   required this.files,
   required this.id,
   required this.lastAssignedUserAt,
   required this.lastStatusUpdatedAt,
   required this.latitude,
   required this.locationUrl,
   required this.longitude,
   required this.mainReason,
   required this.mainReasonId,
   required this.mustRespondedBefore,
   required this.priorityId,
   required this.requesterId,
   required this.resolvedAt,
   required this.responsibleOrganizationId,
   required this.sectorReply,
   required this.sequenceNumber,
   required this.slaId,
   required this.slaStatusId,
   required this.solution,
   required this.solvedBy,
   required this.sourceId,
   required this.statusId,
   required this.subReason,
   required this.subReasonId,
   required this.subReasonOther,
   required this.subSubReasonId,
   required this.subSubSubReasonId,
   required this.ticketCreatedAt,
   required this.ticketNumber,
   required this.ticketReferenceNumber,
   required this.ticketTypeId,
   required this.updatedAt,
   required this.userId,
   required this.workflowStatusId
}); // 1

  @override
  List<Object?> get props =>
      [
        addedByClient,
        address,
        alreadyEscalated,
        createdAt,
        details,
        files,
        id,
        lastAssignedUserAt,
        lastStatusUpdatedAt,
        latitude,
        locationUrl,
        longitude,
        mainReason,
        mainReasonId,
        mustRespondedBefore,
        priorityId,
        requesterId,
        resolvedAt,
        responsibleOrganizationId,
        sectorReply,
        sequenceNumber,
        slaId,
        slaStatusId,
        solution,
        solvedBy,
        sourceId,
        statusId,
        subReason,
        subReasonId,
        subReasonOther,
        subSubReasonId,
        subSubSubReasonId,
        ticketCreatedAt,
        ticketNumber,
        ticketReferenceNumber,
        ticketTypeId,
        updatedAt,
        userId,
        workflowStatusId,
      ];
}