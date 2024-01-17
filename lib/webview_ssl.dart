import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebViewSSL extends StatefulWidget {
  final Function(dynamic url)? onNavigationChange;
  final List<String> sslAssets;
  final String initialUrl;

  const WebViewSSL({
    super.key,
    required this.initialUrl,
    this.sslAssets = const [],
    this.onNavigationChange,
  });

  @override
  State<WebViewSSL> createState() => _WebViewSSLState();
}

class _WebViewSSLState extends State<WebViewSSL> {
  final eventChannel = const EventChannel('com.example.webview_ssl');

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(widget.onNavigationChange);
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
            'initialUrl': widget.initialUrl,
            'sslAssets': widget.sslAssets,
          },
        );
      case TargetPlatform.android:
      default:
        throw UnsupportedError('Unsupported');
    }
  }
}
