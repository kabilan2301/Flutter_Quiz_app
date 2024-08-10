import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onRestart});
  final List<String> chosenAnswers;
  final void Function() onRestart;
  List<Map<String, Object>> getSummaryData(){
    final List<Map<String, Object>> summary = [];

    for(var i = 0; i < chosenAnswers.length; i++){
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
        }
      );
    }
    return summary;
  }
  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData.where((data){
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return Container(
      margin: const EdgeInsets.all(40),
      child:  SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have answered $numCorrectAnswers out of $numTotalQuestions questions correctly!', 
            style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,),
            const SizedBox(height: 30,), 
            QuestionsSummary(summaryData),
            const SizedBox(height: 30,),
            TextButton.icon(onPressed: (){
                onRestart();
            }, icon: const Icon(Icons.repeat_rounded),label: const Text('Restart Quiz!',),style: TextButton.styleFrom(foregroundColor: Color.fromARGB(255, 217, 176, 255)),)
          ],
        ),
      ),
    );
  }
}