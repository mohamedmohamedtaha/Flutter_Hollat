import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hollat/login/network/my_http_overrids.dart';

class Certificate {
  static void initCertificate() async {
    final sslCert =
        await rootBundle.load('assets/certificates/back-dev.hollat.crt');
    final securityContext = SecurityContext();
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
    HttpOverrides.global = MyHttpOverrides(securityContext);
  }
}
