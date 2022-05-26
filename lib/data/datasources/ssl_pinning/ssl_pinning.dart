import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';


import 'dart:convert';
import 'dart:developer';
import 'dart:io';


class SSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];

      if (isTestMode) {
        bytes = utf8.encode(_certificate);
      } else {
        bytes = (await rootBundle.load('certificates/certificate.cer')).buffer.asUint8List();
      }
      context.setTrustedCertificatesBytes(bytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null && e.osError!.message.contains('Certificate already in hash table')) {
        log('createHttpClient() - certificate already trusted.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client = IOClient(await customHttpClient(isTestMode: isTestMode));
    return client;
  }
}

const _certificate = """-----BEGIN CERTIFICATE-----
MIIFOTCCBCGgAwIBAgISBIJ8OK5BozXS2L9X1KqR5qzsMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMjA1MTQxNjE4NThaFw0yMjA4MTIxNjE4NTdaMCQxIjAgBgNVBAMT
GWRldmVsb3BlcnMudGhlbW92aWVkYi5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDDwKuAJIu4tcafzyzB6rO7apXUX87LGxrKLQzZtJdViYtZ3zbK
NWJjVdG1f6jdvfGy5ZuvFhEbPvPHFQdQk2G4Ex4/RWwlLaLXtyveD/5Oset+YTpO
l2BpwdrP+McDIMgsr2V+IT3PrULInrCB0IRyLm6AhA+QaKw9Ffa1RyGOJ5qGAX3Y
Rzh0tu94Y0swa0S7vPp4ykMyWFEjODINwWufQOGIVn6zznUK6uu/MWjPJvNYjUIr
9JQPgYCN5rFxi4pd3IHrBKg6/Ft8fF1/EjLRFXYRbootKQLjRY3+ImB6MLvbKRvK
V2rg0ON2C5qgXJsp+/pxr3UKMhSKn1ywIestAgMBAAGjggJVMIICUTAOBgNVHQ8B
Af8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB
/wQCMAAwHQYDVR0OBBYEFLr4NpE85QrNKoW+JXmv+WeoLGbgMB8GA1UdIwQYMBaA
FBQusxe3WFbLrlAJQOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcw
AYYVaHR0cDovL3IzLm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMu
aS5sZW5jci5vcmcvMCQGA1UdEQQdMBuCGWRldmVsb3BlcnMudGhlbW92aWVkYi5v
cmcwTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEF
BQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEFBgorBgEEAdZ5AgQC
BIH2BIHzAPEAdwApeb7wnjk5IfBWc59jpXflvld9nGAK+PlNXSZcJV3HhAAAAYDD
lJ1uAAAEAwBIMEYCIQCtEhmeIr2gGzJrksw/M0M5GM/aEloOcXFUDo3lvXwBLAIh
AOl03qZsrqaVkV9pfKbvVzw/GMDBhcscaYzU08r3IpXFAHYAQcjKsd8iRkoQxqE6
CUKHXk4xixsD6+tLx2jwkGKWBvYAAAGAw5SfjgAABAMARzBFAiBzohtMEMxqcRD9
zsPdKZlVsFnzvLBiwjHWb3puq/J6oAIhAL3xuzorvANQImxCXjeOeqNwRFBqpCKg
f3GTwilf3PEEMA0GCSqGSIb3DQEBCwUAA4IBAQCp/8VTMNge/VjdLby/B4wat3mK
NDB0keuZRYM6JezlBb6Zy/VC87JESzJZMarzVBnBu5IC4TnJ90uFH8O6MorT0/+6
lTesnHT3FrP9n5J70vFI0qoD7TFjgYkYxtHT910qP/Pqj7k8vjPUSGBPv+pGp79r
ATihCLCDzHeiw4uMXi1KXny7n/8ZaARZe/D3V1k51UQFotaDyW6T2euj0hAjSh07
1mNJ2GryglkUk8WUu2A8dUY7omeqvTzdVcVOdHuzHrs4XDlnig0DJm/wvEjZ+gNk
EzVa5UuEzq9gaVXrMh+H/YIWhiEDnAHxj4Sveua4ZMXuZYESsDhv7QoQB0Tw
-----END CERTIFICATE-----""";
