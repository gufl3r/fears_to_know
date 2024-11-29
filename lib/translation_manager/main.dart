import 'package:fears_to_know/local_data_manager/main.dart';

Map<String, String> translationMap = 
{
	//Home page
	"ENUS_homePageTitle_text": "Fears to know - Home",
	"PTBR_homePageTitle_text": "Fears to know - Início",

	"ENUS_sceneGuesserPageButton_text": "Guess the scene",
	"PTBR_sceneGuesserPageButton_text": "Palpite a cena",

	"ENUS_characterGuesserPageButton_text": "Guess the character",
	"PTBR_characterGuesserPageButton_text": "Palpite o personagem",

	"ENUS_changeLanguageTooltip_text": "Click to change language",
	"PTBR_changeLanguageTooltip_text": "Clique para mudar a linguagem",

	"ENUS_switchDisplayThemeTooltip_text": "Click to switch themes",
	"PTBR_switchDisplayThemeTooltip_text": "Clique para alternar entre os temas",

	"ENUS_comingSoonToast_text": "Coming soon...",
	"PTBR_comingSoonToast_text": "Em breve...",

	//Scene guesser page
	"ENUS_sceneGuesserPageTitle_text": "Fears to know - Guess the scene",
	"PTBR_sceneGuesserPageTitle_text": "Fears to know - Palpite a cena",

	"ENUS_newGameEp5SceneName_text": "New game (ep. 5)",
	"PTBR_newGameEp5SceneName_text": "Novo jogo (ep. 5)",

	"ENUS_moesPizzaSceneName_text": "Moe's Pizza",
	"PTBR_moesPizzaSceneName_text": "Pizza do Moe",

	"ENUS_welcomeToWoodburySceneName_text": "Welcome to Woodbury",
	"PTBR_welcomeToWoodburySceneName_text": "Bem vindo a Woodbury",

	"ENUS_fishingSceneName_text": "Fishing",
	"PTBR_fishingSceneName_text": "Pescando",

	"ENUS_boardGameSceneName_text": "Board game",
	"PTBR_boardGameSceneName_text": "Jogo de tabuleiro",

	"ENUS_hideNSeekSceneName_text": "Hide & seek",
	"PTBR_hideNSeekSceneName_text": "Pique-esconde",

	"ENUS_someonesAtTheDoorSceneName_text": "Someone's at the door",
	"PTBR_someonesAtTheDoorSceneName_text": "Alguém na porta",

	"ENUS_rickSceneName_text": "Rick",
	"PTBR_rickSceneName_text": "Rick",

	"ENUS_hidingInBasementSceneName_text": "Hiding in basement",
	"PTBR_hidingInBasementSceneName_text": "Escondendo-se no porão",

	"ENUS_scenesSearchHint_text": "Search scenes",
	"PTBR_scenesSearchHint_text": "Buscar cenas",

	"ENUS_sceneNameColumn_text": "Scene",
	"PTBR_sceneNameColumn_text": "Cena",
	
	"ENUS_episodeNameColumn_text": "Episode",
	"PTBR_episodeNameColumn_text": "Episódio",

	"ENUS_progressColumn_text": "Progress",
	"PTBR_progressColumn_text": "Progresso",

	"ENUS_jumpscareCountColumn_text": "Jumpscares",
	"PTBR_jumpscareCountColumn_text": "Sustos",

	"ENUS_peopleCountColumn_text": "People",
	"PTBR_peopleCountColumn_text": "Pessoas",

	"ENUS_feelingColumn_text": "Feeling",
	"PTBR_feelingColumn_text": "Sentimento",

	"ENUS_woodburyGetawayEpisodeName_text": "Woodbury Getaway",
	"PTBR_woodburyGetawayEpisodeName_text": "Woodbury Getaway",

	"ENUS_neutralSceneFeeling_text": "Neutral",
	"PTBR_neutralSceneFeeling_text": "Neutro",

	"ENUS_weirdSceneFeeling_text": "Weird",
	"PTBR_weirdSceneFeeling_text": "Estranho",

	"ENUS_calmSceneFeeling_text": "Calm",
	"PTBR_calmSceneFeeling_text": "Calmo",

	"ENUS_funSceneFeeling_text": "Fun",
	"PTBR_funSceneFeeling_text": "Divertido",

	"ENUS_fearSceneFeeling_text": "Fear",
	"PTBR_fearSceneFeeling_text": "Medo",

	"ENUS_despairSceneFeeling_text": "Despair",
	"PTBR_despairSceneFeeling_text": "Desespero",

	"ENUS_scenesLabel_text": "Scenes...",
	"PTBR_scenesLabel_text": "Cenas...",

	//Not found page
	"ENUS_notFoundPageTitle_text": "Fears to know - 404",
	"PTBR_notFoundPageTitle_text": "Fears to know - 404",

	"ENUS_notFoundWarning_text": "Oops... The page you are trying to access was not found.",
	"PTBR_notFoundWarning_text": "Oops... A página que está tentando acessar não foi encontrada.",

	"ENUS_backToHomePageButton_text": "Home page",
	"PTBR_backToHomePageButton_text": "Página inicial",

	//Shared
	"ENUS_guessButton_text": "Guess",
	"PTBR_guessButton_text": "Palpitar",

	"ENUS_nothingSelected_text": "You need to select an option",
	"PTBR_nothingSelected_text": "Você precisa selecionar uma opção",

	"ENUS_noMoreGuessesToast_text": "You have no more guesses",
	"PTBR_noMoreGuessesToast_text": "Você não tem mais palpites",

	"ENUS_remainingGuesses_text": "guesses remaining",
	"PTBR_remainingGuesses_text": "palpites restantes",

	"ENUS_alreadyGotItToast_text": "You already got it!",
	"PTBR_alreadyGotItToast_text": "Você já acertou!",

	"ENUS_gotItToast_text": "You got it! Nice!",
	"PTBR_gotItToast_text": "Acertou! Boa!",
};

String? getTranslated(String identifier) {
	String language = "";
	switch (appLocalData.getSettingsValue("language"))
	{
		case "English-US":
			language = "ENUS";
			break;
		case "Português-BR":
			language = "PTBR";
			break;
		default:
			language = "WTF";
			break;
	}
	if (translationMap["${language}_$identifier"] == null)
	{
		return "${language}_$identifier";
	}
	return translationMap["${language}_$identifier"];
}