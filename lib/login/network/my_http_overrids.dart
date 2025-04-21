import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  final SecurityContext securityContext;
  MyHttpOverrides(this.securityContext);
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context ?? securityContext);
  }
}
