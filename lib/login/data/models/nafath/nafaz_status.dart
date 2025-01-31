import 'package:json_annotation/json_annotation.dart';

part 'nafaz_status.g.dart';

@JsonSerializable()
class NafazStatus {
  final String id; // 2352946137
  final String random; // 18
  @JsonKey(name: 'transId')
  final String transId; // db547830-7534-4e05-8160-8afc0f536a72

  NafazStatus({
    required this.id,
    required this.random,
    required this.transId,
  });

  factory NafazStatus.fromJson(Map<String, dynamic> json) =>
      _$NafazStatusFromJson(json);

  Map<String, dynamic> toJson() => _$NafazStatusToJson(this);

  @override
  String toString() {
    return 'NafathStatus(id: $id, random: $random, transId: ${transId.substring(0, 8)}...)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NafazStatus &&
        id == other.id &&
        random == other.random &&
        transId == other.transId;
  }

  @override
  int get hashCode => Object.hash(id, random, transId);
}
