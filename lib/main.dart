import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorantgame/constant/constant.dart';
import 'package:valorantgame/cubit/character_cubit.dart';
import 'package:valorantgame/data/repo/repo_layer.dart';
import 'package:valorantgame/view/screens/home.dart';
import 'package:valorantgame/view/screens/onboarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefInst = await SharedPreferences.getInstance();
  prefInst.get('isIntroRead') ?? prefInst.setBool('isIntroRead', false);




  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CharacterCubit>(
        create: (context) => CharacterCubit(charactersRepository),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,


      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(
            splashIconSize: 150,
            splash: 'assets/images/profile.png',
            nextScreen: MyApp(),
            splashTransition: SplashTransition.fadeTransition,

            backgroundColor:Colors.white
        ),

      },
    ),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 27, 32, 35),
        body:const Home()
    );
  }
}
