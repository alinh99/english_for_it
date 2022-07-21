import 'package:flutter/material.dart';

class TableData extends StatelessWidget {
  const TableData({
    this.answerTitleTable,
    this.question,
    this.questionTitleTable,
    Key key,
  }) : super(key: key);
  final String questionTitleTable;
  final String answerTitleTable;
  final String question;
  @override
  Widget build(BuildContext context) {
    TextEditingController answer = TextEditingController();
    GlobalKey<FormState> _form = GlobalKey<FormState>();
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            questionTitleTable,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            answerTitleTable,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(
              Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Text(
                answer.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Text(
                answer.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Text(
                answer.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Form(
                  key: _form,
                  child: TextFormField(
                    controller: answer,
                    onChanged: (value) {
                      value = answer.text;
                    },
                    decoration: const InputDecoration(
                      hintText: "Type your answer here",
                    ),
                  )
                  // answer.text,
                  // style: TextStyle(fontSize: 14),
                  ),
              onTap: () {
                if (_form.currentState.validate()) {
                  print("worked");
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
