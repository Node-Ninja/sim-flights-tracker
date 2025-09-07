import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StartVatsimAuthScreen extends ConsumerStatefulWidget {
  final Uri authUri;

  const StartVatsimAuthScreen({required this.authUri, super.key});

  @override
  ConsumerState<StartVatsimAuthScreen> createState() => _StartVatsimAuthScreen();
}

class _StartVatsimAuthScreen extends ConsumerState<StartVatsimAuthScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(SftColors.primaryDark)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {

            final url = request.url;

            if (url.startsWith('https://www.simflightstracker.com/oauth/complete')) {

              final uri = Uri.parse(url);
              final authId = uri.queryParameters['state'];
              final status = uri.queryParameters['status'];

              if (authId != null && status == 'success') {
                await ref.read(appConfigProvider.notifier).completeAuthentication(authId);
              } else {
                ref.read(appConfigProvider.notifier).authFailed(authId ?? '');
              }

              if (mounted) {
                context.pop();
              }
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            ref.read(appConfigProvider.notifier).updateWebviewNavigating(true);
          },
          onPageFinished: (String url) {
            ref.read(appConfigProvider.notifier).updateWebviewNavigating(false);
          }
        ),
      )
      ..loadRequest(widget.authUri);
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = ref.watch(appConfigProvider.select((state) => state.isWebviewNavigating));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: (isLoading)
                ? LinearProgressIndicator(color: SftColors.lightOrange,)
                : null,
            ),
            Expanded(
              child: WebViewWidget(controller: _webViewController),
            ),
          ],
        ),
      ),
    );
  }
}