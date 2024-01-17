import 'package:flutter/material.dart';
import 'package:webview_ssl/webview_ssl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebView SSL example'),
        ),
        body: WebViewSSL(
          initialUrl: 'https://3dsecmt.sberbank.ru/payment/se/keys.do',
          sslAssets: const [
            'assets/cert/RussianTrustedRootCA.der',
            'assets/cert/RussianTrustedSubCA.der',
          ],
          onNavigationChange: (url) {
            print(url);
          },
        ),
      ),
    );
  }
}
