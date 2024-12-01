import 'dart:async';

import 'package:get_secure_storage/get_secure_storage.dart';

var appLocalData = LocalData();

class LocalData
{
  // initializers have specific functions because they need to be specifically created/edited
  // getters/setters/clearers have only one function because the process of adding a new one is just copy and paste
	Map<String, String?> settings = {};
  Map<String, String?> common = {};

	LocalData();

  Future<void> initializeAll() async
  {
    await initializeSettings();
    await initializeCommon();
  }

	Future<void> initializeSettings() async
	{
		if (!GetSecureStorage().hasData("displayTheme_settings"))
		{
			await GetSecureStorage().write("displayTheme_settings", "light");
		}
		if (!GetSecureStorage().hasData("language_settings"))
		{
			await GetSecureStorage().write("language_settings", "English-US");
		}
		settings = 
		{
			"displayTheme": GetSecureStorage().read("displayTheme_settings"),
			"language": GetSecureStorage().read("language_settings"),
		};
	}

  Future<void> initializeCommon() async // specific function because needs to be specifically created/edited
  {
    if (!GetSecureStorage().hasData("sceneGuesserStoredGuesses_common"))
		{
			await GetSecureStorage().write("sceneGuesserStoredGuesses_common", "[]");
		}
      if (!GetSecureStorage().hasData("lastAccessDate_common"))
		{
			await GetSecureStorage().write("lastAccessDate_common", "");
		}
    common = 
    {
      "sceneGuesserStoredGuesses": GetSecureStorage().read("sceneGuesserStoredGuesses_common"),
      "lastAccessDate": GetSecureStorage().read("lastAccessDate_common")
    };
  }

	String? getValue(String group, String key)
	{
    switch (group) 
    {
      case "settings":
		    return settings[key];
      case "common":
		    return common[key];
    }
    return null;
	}

	Future<void> setValue(String group, String key, String value) async
	{
    switch (group) 
    {
      case "settings":
		    settings[key] = value;
      case "common":
		    common[key] = value;
    }
		await GetSecureStorage().write("${key}_$group", value);
	}

	Future<void> clearValue(String group, String key) async
	{
		await GetSecureStorage().remove("${key}_$group");
    switch (group) 
    {
      case "settings":
		    settings.remove(key);
        initializeSettings();
      case "common":
		    common.remove(key);
        initializeCommon();
    }
	}
}