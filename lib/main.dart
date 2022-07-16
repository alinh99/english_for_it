import 'package:flutter/material.dart';
// import 'package:flutter_eft/Screens/lessons/models/lesson.dart';
// import 'package:flutter_eft/Screens/lessons/models/lesson_db.dart';
import 'package:flutter_eft/Screens/models/users.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/db_connect.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/question_model.dart';
import 'package:flutter_eft/Screens/splash/splash_screen.dart';
import 'package:flutter_eft/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Screens/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var lessonDB = LessonDB();
  // lessonDB.addLesson(
  //   Lesson(
  //     id: '1',
  //     title: 'Now listen to the recordings again and note the actual uses described.',
  //     question:
  //         'What does primary school teacher actually use for?',
  //     // question: [
  //     //   'How does the story-telling program encourage children to work together?',
  //     //   'In what way is the children\'s reaction to this program different from other uses they make of computers?',
  //     //   'What is the OU student studying?',
  //     //   'What opportunity has she to meet other students?',
  //     //   'What can you do with Pets 3?',
  //     //   'What does Louise do with clipart?',
  //     //   'How did the artist display work to dealers in the past?',
  //     //   'What is the difficulty in selling through a website?'
  //     // ],
  //     answer: {
  //       'group story-telling':
  //           true
  //     },
      
  //     // answer: {
  //     //   [
  //     //     'the more children involved, the more interactive the program becomes',
  //     //     'the computer doesn\'t get in the way of learning, it\'s simply a tool',
  //     //     'maths',
  //     //     'face to face at tutorials, through help group online',
  //     //     'adopt a pet, name it, feed it, take its picture',
  //     //     'makes cards for her friends',
  //     //     'using slides',
  //     //     'getting people to visit your site'
  //     //   ]: true,
  //     // },
  //     subject: 'listening',
  //     // questionTitleTable: 'User',
  //     // answerTitleTable: 'Actual uses',
  //     // questionTable: 'primary school teacher',
  //     // answerTable: {'group story-telling': true},
  //     // questionTable: [
  //     //   'primary school teacher',
  //     //   'Open University student',
  //     //   'girl {Louise), aged 6',
  //     //   'artist'
  //     // ],
  //     // answerTable: {
  //     //   [
  //     //     'group story-telling',
  //     //     'write assignments, email tutor, chat with other students',
  //     //     'makes cards, plays games',
  //     //     'produce CD of paintings for dealers'
  //     //   ]: true,
  //     //   ['']: false
  //     // }),
  //   ),
    
  // );
  //   lessonDB.addLesson(
  //   Lesson(
  //     id: '2',
  //     //title: 'Now listen to the recordings again and note the actual uses described.',
  //     question:
  //         'What does Open University student actually use for?',
  //     // question: [
  //     //   'How does the story-telling program encourage children to work together?',
  //     //   'In what way is the children\'s reaction to this program different from other uses they make of computers?',
  //     //   'What is the OU student studying?',
  //     //   'What opportunity has she to meet other students?',
  //     //   'What can you do with Pets 3?',
  //     //   'What does Louise do with clipart?',
  //     //   'How did the artist display work to dealers in the past?',
  //     //   'What is the difficulty in selling through a website?'
  //     // ],
  //     answer: {
  //       'write assignments, email tutor, chat with other students':
  //           true
  //     },
      
  //     // answer: {
  //     //   [
  //     //     'the more children involved, the more interactive the program becomes',
  //     //     'the computer doesn\'t get in the way of learning, it\'s simply a tool',
  //     //     'maths',
  //     //     'face to face at tutorials, through help group online',
  //     //     'adopt a pet, name it, feed it, take its picture',
  //     //     'makes cards for her friends',
  //     //     'using slides',
  //     //     'getting people to visit your site'
  //     //   ]: true,
  //     // },
  //     subject: 'listening',
  //     // questionTitleTable: 'User',
  //     // answerTitleTable: 'Actual uses',
  //     // questionTable: 'primary school teacher',
  //     // answerTable: {'group story-telling': true},
  //     // questionTable: [
  //     //   'primary school teacher',
  //     //   'Open University student',
  //     //   'girl {Louise), aged 6',
  //     //   'artist'
  //     // ],
  //     // answerTable: {
  //     //   [
  //     //     'group story-telling',
  //     //     'write assignments, email tutor, chat with other students',
  //     //     'makes cards, plays games',
  //     //     'produce CD of paintings for dealers'
  //     //   ]: true,
  //     //   ['']: false
  //     // }),
  //   ),
    
  // );
  //     lessonDB.addLesson(
  //   Lesson(
  //     id: '3',
  //     //title: 'Now listen to the recordings again and note the actual uses described.',
  //     question:
  //         'What does girl {Louise), aged 6 actually use for?',
  //     // question: [
  //     //   'How does the story-telling program encourage children to work together?',
  //     //   'In what way is the children\'s reaction to this program different from other uses they make of computers?',
  //     //   'What is the OU student studying?',
  //     //   'What opportunity has she to meet other students?',
  //     //   'What can you do with Pets 3?',
  //     //   'What does Louise do with clipart?',
  //     //   'How did the artist display work to dealers in the past?',
  //     //   'What is the difficulty in selling through a website?'
  //     // ],
  //     answer: {
  //       'makes cards, plays games':
  //           true
  //     },
      
  //     // answer: {
  //     //   [
  //     //     'the more children involved, the more interactive the program becomes',
  //     //     'the computer doesn\'t get in the way of learning, it\'s simply a tool',
  //     //     'maths',
  //     //     'face to face at tutorials, through help group online',
  //     //     'adopt a pet, name it, feed it, take its picture',
  //     //     'makes cards for her friends',
  //     //     'using slides',
  //     //     'getting people to visit your site'
  //     //   ]: true,
  //     // },
  //     subject: 'listening',
  //     // questionTitleTable: 'User',
  //     // answerTitleTable: 'Actual uses',
  //     // questionTable: 'primary school teacher',
  //     // answerTable: {'group story-telling': true},
  //     // questionTable: [
  //     //   'primary school teacher',
  //     //   'Open University student',
  //     //   'girl {Louise), aged 6',
  //     //   'artist'
  //     // ],
  //     // answerTable: {
  //     //   [
  //     //     'group story-telling',
  //     //     'write assignments, email tutor, chat with other students',
  //     //     'makes cards, plays games',
  //     //     'produce CD of paintings for dealers'
  //     //   ]: true,
  //     //   ['']: false
  //     // }),
  //   ),
    
  // );
  //       lessonDB.addLesson(
  //   Lesson(
  //     id: '4',
  //     //title: 'Now listen to the recordings again and note the actual uses described.',
  //     question:
  //         'What does artist actually use for?',
  //     // question: [
  //     //   'How does the story-telling program encourage children to work together?',
  //     //   'In what way is the children\'s reaction to this program different from other uses they make of computers?',
  //     //   'What is the OU student studying?',
  //     //   'What opportunity has she to meet other students?',
  //     //   'What can you do with Pets 3?',
  //     //   'What does Louise do with clipart?',
  //     //   'How did the artist display work to dealers in the past?',
  //     //   'What is the difficulty in selling through a website?'
  //     // ],
  //     answer: {
  //       'produce CD of paintings for dealers':
  //           true
  //     },
      
  //     // answer: {
  //     //   [
  //     //     'the more children involved, the more interactive the program becomes',
  //     //     'the computer doesn\'t get in the way of learning, it\'s simply a tool',
  //     //     'maths',
  //     //     'face to face at tutorials, through help group online',
  //     //     'adopt a pet, name it, feed it, take its picture',
  //     //     'makes cards for her friends',
  //     //     'using slides',
  //     //     'getting people to visit your site'
  //     //   ]: true,
  //     // },
  //     subject: 'listening',
  //     // questionTitleTable: 'User',
  //     // answerTitleTable: 'Actual uses',
  //     // questionTable: 'primary school teacher',
  //     // answerTable: {'group story-telling': true},
  //     // questionTable: [
  //     //   'primary school teacher',
  //     //   'Open University student',
  //     //   'girl {Louise), aged 6',
  //     //   'artist'
  //     // ],
  //     // answerTable: {
  //     //   [
  //     //     'group story-telling',
  //     //     'write assignments, email tutor, chat with other students',
  //     //     'makes cards, plays games',
  //     //     'produce CD of paintings for dealers'
  //     //   ]: true,
  //     //   ['']: false
  //     // }),
  //   ),
    
  // );
  // var db = DBConnect();
  // call this function to add question
  // db.addQuestion(
  //   Question(
  //     id: '1',
  //     title:
  //         'What is a database program developed by the Microsoft Corporation ?',
  //     options: {
  //       'ADSL': false,
  //       '(Microsoft) access': true,
  //       'AI': false,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '2',
  //     title:
  //         'A wireless network device that connects a wirless network to a weird network is:',
  //     options: {
  //       'access point': true,
  //       '(Microsoft) access': false,
  //       'AI': false,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '3',
  //     title:
  //         'A registration for a user of a network system. It is used of a network system. It is used for controlling access to the system. It is:',
  //     options: {
  //       'actual': false,
  //       'active window': false,
  //       'account': true,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '4',
  //     title:
  //         'The window in a WIMP system that is currently being used. It is usually on top of any other open windows.',
  //     options: {
  //       'actual': false,
  //       'algorithm': false,
  //       'account': false,
  //       "active window": true,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '5',
  //     title:
  //         'the set of conductors that carry the memory address signals between different parts of a computer system',
  //     options: {
  //       'actual': false,
  //       'address bus': true,
  //       'anti - virus': false,
  //       "active window": true,
  //     },
  //   ),
  // );
  
  // db.fetchQuestion();
  //getUset();
  runApp(const EFTApp());
}

class EFTApp extends StatelessWidget {
  const EFTApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Nunito",
        ).copyWith(
          primaryColor: kBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: SplashScreen(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
