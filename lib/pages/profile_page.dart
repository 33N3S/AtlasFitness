import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/profile_option_field.dart';
import 'package:atlas_fitness/components/profile_text_field.dart';
import 'package:atlas_fitness/components/profile_toggle.dart';
import 'package:atlas_fitness/helpers/displayDialogMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Person?> userFuture;
  late FitGoals goalValue ;
  bool isEditMode = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController= TextEditingController();
  TextEditingController heightUnitController= TextEditingController();
  TextEditingController weightController= TextEditingController();
  TextEditingController weightUnitController= TextEditingController();

  var  weightUnits = ["Kg","lbs"]; 
  var heightUnits = ["cm","ft"];

Future<void> _updateUser(Person user) async {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  // Convert weight and height as needed
  double weightInKg = weightUnitController.text == "lbs"
    ? double.parse(weightController.text) * 0.453592
    : double.parse(weightController.text);

  double heightInCm = heightUnitController.text == "ft"
    ? (double.parse(heightController.text.split('.')[0]) * 30.48) + (double.parse(heightController.text.split('.')[1]) * 2.54)
    : double.parse(heightController.text);

  // Create a map of the updated fields
  Map<String, dynamic> updatedData = {
    'name': nameController.text,
    'age': int.parse(ageController.text),
    'height': heightInCm,
    'weight': weightInKg,
    'fitGoal': goalValue.toString().split('.').last,
  };

  // Optional: If you want to recalculate the calorie needs
  Person tempPerson = Person(
    name: nameController.text,
    age: int.parse(ageController.text),
    sex: user.sex,
    height: heightInCm,
    weight: weightInKg,
    ratio: user.ratio,
    dailyCalNeed: 0,
    tarGetCalNeed: 0,
    fitGoal: goalValue,
  );
  tempPerson.calculateNeeds();

  updatedData['dailyCalNeed'] = tempPerson.dailyCalNeed;
  updatedData['tarGetCalNeed'] = tempPerson.tarGetCalNeed;
  updatedData['dailyNeeds'] = tempPerson.dailyNeeds.toMap(); // Adding dailyNeeds

  try {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.updatePerson(updatedData);
    
    setState(() {
      isEditMode = false;
    });
    //pop the loading circle
    Navigator.pop(context);
    
    setState(() {
      userFuture  = _getCurrentUser();
    });

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Profile successfully updated!',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: Duration(seconds: 2),
    ),
  );
    

  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayDialogMessage(e.code, context);
  }
}


  Future<Person?> _getCurrentUser() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService.getPerson();
  }

  @override
  void initState() {
    super.initState();
    userFuture = _getCurrentUser();
    weightUnitController.addListener(fieldListener);
    heightUnitController.addListener(fieldListener);
  }

  @override
  void dispose() {
    weightUnitController.removeListener(fieldListener);
    heightUnitController.removeListener(fieldListener);

    super.dispose();
  }

  void fieldListener(){
    setState(() { });
  }

    getGoalFromIndex(index) {
    if(index == 0){
      setState(() {
        goalValue = FitGoals.gainMuscle;
      });
    }else{
      setState(() {
        goalValue = FitGoals.loseWeight;
      });
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userFuture.then((user) {
      if (user != null) {
        setState(() {
          goalValue = user.fitGoal;
          weightUnitController.text = weightUnits[0];
          heightUnitController.text = heightUnits[0];
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found'));
        } else {
          var user = snapshot.data!;
          return Scaffold(
            floatingActionButton: const MyFab(),
            bottomNavigationBar: const BottomBar(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      'lib/images/logos/atlas_logo.svg',
                      height: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    //Center(child: HomePageTitle(text: "${user.name}'s profile")),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.secondary
                            ),
                            child: IconButton(

                              onPressed: () {
                                setState(() { isEditMode?
                                  _updateUser(user):
                                  isEditMode = !isEditMode;
                                });
                              },
                              icon: Icon(
                                isEditMode ? Icons.check_rounded : Icons.edit_rounded,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isEditMode
                              ? ProfileTextField(
                                    enabled: true,
                                    isNumeric: false,
                                    controller: nameController,
                                    hintText: "Name",
                                    obscureText: false,
                                    placeholder: user.name,
                                  )
                              : _buildInfoRow("Name", user.name),
                          isEditMode
                              ? ProfileTextField(
                                    enabled: true,
                                    isNumeric: true,
                                    controller: ageController,
                                    hintText: "Age",
                                    obscureText: false,
                                    placeholder: user.age.toString(),
                                  )
                              
                              : _buildInfoRow("Age", "${user.age}"),
                          isEditMode?
                          SizedBox(): _buildInfoRow("Sex", user.sex),
                          isEditMode
                              ? Padding(
                                padding: const EdgeInsets.all(0),
                                child: ProfileOptionsField(
                                  unitController: heightUnitController, 
                                  hintText: "height", 
                                  enabled: true, 
                                  valueController: heightController,
                                  options: heightUnits,
                                  placeholder: user.height.toString(),),
                              )
                              : _buildInfoRow("Height", "${user.height} cm"),
                          isEditMode
                              ?  ProfileOptionsField(
                                  unitController: weightUnitController, 
                                  hintText: "Weight", 
                                  enabled: true, 
                                  valueController: weightController,
                                  options: weightUnits,
                                  placeholder: user.weight.toString(),)
                              
                              : _buildInfoRow("Weight", "${user.weight} kg"),
                          isEditMode?
                            ProfileToggle(enabled: true, onGoalChanged: (index){getGoalFromIndex(index);},selectedGoal: user.fitGoal)
                            :_buildInfoRow("Goal", user.fitGoal == FitGoals.gainMuscle ? "Gain Muscle" : "Lose Weight")
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Daily Nutritional Needs",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Column(children: [
                          _buildInfoRow("Calories", "${user.dailyNeeds.calories.toStringAsFixed(2)} kcal"),
                          _buildInfoRow("Protein", "${user.dailyNeeds.protein.toStringAsFixed(2)} g"),
                          _buildInfoRow("Carbs", "${user.dailyNeeds.carbs.toStringAsFixed(2)} g"),
                          _buildInfoRow("Fats", "${user.dailyNeeds.fats.toStringAsFixed(2)} g"),
                      ],),
                    ),
                     const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

}
