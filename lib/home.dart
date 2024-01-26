import 'dart:async';
import 'dart:developer' as console;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_in_fluter/native_viewer.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MethodChannel channel; // = const MethodChannel('test_platform_channel');
  late MethodChannel nativeViewerPlatformCahannel;
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 4), () {
    //   console.log('time is up for screen switching');
    //   Navigator.pop(context);
    //   setState(() {
    //     var params = {
    //       'screen': 'viewController2',
    //       'param 1': 'close native',
    //       'param 2': 'goto VC1'
    //     };
    //     pushNativeView(
    //         context: context,
    //         nativeViewTitle: params['screen']!,
    //         params: params);
    //   });
    // });

    channel = const MethodChannel('test_platform_channel');
    channel.invokeMethod('test', []).catchError((e) {
      console.log('Home screen: test message error;:  $e');
    });
    channel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'swift_to_flutter':
          console.log(
              'Home swift_to_flutter 📞 received in Home with args ${call.arguments}');

          break;
        default:
      }
      return call.arguments;
    });

    nativeViewerPlatformCahannel =
        const MethodChannel('native_viewer_platform_channel');
    nativeViewerPlatformCahannel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'switch_to_screen':
          console.log(
              'Home switch_to_screen 📞 received with args ${call.arguments}');

          Timer(const Duration(seconds: 4), () {
            var params = Map<String, dynamic>.from(call.arguments);
            Navigator.pop(context);
            pushNativeView(
                context: context,
                nativeViewTitle: call.arguments['screen'],
                params: params);
          });
          // Navigator.pop(context);
          // pushNativeView(
          //     context: context,
          //     nativeViewTitle: call.arguments['screen'],
          //     params: call.arguments);

          break;
        default:
      }
      return call.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    console.log('Home build');
    Map<String, dynamic> params = <String, dynamic>{};
    String nativeViewTitle = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'Screen A';
                params.clear();
                params = {
                  'screen': 'viewController',
                  'param 1': 'close native',
                  'param 2': 'goto VC2'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
                // callNative();
              },
              child: const Text(
                'Navigate to ios screen A',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'Screen B';
                params.clear();
                params = {
                  'screen': 'viewController2',
                  'param 1': 'close native',
                  'param 2': 'goto VC1'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
                // callNative();
                // channel.invokeMethod(
                //     "navigate_to-screen_b", ["screen_b"]).catchError((e) {
                //   console.log('invokeMethod b error: $e');
                // });
              },
              child: const Text(
                'Navigate to ios screen B',
              ),
            )
          ],
        ),
      ),
    );
  }

  // void callNative() {
  //   channel.invokeMethod("test", []).catchError((e) {
  //     console.log('invokeMethod test error: $e');
  //   });
  // }

  void callNative() async {
    await channel.invokeMethod("test", []).catchError((e) {
      console.log('invokeMethod test error: $e');
    });
  }

  void pushNativeView(
      {required BuildContext context,
      required String nativeViewTitle,
      required Map<String, dynamic> params}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NativeViewer(
            nativeScreen: "scgline uno",
            title: nativeViewTitle,
            viewParams: params),
      ),
    );
  }
}
