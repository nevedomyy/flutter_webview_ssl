import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum WebViewSSLNavigation { allow, decline }

const _mChannel = MethodChannel('com.example.webview_ssl');

class WebViewSSLController {
  static Future<void> loadUrl(String url) =>
      _mChannel.invokeMethod('loadUrl', {'url': url});

  static Future<void> reload() => _mChannel.invokeMethod('reload');

  static Future<void> clearCache() => _mChannel.invokeMethod('clearCache');
}

class WebViewSSL extends StatefulWidget {
  final WebViewSSLNavigation Function(String url) onNavigate;
  final Function(String error) onError;
  final List<String> sslAssets;
  final String initialUrl;

  const WebViewSSL({
    super.key,
    required this.initialUrl,
    required this.onNavigate,
    required this.onError,
    this.sslAssets = const [],
  });

  @override
  State<WebViewSSL> createState() => _WebViewSSLState();
}

class _WebViewSSLState extends State<WebViewSSL> {
  @override
  void initState() {
    super.initState();
    _mChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onNavigate':
          final url = call.arguments['url'] as String? ?? '';
          if (url.isNotEmpty) {
            return widget.onNavigate(url) == WebViewSSLNavigation.allow;
          }
          return false;
        case 'onError':
          final error = call.arguments['error'] as String? ?? '';
          if (error.isNotEmpty) {
            widget.onError(error);
          }
          return Future<void>;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'WebViewSSL',
          layoutDirection: TextDirection.ltr,
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: {
            'url': widget.initialUrl,
            'sslAssets': widget.sslAssets,
          },
        );
      case TargetPlatform.android:
      default:
        throw UnsupportedError('Unsupported');
    }
  }
}
