class Profile {
  final String id;
  final String name;
  final Gender gender;
  int age;
  List<Location> locations;
  bool accountType; //true = teacher, false = student
  //datetime.now()

  Profile({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.locations,
    required this.accountType,
  });
}

enum Gender {
  male(genderString: '남'),
  female(genderString: '여');

  const Gender({required this.genderString});
  final String genderString;
}

enum Location {
  seoul(locationString: '서울'),
  gyeonggi(locationString: '경기');

  const Location({required this.locationString});
  final String locationString;
}
