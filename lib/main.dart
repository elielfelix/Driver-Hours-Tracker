import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const DotHoursTrackerApp());
}

class DotHoursTrackerApp extends StatelessWidget {
  const DotHoursTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOT Hours Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B1120),
      ),
      home: const HoursTrackerHome(),
    );
  }
}

class HoursTrackerHome extends StatefulWidget {
  const HoursTrackerHome({super.key});

  @override
  State<HoursTrackerHome> createState() => _HoursTrackerHomeState();
}

class _HoursTrackerHomeState extends State<HoursTrackerHome> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  Future<void> _initWebView() async {
    try {
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0xFF0B1120))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (_) {
              if (mounted) {
                setState(() => _isLoading = false);
              }
            },
            onWebResourceError: (error) {
              if (mounted) {
                setState(() {
                  _error = error.description;
                  _isLoading = false;
                });
              }
            },
          ),
        );

      final htmlString = await DefaultAssetBundle.of(context)
          .loadString('assets/web/dot_hours_tracker.html');
      await controller.loadHtmlString(htmlString);

      if (mounted) {
        setState(() {
          _controller = controller;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('WebView init error: $e');
      }
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            if (_error == null && _controller != null)
              WebViewWidget(controller: _controller!)
            else if (_error != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load app: $_error',
                        style: const TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _error = null;
                            _isLoading = true;
                          });
                          _initWebView();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
              ),
          ],
        ),
      ),
    );
  }
}
