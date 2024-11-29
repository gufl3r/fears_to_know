import 'dart:async';

import 'package:get_secure_storage/get_secure_storage.dart';

var appLocalData = LocalData();

class LocalData
{
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

	String? getSettingsValue(String key)
	{
		return settings[key];
	}

	Future<void> setSettingsValue(String key, String value) async
	{
		settings[key] = value;
		await GetSecureStorage().write("${key}_settings", value);
	}

	Future<void> clearSettingsValue(String key) async
	{
		settings.remove(key);
		await GetSecureStorage().remove("${key}_settings");
		initializeSettings();
	}

  Future<void> initializeCommon() async
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

	String? getCommonValue(String key)
	{
		return common[key];
	}

	Future<void> setCommonValue(String key, String value) async
	{
		common[key] = value;
		await GetSecureStorage().write("${key}_common", value);
	}

	Future<void> clearCommonValue(String key) async
	{
		common.remove(key);
		await GetSecureStorage().remove("${key}_common");
		initializeCommon();
	}
}