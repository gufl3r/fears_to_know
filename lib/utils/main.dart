import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// comment old lists and set date-of-change comment on new lists please
List<String> scenesIdentifiers = // created 11/29/24
[
	"newGameEp5",
	"moesPizza",
	"welcomeToWoodbury",
	"fishing",
	"boardGame",
	"hideNSeek",
	"someonesAtTheDoor",
	"rick",
	"hidingInBasement"
];

dynamic getTodayIdentifier(List<dynamic> list, {bool yesterday = false})
{
	int seed = 1000;
	String initialDate = "11/28/2024";
	int initialDateInDays = DateFormat('MM/dd/yyyy').parse(initialDate).difference(DateTime(1970, 1, 1)).inDays; 
	String todayDate = appLocalData.getValue("common", "lastAccessDate")!;
	int todayDateInDays = DateFormat('MM/dd/yyyy').parse(todayDate).difference(DateTime(1970, 1, 1)).inDays - (yesterday ? 1 : 0);
	while (todayDateInDays >= initialDateInDays + list.length)
	{
	if (!yesterday) debugPrint("generating new cycle... ");
	initialDateInDays += list.length;
	seed++;
	}

	List<int> daysList = List.generate(list.length, (index) => initialDateInDays + index);
	daysList.shuffle(Random(seed));

	int todayIndex = daysList.indexOf(todayDateInDays); 
	//if (todayIndex == -1) throw "logic error: Today's date is not in the list.";

	// the only way 2 consecutive identifiers can happen is on when a new cycle starts: the first day of a cycle's identifier can be the last day of the last cycle's identifier
	var todayIdentifier = list[todayIndex];
	if (!yesterday) // yesterday will never be the same identifier as the day before
	{
	var yesterdayIdentifier = getTodayIdentifier(list, yesterday: true);
	while (todayIdentifier == yesterdayIdentifier)
	{
		debugPrint("same identifier as yesterday. rerandomizing...");
		todayIdentifier = list[Random(seed).nextInt(list.length)];
		seed++;
	}
	}

	return todayIdentifier;
}

Map<String, String> getSceneProperties(identifier)
{
	List<Map<String, String>> scenesProperties =
	[
		{
			"identifier": "newGameEp5",
			"episode": "woodburyGetaway", // int
			"progress": "15", // %
			"peopleCount": "3-5", // int
			"jumpscareCount": "1", // int
			"feeling": "neutralSceneFeeling_text" // string
		},
		{
			"identifier": "moesPizza",
			"episode": "woodburyGetaway",
			"progress": "30",
			"peopleCount": "7+",
			"jumpscareCount": "0",
			"feeling": "weirdSceneFeeling_text"
		},
		{
			"identifier": "welcomeToWoodbury",
			"episode": "woodburyGetaway",
			"progress": "30",
			"peopleCount": "3-5",
			"jumpscareCount": "1",
			"feeling": "calmSceneFeeling_text"
		},
		{
			"identifier": "fishing",
			"episode": "woodburyGetaway",
			"progress": "45",
			"peopleCount": "3-5",
			"jumpscareCount": "0",
			"feeling": "calmSceneFeeling_text"
		},
		{
			"identifier": "boardGame",
			"episode": "woodburyGetaway",
			"progress": "45",
			"peopleCount": "1-2",
			"jumpscareCount": "0",
			"feeling": "weirdSceneFeeling_text"
		},
		{
			"identifier": "hideNSeek",
			"episode": "woodburyGetaway",
			"progress": "60",
			"peopleCount": "1-2",
			"jumpscareCount": "2",
			"feeling": "funSceneFeeling_text"
		},
		{
			"identifier": "someonesAtTheDoor",
			"episode": "woodburyGetaway",
			"progress": "75",
			"peopleCount": "1-2",
			"jumpscareCount": "0",
			"feeling": "fearSceneFeeling_text"
		},
		{
			"identifier": "rick",
			"episode": "woodburyGetaway",
			"progress": "90",
			"peopleCount": "1-2",
			"jumpscareCount": "0",
			"feeling": "despairSceneFeeling_text"
		},
		{
			"identifier": "hidingInBasement",
			"episode": "woodburyGetaway",
			"progress": "90",
			"peopleCount": "3-5",
			"jumpscareCount": "0",
			"feeling": "despairSceneFeeling_text"
		},
	];
	return scenesProperties.firstWhere((scene) => scene["identifier"] == identifier);
}