import 'package:pixieapp/pages/IntroductionPages/introduction_pages.dart';

class ClildDataModel {
  String name;
  Gender gender;
  List<String> favthings;
  DateTime dob;
  List<Lovedonces> lovedonce;
  ClildDataModel(
      {required this.name,
      required this.gender,
      required this.favthings,
      required this.dob,
      required this.lovedonce});
}

enum Gender {
  male,
  female,
  prefernottosay,
}

class Lovedonces {
  String relation;
  String name;
  Lovedonces({required this.relation, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relation': relation,
    };
  }

  factory Lovedonces.fromMap(Map<String, dynamic> map) {
    return Lovedonces(
      name: map['name'],
      relation: map['relation'],
    );
  }
}
