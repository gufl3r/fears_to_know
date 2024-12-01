import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:flutter/material.dart';

Map<String, Color> colorMap = 
{
	"light_background": Colors.blueGrey.shade50,
	"dark_background": Colors.blueGrey.shade700,

	"light_foreground": Colors.blueGrey.shade100,
	"dark_foreground": Colors.blueGrey.shade600,
	
	"light_text_primary": Colors.blueGrey.shade700,
	"dark_text_primary": Colors.blueGrey.shade50,

  "light_text_secondary": Colors.blueGrey.shade400,
	"dark_text_secondary": Colors.blueGrey.shade300,

  "light_selected": Colors.blueGrey.shade200,
	"dark_selected": Colors.blueGrey.shade500,
};

Color? getColor(String identifier) {
	String theme = appLocalData.getValue("settings", "displayTheme")!;

	if (colorMap["${theme}_$identifier"] == null)
	{
		return Colors.black;
	}
	return colorMap["${theme}_$identifier"];
}