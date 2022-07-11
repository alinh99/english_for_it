import 'package:flutter/material.dart';

class TableData extends StatelessWidget {
  const TableData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'User',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Actual Use',
            style: TextStyle(
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
                'primary school teacher',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Text(
                '',
                style: TextStyle(
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
                'open university student',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            DataCell(
              Text(
                '',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Text(
                'girl (Louise), aged 6',
                style: TextStyle(fontSize: 14),
              ),
            ),
            DataCell(
              Text(
                '',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Text(
                'artist',
                style: TextStyle(fontSize: 14),
              ),
            ),
            DataCell(
              Text(
                '',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}