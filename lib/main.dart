import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
      Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quizzler"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green.shade300,Colors.blue.shade400]),
          ),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon>scoreKeeper = [];
  List<Question> questionBank = [
    Question(q :'Algorithm is the graphical representation of logic.', a: false ),
    Question(q :'The maximum value that an integer constant can have varies from one compiler to another.', a: true ),
    Question(q :'Structure is collection of dissimilar data types.', a: true ),
    Question(q :'It is necessary that a loop counter must only be an int. It cannot be a float.', a: false ),
    Question(q :'The keywords cannot be used as variable names.', a: true ),
    Question(q :'Two case constants within the same switch statement can have the same value.', a: false ),
    Question(q :'Only character or integer can be used in switch statement.', a: false ),
    Question(q :'#define is known as preprocessor compiler directive.', a: true ),
  ];
  int quesNum = 0;

  int score= 0;

  void nextQuestion(){
    if(quesNum < questionBank.length - 1){
    quesNum++;
    }
  }
  bool? end(){
    if(quesNum >= questionBank.length -1 ){
     return true;
    }else{
      return false;
    }
  }
  void reset(){
    quesNum =0;
    score = 0;
  }
  void checkAnswer(bool userPicked){
    bool correctAns = questionBank[quesNum].answerText;
    setState(() {
      if(end() == true ){
        Alert(
          style: AlertStyle(
            backgroundColor: Colors.cyan
          ),
          context: context,
          title: 'Finished',
          desc: 'Your score is $score',
          buttons: [
            DialogButton(
              color:Colors.orange,
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        reset();
        scoreKeeper = [];
      }else {
        if (userPicked == correctAns) {
          scoreKeeper.add(
            Icon(Icons.check,
                color: Colors.green[900],
                size: 40,
            ),
          );
          score++;
        } else {
          scoreKeeper.add(
            Icon(Icons.close,
              color: Colors.red[900],
              size: 40,
            ),
          );
        }
        nextQuestion();
      }});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  questionBank[quesNum].questionText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
                  height: 80,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: Text("True",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                    ),
                  ),
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
                  height: 80,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: Text("False",
                      style: TextStyle(
                          fontSize: 25,
                        color: Colors.black
                      ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                    ),
                  ),
                ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }

}



