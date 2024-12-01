import 'package:fears_to_know/display_theme_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:fears_to_know/translation_manager/main.dart';
import 'package:fears_to_know/stored_widgets/main.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class HomePage extends StatefulWidget 
{
	const HomePage({super.key});
	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
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
				child: getDefaultAppBar
				( 
					context,
					_setState
				)
			),
			body: Center
			(
				child: Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children: 
					[
						ElevatedButton
						(
							style: ButtonStyle
							(
								backgroundColor: WidgetStateProperty.all(getColor("foreground")!), 
								fixedSize: WidgetStateProperty.all(const Size(360, 50)),
							),
							onPressed: ()
							{
								Navigator.pushNamed(context, '/scene_guesser');
							}, 
							child: Row
							(
								children: 
								[
									Icon(Icons.movie, color: getColor("text_primary"),),
									const SizedBox(width: 20),
									Text(getTranslated("sceneGuesserPageButton_text")!, style: TextStyle(color: getColor("text_primary"), fontSize: 20,))
								],
							)
						),
						const SizedBox(height: 10),
						ElevatedButton
						(
							style: ButtonStyle
							(
								backgroundColor: WidgetStateProperty.all(getColor("foreground")!), 
								fixedSize: WidgetStateProperty.all(const Size(360, 50)),
							),
							onPressed: ()
							{
								CherryToast.warning
								(
									description: Text(getTranslated("comingSoonToast_text")!, style: TextStyle(color: getColor("text_primary"))),
									backgroundColor: getColor("background")!,
									animationType:  AnimationType.fromBottom,
									toastPosition: Position.bottom,
									animationCurve: Curves.easeOutBack,
								).show(context);
							}, 
							child: Row
							(
								children: 
								[
									Icon(Icons.person, color: getColor("text_primary")),
									const SizedBox(width: 20),
									Text(getTranslated("characterGuesserPageButton_text")!, style: TextStyle(color: getColor("text_primary"), fontSize: 20))
								],
							)
						),
					],
				),
			)
		);
	}
}