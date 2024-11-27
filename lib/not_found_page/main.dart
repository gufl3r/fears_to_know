import 'package:fears_to_know/stored_widgets/main.dart';
import 'package:fears_to_know/display_theme_manager/main.dart';
import 'package:fears_to_know/translation_manager/main.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget
{
	const NotFoundPage({super.key});
	@override
	State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> 
{
	void _externalSetState() 
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
				externalSetState: _externalSetState,
			)
		),
			body: Center
			(
				child: Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children: 
					[
						Text(getTranslated("notFoundWarning_text")!, style: TextStyle(color: getColor("text_primary"), fontSize: 18,)),
						const SizedBox(height: 20,),
						ElevatedButton
						(
							style: ButtonStyle
							(
								backgroundColor: WidgetStateProperty.all(getColor("foreground")!), 
								fixedSize: WidgetStateProperty.all(const Size(290, 50)),
							),
							onPressed: ()
							{
								Navigator.pushNamed(context, '/home');
							}, 
							child: Text(getTranslated("backToHomePageButton_text")!, style: TextStyle(color: getColor("text_primary"), fontSize: 18,))
						),
					]
				)
			)
		);
	}
}