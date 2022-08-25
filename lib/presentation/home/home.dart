import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hellobell/presentation/core/anim/shake_widget.dart';
import 'package:hellobell/presentation/core/app_constant.dart';
import 'package:hellobell/presentation/core/buttons/app_button.dart';
import 'package:hellobell/presentation/core/texts/app_texts.dart';
import 'package:lottie/lottie.dart';
import 'package:shake/shake.dart';
import 'package:store_redirect/store_redirect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // NOTICE: temporarily pause observing the shake detector
  //  as we don't have a proper lottie animation yet.
  final bool _doesSupportLottieAnimation = false;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _shouldAnimate = false;
            });
          }
        })
        ..repeat(reverse: true, period: const Duration(seconds: 3));

  final shakeAnimationKey = GlobalKey<ShakeWidgetState>();

  late final ShakeDetector _detector = ShakeDetector.waitForStart(
    onPhoneShake: () {
      setState(() {
        _shouldAnimate = true;
      });
    },
    minimumShakeCount: 1,
    shakeSlopTimeMS: 500,
    shakeCountResetTime: 1500,
    shakeThresholdGravity: 1.6,
  );

  bool _shouldAnimate = false;

  final player = AudioPlayer();
  bool _isPlayingSound = false;
  String handBellAudioPath = "sounds/hand-bell.m4a";
  String deskBellAudioPath = "sounds/desk-bell.mp3";

  @override
  void initState() {
    super.initState();
    player.onPlayerComplete.listen((event) {
      setState(() {
        _shouldAnimate = false;
        _isPlayingSound = false;
      });
    });

    _detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                const Padding(
                  padding: EdgeInsets.only(bottom: 66),
                  child: TextTitle(text: "HelloBell"),
                ),
                bellImage(),
                const Spacer(flex: 1),
                Row(
                  children: [
                    Expanded(child: AppButton(text: "Share", onClick: _share)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: AppButton(
                            text: "Feedback", onClick: _redirectToMarket))
                  ],
                ),
              ],
            ))));
  }

  Widget bellImage() {
    _handleSound();
    if (_doesSupportLottieAnimation && _shouldAnimate) {
      _controller.forward();
    } else if (!_doesSupportLottieAnimation && _shouldAnimate) {
      shakeAnimationKey.currentState?.shake();
    } else {
      _controller.reset();
    }

    if (!_doesSupportLottieAnimation) {
      // still image
      return GestureDetector(
          child: ShakeWidget(
              key: shakeAnimationKey,
              shakeCount: 5,
              shakeOffset: 10,
              shakeDuration: const Duration(milliseconds: 2500),
              child: Image.asset("assets/images/icon_app_original.png")),
          onTap: () {
            setState(() {
              _shouldAnimate = !_shouldAnimate;
            });
          });
    }

    return GestureDetector(
      child: Lottie.asset(
        "assets/anims/lottie_bell_anim.json",
        controller: _controller,
      ),
      onTap: () {
        setState(() {
          _shouldAnimate = !_shouldAnimate;
        });
      },
    );
  }

  Future<void> _share() async {
    var storeText = "Google Play";
    if (Platform.isIOS) {
      storeText = "AppStore";
    }

    var storeLink = AppConstant.googlePlayStoreUrl;
    if (Platform.isIOS) {
      storeText = AppConstant.appStoreUrl;
    }

    await FlutterShare.share(
        title: 'Share this cool app with your friends',
        text: 'Hi, Share this cool app with your friends!',
        linkUrl: storeLink,
        chooserTitle: 'Where do you want to share with?');
  }

  Future<void> _handleSound() async {
    if (_isPlayingSound) {
      return;
    }

    if (_shouldAnimate) {
      _isPlayingSound = true;
      await player.play(AssetSource(handBellAudioPath));
    } else {
      player.stop();
    }
  }

  Future<void> _redirectToMarket() async {
    await StoreRedirect.redirect(
      androidAppId: AppConstant.androidAppId,
      iOSAppId: AppConstant.iOSAppId,
    );
  }

  @override
  void dispose() {
    _detector.stopListening();
    _controller.dispose();
    super.dispose();
  }
}
