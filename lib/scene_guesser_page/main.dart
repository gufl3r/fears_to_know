import 'dart:convert';

import 'package:fears_to_know/stored_widgets/main.dart';
import 'package:fears_to_know/utils/main.dart';
import 'package:fears_to_know/display_theme_manager/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fears_to_know/translation_manager/main.dart';
import 'package:json_table/json_table.dart';
import 'package:flutter/material.dart';
import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';


class SceneGuesserPage extends StatefulWidget
{
	const SceneGuesserPage({super.key});

	@override
	State<SceneGuesserPage> createState() => _SceneGuesserPageState();
}

class _SceneGuesserPageState extends State<SceneGuesserPage> 
{
	String? selectedDropdownItem;
	List<dynamic> scenesGuessed = jsonDecode(appLocalData.getCommonValue("sceneGuesserStoredGuesses")!);
	String todaysSceneIdentifier = "fishing";

	List<Map<String, String>> getScenesGuessedPropertiesDisplay() 
	{
		List<Map<String, String>> scenesGuessedProperties = [];

		Map<String, String> todaysSceneProperties = getSceneProperties(todaysSceneIdentifier);
		for (var sceneIdentifier in scenesGuessed) 
		{
			Map<String, String> thisSceneProperties = getSceneProperties(sceneIdentifier);
			String sceneNameMatch = thisSceneProperties["identifier"] == todaysSceneProperties["identifier"] ? "+match" : "+nomatch";
			String episodeNameMatch = thisSceneProperties["episode"] == todaysSceneProperties["episode"] ? "+match" : "+nomatch";
			String progressState = thisSceneProperties["progress"] == todaysSceneProperties["progress"] ? "+match" : 
			int.parse(thisSceneProperties["progress"]!) < int.parse(todaysSceneProperties["progress"]!) ? "+up" : "+down";
			String peopleCountState = thisSceneProperties["peopleCount"] == todaysSceneProperties["peopleCount"] ? "+match" : 
			int.parse(thisSceneProperties["peopleCount"]!.split("")[0]) < int.parse(todaysSceneProperties["peopleCount"]!.split("")[0]) ? "+up" : "+down";
			String jumpscareCountState = thisSceneProperties["jumpscareCount"] == todaysSceneProperties["jumpscareCount"] ? "+match" : 
			int.parse(thisSceneProperties["jumpscareCount"]!) < int.parse(todaysSceneProperties["jumpscareCount"]!) ? "+up" : "+down";
			String feelingMatch = thisSceneProperties["feeling"] == todaysSceneProperties["feeling"] ? "+match" : "+nomatch";
			
			scenesGuessedProperties.add
			(
				{
					"sceneNameColumn_text": getTranslated("${thisSceneProperties["identifier"]!}SceneName_text")! + sceneNameMatch,
					"episodeNameColumn_text": getTranslated("${thisSceneProperties["episode"]!}EpisodeName_text")! + episodeNameMatch,
					"progressColumn_text": "~${thisSceneProperties["progress"]}%$progressState",
					"peopleCountColumn_text": thisSceneProperties["peopleCount"]! + peopleCountState,
					"jumpscareCountColumn_text": thisSceneProperties["jumpscareCount"]! + jumpscareCountState,
					"feelingColumn_text": getTranslated(thisSceneProperties["feeling"]!)! + feelingMatch,
				}
			);
		}
		return scenesGuessedProperties;
	}

	void _setState() 
	{ 
		setState(() {});
	}
	
	@override
	Widget build(BuildContext context) 
	{
		return Scaffold
		(
			backgroundColor: getColor("background"),
			appBar: PreferredSize
			(
				preferredSize: Size(MediaQuery.sizeOf(context).width, 80), 
				child: PersistentAppBar
				( 
					externalSetState: _setState,
				)
			),
			body: Column
			(
				children: 
				[
					const SizedBox(height: 100,),
					Row
					(
						mainAxisAlignment: MainAxisAlignment.center,
						children: 
						[
							SizedBox
							( 
								width: 250, 
								height: 50,
								child: Theme
								(
									data: ThemeData
									(
										textSelectionTheme: TextSelectionThemeData(selectionColor: getColor("selected")),
									),
									child: DropdownSearch<String>
									(
										selectedItem: "",
										items: (f, cs) => f.isNotEmpty ? scenesDropdownItems : [],
										onChanged: (newValue) => selectedDropdownItem = newValue!,
										filterFn: (item, filter) => 
										getTranslated("${item}SceneName_text")!.toLowerCase().replaceAll(" ", "").contains(filter.toLowerCase()),
										itemAsString: (item) => "${getTranslated(item)!}SceneName_text",
										dropdownBuilder: (context, selectedItem) => Text
										(
											selectedDropdownItem != null ? getTranslated("${selectedDropdownItem!}SceneName_text")! : "", 
											style: TextStyle(color: getColor("text_primary"), fontSize: 18,),
										),
										decoratorProps: DropDownDecoratorProps
										(
											decoration: InputDecoration
											(
												labelText: getTranslated("scenesLabel_text"),
												labelStyle: TextStyle(color: getColor("text_secondary"), fontSize: 18,),
												filled: true,
												fillColor: getColor("foreground")
											)
										),
										popupProps: PopupProps.menu(
											emptyBuilder: (context, searchEntry) => const SizedBox(height: 0),
											itemBuilder:(context, item, isDisabled, isSelected) => SizedBox
											(
												height: 40, 
												child: Row
												(
													children: 
													[
														const SizedBox(width: 15,),
														Text
														(
															getTranslated("${item}SceneName_text")!, 
															style: TextStyle(color: getColor("text_primary"), fontSize: 18,),
														)
													]
												),
											),
											showSearchBox: true,
											searchDelay: const Duration(milliseconds: 300),
											menuProps: MenuProps(backgroundColor: getColor("foreground")),
											searchFieldProps: TextFieldProps
											(
												autofocus: true,
												cursorColor: getColor("text_primary"),
												style: TextStyle(color: getColor("text_primary")),
												decoration: InputDecoration
												( 
													filled: true,
													fillColor: getColor("background"),
													hintText: getTranslated("scenesSearchHint_text"), 
													hintStyle: TextStyle(color: getColor("text_secondary")),
													focusedBorder: OutlineInputBorder
													( 
														borderSide: BorderSide
														(
															color: getColor("text_primary")!
														), 
													)
												)
											),
											fit: FlexFit.loose
										),
									),
								)
							),
							const SizedBox(width: 10),
							ElevatedButton
							(
								style: ButtonStyle
								(
									backgroundColor: WidgetStateProperty.all(getColor("foreground")!), 
									fixedSize: WidgetStateProperty.all(const Size(110, 50)),
								),
								onPressed: ()
								{
									if (selectedDropdownItem == null) 
									{
										CherryToast.error
										(
											description: Text(getTranslated("nothingSelected_text")!, style: TextStyle(color: getColor("text_primary"))),
											backgroundColor: getColor("background")!,
											animationType:  AnimationType.fromBottom,
											toastPosition: Position.bottom,
											animationCurve: Curves.linearToEaseOut,
										).show(context);
									}
									else if (scenesGuessed.length == 5)
									{
										CherryToast.error
										(
											description: Text(getTranslated("noMoreGuessesToast_text")!, style: TextStyle(color: getColor("text_primary"))),
											backgroundColor: getColor("background")!,
											animationType:  AnimationType.fromBottom,
											toastPosition: Position.bottom,
											animationCurve: Curves.linearToEaseOut,
										).show(context);
									}
									else if (scenesGuessed.contains(todaysSceneIdentifier))
									{
										CherryToast.error
										(
											description: Text(getTranslated("alreadyGotItToast_text")!, style: TextStyle(color: getColor("text_primary"))),
											backgroundColor: getColor("background")!,
											animationType:  AnimationType.fromBottom,
											toastPosition: Position.bottom,
											animationCurve: Curves.linearToEaseOut,
										).show(context);
									}
									else
									{
										if (selectedDropdownItem == todaysSceneIdentifier)
										{
											CherryToast.success
											(
												description: Text(getTranslated("gotItToast_text")!, style: TextStyle(color: getColor("text_primary"))),
												backgroundColor: getColor("background")!,
												animationType:  AnimationType.fromBottom,
												toastPosition: Position.bottom,
												animationCurve: Curves.linearToEaseOut,
												toastDuration: const Duration(seconds: 6),
											).show(context);
										}
										scenesGuessed.add(selectedDropdownItem!);
										selectedDropdownItem = null;
										appLocalData.setCommonValue("sceneGuesserStoredGuesses", jsonEncode(scenesGuessed));

										setState(() {});
									}
								}, 
								child: Text(getTranslated("guessButton_text")!, style: TextStyle(color: getColor("text_primary"), fontSize: 15,))
							)
						],
					),
					const SizedBox(height: 10,),
					Text("${5-scenesGuessed.length} ${getTranslated("remainingGuesses_text")}", style: TextStyle(color: getColor("text_primary"), fontSize: 18,)),
					getScenesGuessedPropertiesDisplay().isNotEmpty ? JsonTable
					(
						getScenesGuessedPropertiesDisplay().reversed.toList(),
						tableHeaderBuilder: (header) => Row
						(
							children: 
							[
								Container
								(
									decoration: BoxDecoration
									(
										color: getColor("foreground")!,
										border: Border.all
										(
											color: getColor("text_primary")!
										)
									),
									width: 120,
									height: 30,
									child: Align
									(
										alignment: Alignment.center, 
										child: Text
										(
											getTranslated(header!)!, 
											style: TextStyle(color: getColor("text_primary"), fontSize: 14, fontWeight: FontWeight.bold)
										)
									)
								),
							],
						),
						tableCellBuilder: (value) => Row
						(
							children: 
							[
								Container
								(
									decoration: BoxDecoration
									(
										color: switch (value.split("+")[1])
										{
											"match" => Colors.green,
											"nomatch" => Colors.red,
											"up" || "down" => Colors.yellow.shade800,
											_ => Colors.transparent
										},
										border: Border.all
										(
											color: getColor("text_primary")!
										)
									),
									width: 120, 
									height: 45,
									child: Align
									(
										alignment: Alignment.center, 
										child: Text
										(
											value.split("+")[0] + (value.split("+")[1] == 'up' ? ' ⬆️' : value.split("+")[1] == 'down' ? ' ⬇️' : ''), 
											style: TextStyle(color: getColor("text_primary"), fontSize: 14), 
											textAlign: TextAlign.center,
										)
									)
								),
							],
						),
					) : const Center()
				]
			)
		);
	}
}