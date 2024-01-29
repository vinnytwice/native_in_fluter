import 'dart:developer' as console;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AdatptivePlatformView extends StatelessWidget {
  final String nativeScreen;
  final String viewType;
  final dynamic creationParams;
  final TextDirection? layoutDirection;
  final MessageCodec<dynamic>? creationParamsCodec;
  const AdatptivePlatformView(
      {super.key,
      required this.viewType,
      this.creationParams,
      this.creationParamsCodec,
      this.layoutDirection,
      required this.nativeScreen});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          )
        : UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            hitTestBehavior: PlatformViewHitTestBehavior.translucent,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          );
  }
}
