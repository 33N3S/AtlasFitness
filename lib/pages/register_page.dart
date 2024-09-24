import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/components/big_title.dart';
import 'package:atlas_fitness/components/my_activity_slider.dart';
import 'package:atlas_fitness/components/my_footer_illustrated.dart';
import 'package:atlas_fitness/components/my_options_field.dart';
import 'package:atlas_fitness/components/my_outline_button.dart';
import 'package:atlas_fitness/components/my_register_button.dart';
import 'package:atlas_fitness/components/my_register_radio.dart';
import 'package:atlas_fitness/components/my_register_text_field.dart';
import 'package:atlas_fitness/components/my_timeline_tile.dart';
import 'package:atlas_fitness/components/my_toggle.dart';
import 'package:atlas_fitness/helpers/displayDialogMessage.dart';
import 'package:atlas_fitness/helpers/verify_creds.dart';
import 'package:atlas_fitness/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController weightunitController = TextEditingController();
  final TextEditingController heightunitController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  bool nameAgeDone= false;
  bool weightHeightDone = false;
  bool goalsDone = false;
  bool mailPwDone = false;
  var  weightUnits = ["Kg","lbs"]; 
  var heightUnits = ["cm","ft"];
  var sexOptions = ["Male","Female"];
  String sexValue = "Male";
  double ratioValue =1.2;
  FitGoals goalValue = FitGoals.gainMuscle;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonState);
    ageController.addListener(_updateButtonState);
    weightController.addListener(_updateButtonState);
    heightController.addListener(_updateButtonState);
    sexController.addListener(_updateButtonState);
    mailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    weightunitController.addListener(_updateButtonState);
    heightunitController.addListener(_updateButtonState);


  }

  @override
  void dispose() {
    nameController.removeListener(_updateButtonState);
    ageController.removeListener(_updateButtonState);
    weightController.removeListener(_updateButtonState);
    heightController.removeListener(_updateButtonState);
    sexController.removeListener(_updateButtonState);
    mailController.removeListener(_updateButtonState);
    passwordController.removeListener(_updateButtonState);
    weightunitController.removeListener(_updateButtonState);
    heightunitController.removeListener(_updateButtonState);


    nameController.dispose();
    weightController.dispose();
    heightController.dispose();
    sexController.dispose();
    mailController.dispose();
    passwordController.dispose();
    ageController.dispose();

    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
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


  void _scrollToNextTile() {
    // Calculate the new position
    double targetOffset = _scrollController.offset + 400;

    // Make sure the target offset doesn't exceed the maximum scroll extent
    targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);

    // Animate to the target offset
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

void _scrollToPrevTile(){
  //calculate new position
  double targetOffset = _scrollController.offset - 400;

  //make sure we re within the max scroll extent
  targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);

  //animate to the tager offset
  _scrollController.animateTo(
    targetOffset, 
    duration: Duration(milliseconds: 400), 
    curve: Curves.easeInOut);

    

}

//register the user in the database
Future<void> _registerUser() async {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  //extract the weight in kg
  double weightInKg = weightunitController.text == "lbs"
    ? double.parse(weightController.text) * 0.453592
    : double.parse(weightController.text);

  // Extract feet and inches if the unit is 'ft'
  double heightInCm = heightunitController.text == "ft"
    ? (double.parse(heightController.text.split('.')[0]) * 30.48) + (double.parse(heightController.text.split('.')[1]) * 2.54)
    : double.parse(heightController.text);

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mailController.text,
      password: passwordController.text,
    );

    // Create Person object
    Person person = Person(
      name: nameController.text,
      age: int.parse(ageController.text),
      sex: sexValue,
      height: heightInCm,
      weight: weightInKg,
      ratio: ratioValue, 
      dailyCalNeed: 0, // This will be calculated later
      tarGetCalNeed: 0, // This will be calculated later
      fitGoal: goalValue, 
    );
    person.calculateNeeds(); // Calculate daily needs based on the given info

    // Save to Firestore
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.savePerson(person);

    //pop the loading circle
    Navigator.pop(context);

    //display the message
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));


  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayDialogMessage(e.code, context);

    setState(() {
      mailPwDone = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: 
          Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:50),
                    child:               
                    SvgPicture.asset(
                      'lib/images/logos/atlas_logo.svg',
                      height: 100,
                        color: Theme.of(context).colorScheme.primary,
                    )
                  ),

                  const BigTitle(text: "let's Take the first steps!"),
                  
                  MyTimelineTile(isFirst: true, isLast: false, isPast: false, icon: Icons.face,isDone: nameAgeDone,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("What can we call you?", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                      MyRegisterTextField(controller: nameController, hintText: "Name", obscureText: false,enabled: !nameAgeDone,isNumeric: false,),
            
                      Text("How old are you?", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                      MyRegisterTextField(controller: ageController, hintText: "Age", obscureText: false,enabled: !nameAgeDone,isNumeric: true,),
            
                      MyRegisterRadio(options: sexOptions, groupValue: sexValue,enabled: !nameAgeDone, onChanged: (String? newValue) {
                        setState(() {
                          sexValue = newValue!;
                          sexController.text = sexValue;
                        });
                      }),
                    
                      Padding(
                        padding: const EdgeInsets.only(left:130.0),
                        child: MyRegisterButton(text: "Next",                    
                        enabled: nameController.text.isNotEmpty && ageController.text.isNotEmpty && int.parse(ageController.text) >= 18 && !nameAgeDone,
                        onTap: nameController.text.isNotEmpty && ageController.text.isNotEmpty
                        ? () {
                            setState(() {
                              nameAgeDone = true;
                            });
                            _scrollToNextTile();
                          }
                        : null,
                        ),
                      )
                    ],
                  )
                  ),

                  MyTimelineTile(isFirst: false, isLast: false, isPast: !nameAgeDone, icon: Icons.straighten_rounded ,isDone: weightHeightDone,content:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("What is your weight?", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                        MyOptionsField(unitController: weightunitController, hintText: "Weight", enabled: !weightHeightDone , valueController: weightController,options: weightUnits,),
            
                        Text("What is your Height?", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                        MyOptionsField(unitController: heightunitController, hintText: heightunitController.text == "ft" ? "Ex: 5.10" : "Ex: 173", enabled: !weightHeightDone, valueController: heightController,options: heightUnits,),
            
                        Padding(
                          padding: const EdgeInsets.only(top:12),
                          child: Row(
                            children: [
                          
                          Expanded(
                            child: MyRegisterButton(text: "Back", enabled: !weightHeightDone, 
                            onTap: (){
                                setState(() {
                                  nameAgeDone = false;
                                  weightHeightDone = false;
                                });
                                _scrollToPrevTile();
                            } ),
                          ),
                          
                          const SizedBox(width:10),
                          
                          Expanded(
                            child: MyRegisterButton(text: "Next",                    
                            enabled: weightController.text.isNotEmpty && isHeightValid(heightController.text, heightunitController.text) && !weightHeightDone,
                            onTap: weightController.text.isNotEmpty && isHeightValid(heightController.text, heightunitController.text)
                            ? () {
                                setState(() {
                                  weightHeightDone = true;
                                });
                                _scrollToNextTile();
                              }
                            : null,
                            ),
                          ),
                            ],
                          ),
                        )
                      ],
                    )
                  ),


                  MyTimelineTile(isFirst: false, isLast: false, isPast: !weightHeightDone, icon: Icons.flag, isDone: goalsDone,
                  content:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How active are you usually?",
                      style: TextStyle(color:Theme.of(context).colorScheme.surface),
                    ),
                    MyActivitySlider(initialRatio: 1,enabled: !goalsDone,onRatioChanged: (ratio)=>{
                      setState(() {
                          ratioValue = ratio;
                      })
                    },),
                    const SizedBox(height: 15),
                    Text(
                      "What is Your Fitness Goal?",
                      style: TextStyle(color:Theme.of(context).colorScheme.surface),
                    ),

                    MyToggle(enabled: !goalsDone,onGoalChanged: (goal)=>getGoalFromIndex(goal)),

                    Padding(
                          padding: const EdgeInsets.only(top:12),
                          child: Row(
                            children: [
                          
                          Expanded(
                            child: MyRegisterButton(text: "Back", enabled: !goalsDone, 
                            onTap: (){
                                setState(() {
                                  goalsDone = false;
                                  weightHeightDone = false;
                                });
                                _scrollToPrevTile();
                            } ),
                          ),
                          
                          const SizedBox(width:10),
                          
                          Expanded(
                            child: MyRegisterButton(text: "Next",                    
                            enabled: !goalsDone,
                            onTap: !goalsDone
                            ? () {
                                setState(() {
                                  goalsDone = true;
                                });
                                _scrollToNextTile();
                              }
                            : null,
                            ),
                          ),
                            ],
                          ),
                        )
                      ],
                      ),
                    ),

                  MyTimelineTile(isFirst: false, isLast: true, isPast: !goalsDone, icon: Icons.mail_rounded,isDone:mailPwDone,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Where can we reach you?", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                      MyRegisterTextField(controller: mailController, hintText: "Email", obscureText: false,enabled: goalsDone&& !mailPwDone,isNumeric: false,),
            
                      Text("Pick a trusty password", style: TextStyle(color:Theme.of(context).colorScheme.surface),),
                      Column(
                        children: [
                          MyRegisterTextField(controller: passwordController, hintText: "Password", obscureText: true,enabled: goalsDone&& !mailPwDone,isNumeric: false,),
                          Text("Must contain a capital, a digit and at least 8 characters",style: TextStyle(fontSize: 11,color: Theme.of(context).colorScheme.surface),)

                        ],
                      ),
            
                        Padding(
                          padding: const EdgeInsets.only(top:12),
                          child: Row(
                            children: [
                          
                          Expanded(
                            child: MyRegisterButton(text: "Back", enabled: !mailPwDone, 
                            onTap: (){
                                setState(() {
                                  mailPwDone = false;
                                  goalsDone = false;
                                });
                                _scrollToPrevTile();
                            } ),
                          ),
                          
                          const SizedBox(width:10),
                          
                          Expanded(
                            child: MyRegisterButton(text: "Next",                    
                            enabled: isValidEmail(mailController.text) && isValidPassword(passwordController.text) && !mailPwDone ,
                            onTap: isValidEmail(mailController.text) && isValidPassword(passwordController.text) && !mailPwDone
                            ? () {
                                setState(() {
                                  mailPwDone = true;
                                });
                              }
                            : null,
                            ),
                          ),
                            
                            ],
                          ),
                        )
                    ],
                  ) 
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 30),
                    child: MyOutlineButton(text: "Create Account !", enabled: mailPwDone, onTap: (){
                      _registerUser();
                    })
                  ),
                  const MyFooterIllustrated()              
                ],
                
              ),
            ),
    );
  }
  
  
}
