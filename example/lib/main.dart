import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:webview_ssl/webview_ssl.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const WebViewPage(),
          ),
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void dispose() {
    WebViewSSLController.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView SSL example'),
        actions: const [
          IconButton(
            onPressed: WebViewSSLController.reload,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: WebViewSSL(
        initialUrl: 'https://3dsecmt.sberbank.ru/payment/se/keys.do',
        // initialUrl: 'https://google.com',
        sslAssets: const [
          'assets/cert/RussianTrustedRootCA.der',
          'assets/cert/RussianTrustedSubCA.der',
        ],
        onNavigate: (url) {
          if (url.contains('wikipedia.org')) {
            print('URL decline: $url');
            return WebViewSSLNavigation.decline;
          }
          print('URL allow: $url');
          return WebViewSSLNavigation.allow;
        },
        onError: (error) {
          print('ERROR: $error');
        },
      ),
    );
  }
}
