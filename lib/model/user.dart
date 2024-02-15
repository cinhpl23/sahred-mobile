enum Gender { male, female }

class User {
  String firstName;
  String lastName;
  int? age;
  double height;
  Gender gender;
  List<String> hobbies;
  String favoriteProgrammingLanguage;
  String secret;

  User({
    this.firstName = "",
    this.lastName = "",
    this.age,
    this.height = 150.0,
    this.gender = Gender.female,
    this.hobbies = const [],
    this.favoriteProgrammingLanguage = "",
    this.secret = ""
  });

  String getFullName() => "$firstName $lastName";

  String heightToString() => "${height.toInt().toString()} cm";

  String genderToString() => gender == Gender.female ? "Man" : "Female";

  String ageToString() => age != null ? "$age y/o" : "";

  String hobbiesToString() {
    if (hobbies.isEmpty) {
      return "";
    }

    String hobbyString = "";
    hobbyString += hobbies.join(", ");

    return hobbyString;
  }
}
