import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
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
  bool doesSupportAnimation = false;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3)
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          shouldAnimate = false;
        });
      }
    })
    ..repeat(reverse: true, period: const Duration(seconds: 3));

  late final ShakeDetector _detector = ShakeDetector.waitForStart(
    onPhoneShake: () {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Shake!')));

      setState(() {
        shouldAnimate = true;
      });
    },
    minimumShakeCount: 1,
    shakeSlopTimeMS: 500,
    shakeCountResetTime: 2000,
    shakeThresholdGravity: 1.7,
  );

  bool shouldAnimate = false;

  final player = AudioPlayer();
  String handBellAudioPath = "sounds/hand-bell.m4a";
  String deskBellAudioPath = "sounds/desk-bell.mp3";

  @override
  void initState() {
    super.initState();
    if (!doesSupportAnimation) {
      return;
    }

    _detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),

                const TextTitle(text: "HelloBell"),
                bellImage(),

                Spacer(flex: 1),
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
    if (shouldAnimate) {
      _controller.forward();
    } else {
      _controller.reset();
    }

    if (!doesSupportAnimation) {
      return GestureDetector(
        child: Image.asset(
            "assets/images/icon_app_original.png"
        ),
        onTap: () {
          setState(() {
            shouldAnimate = !shouldAnimate;
          });
        }
      );
    }

    return GestureDetector(
      child: Lottie.asset(
        "assets/anims/lottie_bell_anim.json",
        controller: _controller,
      ),
      onTap: () {
        setState(() {
          shouldAnimate = !shouldAnimate;
        });
      },
    );
  }

  Future<void> _share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> _handleSound() async {
    if (shouldAnimate) {
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
