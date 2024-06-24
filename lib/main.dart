import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:auto_control_panel/providers/weather_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:auto_control_panel/screens/about_screen.dart';
import 'package:auto_control_panel/screens/details_screen.dart';
import 'package:auto_control_panel/screens/form_screen.dart';
import 'package:auto_control_panel/screens/signin_screen.dart';
import 'package:auto_control_panel/screens/signup_picture_screen.dart';
import 'package:auto_control_panel/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TarefaProvider>(
            create: (context) => TarefaProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
             ChangeNotifierProvider<WeatherProvider>(
            create: (context) => WeatherProvider()),
      ],
      //create: (context) => AbastProvider(),
      child: MaterialApp(
        title: 'Tarefa Panel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.yellow[50],
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
        routes: {
          //Registando as possíveis rotas,
          Routes.SIGNIN: (context) => SigninScreen(),
          Routes.SIGNUP: (context) => const SignupScreen(),
          Routes.SIGNUPPICTURE: (context) => const SignUpPictureScreen(),
          Routes.HOME: (context) => const HomeScreen(),
          Routes.ABOUT: (context) => const AboutScreen(),
          Routes.DETAILS: (context) => const DetailsScreen(),
          Routes.FORM: (context) => const FormScreen(),
        },
      ),
    );
  }
}
