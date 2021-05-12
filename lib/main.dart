import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'services/user_local_data.dart';

List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _alreadyLogin() {
    final String uid = UserLocalData.getUID();
    if (uid == '' || uid.isEmpty || uid == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYREVUE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
      ),
      home: (_alreadyLogin() == true) ? HomeScreen() : LoginScreen(),
    );
  }
}

// Certificate fingerprints:
//   SHA1: C2:F0:05:80:D6:F6:CF:86:6D:AB:37:91:33:54:E7:1C:CF:CB:65:98
//   SHA256: E9:A6:05:74:98:95:AA:A6:A7:C6:00:EB:99:D6:68:D4:84:FD:6E:D2:ED:8E:6A:03:E3:D4:26:29:88:D5:FD:52