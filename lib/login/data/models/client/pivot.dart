import 'package:json_annotation/json_annotation.dart';

part 'pivot.g.dart';

@JsonSerializable()
class Pivot {
  @JsonKey(name: 'client_id')
  final int clientId; // 415270

  @JsonKey(name: 'created_at')
  final String createdAt; // 2023-08-24T09:40:38.000000Z

  @JsonKey(name: 'creation_date')
  final dynamic creationDate; // null

  @JsonKey(name: 'expiration_date')
  final dynamic expirationDate; // null

  @JsonKey(name: 'file_number')
  final int fileNumber; // 1692870038

  @JsonKey(name: 'hospital_id')
  final int hospitalId; // 1

  final int id; // 415323

  @JsonKey(name: 'updated_at')
  final String updatedAt; // 2023-08-24T09:40:38.000000Z

  Pivot({
    required this.clientId,
    required this.createdAt,
    this.creationDate,
    this.expirationDate,
    required this.fileNumber,
    required this.hospitalId,
    required this.id,
    required this.updatedAt,
  });
  // Add these methods to handle conversion
  static int _parseInt(dynamic value) {
    if (value is String) return int.parse(value);
    return value as int;
  }

  static String _toString(int value) => value.toString();

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);
  Map<String, dynamic> toJson() => _$PivotToJson(this);

  @override
  String toString() {
    return 'Pivot(id: $id, clientId: $clientId, hospitalId: $hospitalId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pivot &&
        id == other.id &&
        clientId == other.clientId &&
        hospitalId == other.hospitalId &&
        fileNumber == other.fileNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    clientId.hashCode ^
    hospitalId.hashCode ^
    fileNumber.hashCode;
  }
}