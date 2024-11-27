import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:fears_to_know/not_found_page/main.dart';
import 'package:fears_to_know/scene_guesser_page/main.dart';
import 'package:flutter/material.dart';
import 'package:fears_to_know/home_page/main.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

void main() async
{
	await GetSecureStorage.init();
	await appLocalData.initializeAll();
  //appLocalData.clearCommonValue("sceneGuesserStoredGuesses");

	runApp(const MainApp());
}

class MainApp extends StatelessWidget 
{
	const MainApp({super.key});

	@override
	Widget build(BuildContext context) 
	{
		return MaterialApp
		(
      initialRoute: "/home",
      routes: 
      {
        "/home": (context) => const HomePage(),
        "/scene_guesser": (context) => const SceneGuesserPage(),
      },
      onUnknownRoute: (settings) 
      { 
        return MaterialPageRoute(builder: (context) => const NotFoundPage(), ); 
      }
		);
	}
}
