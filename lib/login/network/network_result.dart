import 'dart:io';

sealed class NetworkResult<T> {
  const NetworkResult();
}
class Initial<T> extends NetworkResult<T> {
  const Initial();
}
class Loading<T> extends NetworkResult<T> {
  const Loading();
}

class Success<T> extends NetworkResult<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends NetworkResult<T> {
  final int code;
  final String message;
  const Error(this.code, this.message);
}

class NetworkException<T> extends NetworkResult<T> {
  final Exception exception;
  const NetworkException(this.exception);
}
//
// class Loading<T> extends NetworkResult<T> {
//   final bool loading;
//
//   const Loading([this.loading = true]);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Loading &&
//               runtimeType == other.runtimeType &&
//               loading == other.loading;
//
//   @override
//   int get hashCode => loading.hashCode;
//
//   @override
//   String toString() => 'Loading(loafing: $loading)';
// }
//
// class Success<T> extends NetworkResult<T> {
//   final T data;
//
//   const Success(this.data);
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, StdioType.other) ||
//         other is Success &&
//             runtimeType == other.runtimeType &&
//             data == other.data;
//   }
//
//   @override
//   int get hashCode => data.hashCode;
//
//   @override
//   String toString() => 'Success(data: $data)';
// }
//
// class Error<T> extends NetworkResult<T> {
//   final int code;
//   final ResponseBody? responseBody;
//
//   const Error(this.code, [this.responseBody]);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Error &&
//               runtimeType == other.runtimeType &&
//               code == other.code &&
//               responseBody == other.responseBody;
//
//   @override
//   int get hashCode => code.hashCode ^ responseBody.hashCode;
//
//   @override
//   String toString() => 'Error(code: $code,responseBody: $responseBody)';
// }

class ResponseBody {
  final dynamic data;
  final Map<String, String> headers;

  const ResponseBody(this.data, this.headers);
}
