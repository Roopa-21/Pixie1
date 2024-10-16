class StoryModal {
  String event;
  String age;
  String topic;
  String child_name;
  String gender;
  String relation;
  String relative_name;
  String genre;
  String lessons;
  String length;
  Language language;

  StoryModal(
      {required this.age,
      required this.child_name,
      required this.event,
      required this.gender,
      required this.genre,
      required this.language,
      required this.length,
      required this.lessons,
      required this.relation,
      required this.relative_name,
      required this.topic});
}

enum Language { English, Hindi, notselected }

StoryModal finalstorydatas = StoryModal(
    age: "age",
    child_name: "Aju",
    event: "Bedtime",
    gender: "gender",
    genre: "Funny",
    language: Language.English,
    length: "5min",
    lessons: "",
    relation: "dad",
    relative_name: "jayan",
    topic: "Bedtime");
