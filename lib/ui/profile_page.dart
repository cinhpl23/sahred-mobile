import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';
import '../widgets/section_title_widget.dart';
import '../widgets/text_info_icon_widget.dart';
import '../widgets/text_info_widget.dart';
import '../widgets/text_title_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  File? file;
  User user = User();
  ImagePicker imagePicker = ImagePicker();

  late TextEditingController firstNameEditingController;
  late TextEditingController lastNameEditingController;
  late TextEditingController secretEditingController;

  int? selectedAge;
  bool isSecretRevealed = false;
  
  double maxHeight = 250.0;
  double minHeight = 130.0;
  double? selectedHeight;

  int? genderValue;

  List<String> genderList = [
    "Man",
    "Female"
  ];

  String? programmingLanguageValue;
  List<String> programmingLanguageList = [
    "Dart",
    "Swift",
    "Kotlin"
  ];

  Map<String, bool> hobbyList = {
    "Travel": false,
    "Ride": false,
    "Chill": false,
    "Work": false
  };

  @override
  void initState() {
    super.initState();
    firstNameEditingController = TextEditingController();
    lastNameEditingController = TextEditingController();
    secretEditingController = TextEditingController();

    firstNameEditingController.text = user.firstName;
    lastNameEditingController.text = user.lastName;
    secretEditingController.text = user.secret;
    selectedAge = user.age;
    selectedHeight = user.height;
    programmingLanguageValue = user.favoriteProgrammingLanguage;
  }

  @override
  void dispose() {
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    secretEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const TextTitleWidget(title: "user page")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          (file != null)
                              ? imagePickerAvatar()
                              : defaultAvatar(),
                          TextInfoWidget(information: user.getFullName()),
                          const Spacer(),
                          TextInfoWidget(information: user.ageToString()),
                        ],
                      ),
                      TextInfoIconWidget(iconData: Icons.male, information: user.genderToString()),
                      TextInfoIconWidget(iconData: Icons.height, information: user.heightToString()),
                      TextInfoIconWidget(iconData: Icons.sports_basketball, information: user.hobbiesToString()),
                      TextInfoIconWidget(iconData: Icons.code, information: user.favoriteProgrammingLanguage),
                      Visibility(
                          visible: isSecretRevealed,
                          child: TextInfoIconWidget(iconData: Icons.fingerprint, information: user.secret)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: imagePickerElevatedButton(iconData: Icons.browse_gallery, imageSource: ImageSource.gallery),
                            ),
                            imagePickerElevatedButton(iconData: Icons.camera_alt, imageSource: ImageSource.camera),
                            const Spacer(),
                            secretElevatedButton(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              customTextField(controller: firstNameEditingController, hint: "First name", edgeInsets: const EdgeInsets.all(12.0)),
              customTextField(controller: lastNameEditingController, hint: "Last name", edgeInsets: const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        "Select your age: ",
                        style: TextStyle(fontSize: 18)
                    ),
                    ageDropdownMenu(),
                  ],
                ),
              ),
              customTextField(controller: secretEditingController, hint: "Tell me a secret 🤫", isSecret: true, edgeInsets: const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0)),
              SectionTitleWidget(width: width, label: "I'm ..."),
              genderRadioListTile(),
              SectionTitleWidget(width: width, label: "I measure ..."),
              Slider(
                  min: minHeight,
                  max: maxHeight,
                  value: user.height,
                  onChanged: ((value) => setState(() {
                    user.height = value;
                  }))
              ),
              SectionTitleWidget(width: width, label: "I like to ..."),
              hobbyCheckBoxList(),
              SectionTitleWidget(width: width, label: "Coding is better with ..."),
              codeRadioListTile()
            ],
          ),
        ),
      ),
    );
  }

  TextInfoWidget revealSecret() {
    return TextInfoWidget(information: secretEditingController.text);
  }

  Row genderRadioListTile() {
    List<Widget> radioList = [];

    for (int i = 0; i < genderList.length; i++) {
      Widget radio = Expanded(
        child: RadioListTile(
            title: Text(genderList[i]),
            value: i,
            groupValue: genderValue,
            onChanged: ((value) {
              setState(() {
                genderValue = value!;
                value == 0 ? user.gender = Gender.male : user.gender = Gender.female;
              });
            })),
      );
      radioList.add(radio);
    }

    return Row(children: radioList);
  }

  Row codeRadioListTile() {
    List<Widget> radioList = [];

    for (int i = 0; i < programmingLanguageList.length; i++) {
      Widget radio = Expanded(
        child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(programmingLanguageList[i]),
            value: programmingLanguageList[i],
            groupValue: programmingLanguageValue,
            onChanged: ((value) {
              setState(() {
                programmingLanguageValue = value;
                user.favoriteProgrammingLanguage = programmingLanguageValue!;
              });
            })
        ),
      );

      radioList.add(radio);
    }

    return Row(children: radioList);
  }

  Column hobbyCheckBoxList() {
    List<Widget> hobbyWidgetList = [];

    hobbyList.forEach((label, value) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CheckboxListTile(
                title: Text(label),
                value: value,
                onChanged: ((value) => setState(() {
                  hobbyList[label] = value ?? false;
                  List<String> formattedHobbyList = [];

                  hobbyList.forEach((label, value) {
                    if (value) {
                      formattedHobbyList.add(label);
                    }
                  });

                  user.hobbies = formattedHobbyList;
                }))
            ),
          )
        ],
      );

      hobbyWidgetList.add(row);
    });

    return Column(children: hobbyWidgetList);
  }

  updateUser() {
    setState(() {
      user = User(
          firstName: firstNameEditingController.text != user.firstName ? firstNameEditingController.text : user.firstName,
          lastName: lastNameEditingController.text != user.lastName ? lastNameEditingController.text : user.lastName,
          secret:  secretEditingController.text != user.secret ? secretEditingController.text : user.secret,
          age: user.age,
          gender: user.gender,
          height: user.height,
          hobbies: user.hobbies,
          favoriteProgrammingLanguage: user.favoriteProgrammingLanguage
      );
    });
  }

  Widget customTextField({
    required EdgeInsets edgeInsets,
    required TextEditingController controller,
    bool isSecret = false,
    String? hint
  }) {
    return Padding(
      padding: edgeInsets,
      child: TextField(
        controller: controller,
        obscureText: isSecret,
        decoration: InputDecoration(hintText: hint),
        onSubmitted: ((value) => setState(() {
          updateUser();
        })),
      ),
    );
  }

  Widget ageDropdownMenu() {
    return DropdownButton(
      value: selectedAge,
      items: List.generate(30, (index) => index).map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (int? newValue){
        setState(() {
          selectedAge = newValue;
          user.age = newValue;
        });
      },
    );
  }

  Future pickImage (ImageSource imageSource) async {
    XFile? xFile = await imagePicker.pickImage(source: imageSource);

    if (xFile != null) {
      setState(() {
        file = File(xFile.path);
      });
    }
  }

  Widget imagePickerAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              radius: 28,
              backgroundImage: Image.file(
                  file!,
                  fit: BoxFit.cover
              ).image
          )
      ),
    );
  }

  Widget defaultAvatar() {
    return const Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              radius: 28,
              foregroundColor: Colors.blue
          )
      ),
    );
  }

  Widget imagePickerElevatedButton({required IconData iconData, required ImageSource imageSource}) {
    return ElevatedButton(
        onPressed: (() => setState(() {
          pickImage(imageSource);
        })),
        child: Icon(iconData)
    );
  }

  Widget secretElevatedButton() {
    return ElevatedButton(
        onPressed: (() => setState(() {
          isSecretRevealed = !isSecretRevealed;
        })),
        child: isSecretRevealed
            ? const Text("Hide my secret!")
            : const Text("Reveal my secret!")
    );
  }
}
