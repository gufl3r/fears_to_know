import 'package:flutter/material.dart';
import 'package:fears_to_know/translation_manager/main.dart';
import 'package:fears_to_know/local_data_manager/main.dart';
import 'package:fears_to_know/display_theme_manager/main.dart';
import 'package:country_flags/country_flags.dart';

AppBar getDefaultAppBar(BuildContext context, VoidCallback externalSetState)
{
  return AppBar
  (
    toolbarHeight: 80,
    leadingWidth: 80,
    leading: Row
    (
      children: [
        IconButton(
          onPressed: () async {
            if (appLocalData.getValue("settings", "displayTheme") == "light") 
            {
              await appLocalData.setValue("settings", "displayTheme", "dark");
            }
            else 
            {
              await appLocalData.setValue("settings", "displayTheme", "light");
            }
            externalSetState(); 
          },
          icon: Icon(
            Icons.lightbulb_outline,
            color: getColor("text_primary"),
          ),
          tooltip: getTranslated("switchDisplayThemeTooltip_text"),
        ),
        IconButton(
          onPressed: () async 
          {
            switch (appLocalData.getValue("settings", "language")) 
            {
              case "English-US":
                appLocalData.setValue("settings", "language", "Português-BR");
                break;
              case "Português-BR":
                appLocalData.setValue("settings", "language", "English-US");
                break;
            }
            externalSetState(); 
          },
          icon: CountryFlag.fromCountryCode(
            appLocalData.getValue("settings", "language")!
                .substring(appLocalData.getValue("settings", "language")!.length - 2),
            shape: const Circle(),
            width: 24,
          ),
          tooltip: getTranslated("changeLanguageTooltip_text"),
        ),
      ],
    ),
    title: MouseRegion
    (
      cursor: SystemMouseCursors.click,
      child: GestureDetector
      (
        child: Image.network
        (
          "https://raw.githubusercontent.com/gufl3r/fears_to_know/refs/heads/main/assets/logo.png",
          width: 200
        ), 
        onTap: () => Navigator.pushNamed(context, '/home')
      )
    ),
    centerTitle: true,
    backgroundColor: getColor("foreground"),
  );
}