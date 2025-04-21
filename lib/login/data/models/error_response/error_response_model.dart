import 'package:hollat/login/domain/entities/error_response/error_response.dart';

class ErrorResponseModel extends ErrorResponse {
  const ErrorResponseModel({required super.message, required super.errors});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
          message: json['message'] as String?,
          errors: (json['errors'] as Map<String, dynamic>?)?.map((key, value) =>
              MapEntry(key,
                  (value as List<dynamic>).map((e) => e as String).toList())));
  // factory ErrorResponseModel.fromJson(Map<String, dynamic> json){
  //   List<String> errorMessages = [];
  //   // Check if 'errors' is of type Map<String, dynamic>
  //   if (json['errors'] is Map<String, dynamic>) {
  //     final errorMap = json['errors'] as Map<String, dynamic>;
  //     errorMessages = errorMap.values.expand((value) => value as List<dynamic>).map((e) => e as String).toList();
  //   }
  //   // Check if 'errors' is of type List
  //   else if (json['errors'] is List) {
  //     errorMessages = (json['errors'] as List<dynamic>).map((e) => e as String).toList();
  //   }
  //
  //   // Ensure always returning a valid ErrorResponseModel
  //   return ErrorResponseModel(
  //     message: json['message'] ?? 'Unknown error',
  //     errors: errorMessages.isNotEmpty ? errorMessages : ['No error details available.'],
  //   );
  // }
}
