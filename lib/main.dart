import 'dart:convert';

import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:fears_to_know/not_found_page/main.dart';
import 'package:fears_to_know/scene_guesser_page/main.dart';
import 'package:flutter/material.dart';
import 'package:fears_to_know/home_page/main.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() async
{
	await GetSecureStorage.init();
	await appLocalData.initializeAll();
  String todayDate = jsonDecode((await http.get(Uri.parse('https://timeapi.io/api/time/current/coordinate?latitude=1&longitude=1'))).body)["date"];
  debugPrint("today is $todayDate");

  if(appLocalData.getCommonValue("lastAccessDate") != todayDate)
  {
    debugPrint("date changed");
    await appLocalData.setCommonValue("lastAccessDate", todayDate);
    await appLocalData.clearCommonValue("sceneGuesserStoredGuesses");
  }

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
