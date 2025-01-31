import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hollat/login/data/models/client/client.dart';

part 'nafaz_status_response.g.dart';

@JsonSerializable(checked: false, ignoreUnannotated: true, explicitToJson: true)
class NafazStatusResponse {
  @JsonKey(name: 'client',includeIfNull: false)
  final Client? client;
  @JsonKey(name: 'status')
  final String status; // COMPLETED
  @JsonKey(name: 'token',includeIfNull: false)
  final String? token; // JWT token string

  NafazStatusResponse({
    required this.client,
    required this.status,
    required this.token,
  });

  factory NafazStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$NafazStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NafazStatusResponseToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NafazStatusResponse &&
        client == other.client &&
        status == other.status &&
        token == other.token;
  }

  @override
  int get hashCode => Object.hash(client, status, token);
}
