import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  @override
  NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Najnovije Vesti'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        textTheme: Theme.of(context).appBarTheme.textTheme,
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://covid19.rs/вести',
      ),
    );
  }
}
