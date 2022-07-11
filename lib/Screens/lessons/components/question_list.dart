import 'package:flutter/material.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '1. How does the story-telling program encourage children to work together?\n\n2. In what way is the children\'s reaction to this program different from other uses they make of computers?\n\n3. What is the OU student studying?\n\n4. What opportunity has she to meet other students?\n\n5. What can you do with Pets 3?\n\n6. What does Louise do with clipart?\n\n7. How did the artist display work to dealers in the past?\n\n8. What is the difficulty in selling through a website?',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
