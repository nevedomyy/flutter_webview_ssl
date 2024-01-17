# WebView Plugin with SSL Certificates for IOS


```
Scaffold(
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
)
```


<img src="s1.png" height="340" width="160"/>  <img src="s2.png" height="120" width="160"/> 
