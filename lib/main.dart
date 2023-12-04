import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voice_call_sample/firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    onUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Call Demo',
      navigatorKey: widget.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  void onUserLogin() {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 573420767,
      appSign: '6c96770acc446a3f54a7748ebed8858107ff871a3399a8e5086a849d80ebdecd',
      userID: '12345678',
      userName: 'Sinnoor C',
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  void onUserLogout() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  void call() {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: ZegoSendCallInvitationButton(
        isVideoCall: false,
        invitees: [
          ZegoUIKitUser(
            id: '987654',
            name: 'Sinnoor X',
          ),
        ],
        resourceID: "voice_call_demo",
        iconSize: const Size(40, 40),
        buttonSize: const Size(50, 50),
        onPressed: (_, __, ___) {},
      ),
    );
  }
}
