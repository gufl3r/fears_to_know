List<String> scenesDropdownItems =
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

List<Map<String, String>> scenesDropdownProperties =
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
      "jumpscareCount": "",
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

Map<String, String> getSceneProperties(identifier)
{
	return scenesDropdownProperties.firstWhere((scene) => scene["identifier"] == identifier);
}