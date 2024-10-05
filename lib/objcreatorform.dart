import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:objectcreator/models/data.dart';
import 'package:objectcreator/components/drawer.dart';
import 'package:objectcreator/models/models.dart';

class ObjectCreatorForm extends StatefulWidget {
  const ObjectCreatorForm({super.key});

  @override
  State<ObjectCreatorForm> createState() => _ObjectCreatorFormState();
}

class _ObjectCreatorFormState extends State<ObjectCreatorForm> {
  final List<Map<String, String?>> _rows = [
    {
      'Day': null,
      'Time': null,
      'Paper Name': null,
      'Lecture Type': null,
      'Faculty 1': null,
      'Room Number': null,
    }
  ];

  List<Map<String, String?>> allRows = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController paperCodeController = TextEditingController();
  final TextEditingController paperNameController = TextEditingController();
  int copyRowIndex = 0;

  void init() {
    paperData.sort((a, b) => a.paperName.compareTo(b.paperName));
    facultyData.sort((a, b) => a['Faculty Name']?.compareTo(b['Faculty Name']));
    roomData.sort();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object Creator'),
      ),
      drawer: const ObjDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            _buildPaperInputRow(),
            ..._buildRows(),
            const SizedBox(height: 10),
            _buildRowActions(),
            const SizedBox(height: 20),
            _buildGenerateButton(),
            const SizedBox(height: 20),
            _buildGeneratedObjects(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaperInputRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: paperCodeController,
            decoration: const InputDecoration(
              labelText: 'Paper Code',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: paperNameController,
            decoration: const InputDecoration(
              labelText: 'Paper Name',
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              paperData.add(
                  Paper(paperCodeController.text, paperNameController.text));
            });
          },
          child: const Text("Add Paper"),
        ),
      ],
    );
  }

  List<Widget> _buildRows() {
    return List.generate(_rows.length, (i) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth > 600
              ? _buildDesktopRow(i)
              : _buildMobileRow(i);
        },
      );
    });
  }

  Widget _buildDesktopRow(int i) {
    return Row(
      children: _buildFields(i),
    );
  }

  Widget _buildMobileRow(int i) {
    return Wrap(
      children: _buildFields(i),
    );
  }

  List<Widget> _buildFields(int i) {
    return [
      buildDropdownField(i, 'Day', Constants.days),
      buildDropdownField(i, 'Time', Constants.timings),
      buildDropdownField(i, 'Lecture Type', Constants.lectureType),
      buildDropdownField(
          i, 'Paper Name', paperData.map((paper) => paper.paperName).toList()),
      ..._buildFacultyFields(i),
      buildDropdownField(i, 'Room Number', roomData),
    ];
  }

  List<Widget> _buildFacultyFields(int i) {
    List<Widget> facultyFields = [];
    int facultyCount =
        _rows[i].keys.where((key) => key.startsWith('Faculty')).length;

    for (int j = 1; j <= facultyCount; j++) {
      facultyFields.add(buildDropdownField(
          i,
          'Faculty $j',
          facultyData
              .map((faculty) => faculty['Faculty Name'] as String)
              .toList()));
    }

    if (facultyCount < 4) {
      facultyFields.add(
        IconButton.filledTonal(
          tooltip: 'Add Faculty ${facultyCount + 1}',
          onPressed: () {
            setState(() {
              _rows[i]['Faculty ${facultyCount + 1}'] = null;
            });
          },
          icon: const Icon(Icons.add),
        ),
      );
    }

    if (facultyCount > 1) {
      facultyFields.add(
        IconButton.filledTonal(
          tooltip: 'Remove Faculty $facultyCount',
          onPressed: () {
            setState(() {
              _rows[i].remove('Faculty $facultyCount');
            });
          },
          icon: const Icon(Icons.remove),
        ),
      );
    }

    return facultyFields;
  }

  Widget buildDropdownField(int i, String field, List<String> items) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _rows[i][field],
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _rows[i][field] = newValue;
          });
        },
        decoration: InputDecoration(
          labelText: field,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a $field';
          }
          return null;
        },
        isExpanded: true,
      ),
    );
  }

  Widget _buildRowActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _rows.add({
                'Day': null,
                'Time': null,
                'Paper Name': null,
                'Faculty 1': null,
                'Room Number': null,
              });
            });
          },
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: copyRowIndex,
          onChanged: (int? newValue) {
            setState(() {
              copyRowIndex = newValue!;
            });
          },
          items: List.generate(_rows.length, (index) => index).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('Row ${value + 1}'),
            );
          }).toList(),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _rows.add(Map<String, String?>.from(_rows[copyRowIndex]));
            });
          },
          child: const Icon(Icons.copy),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _rows.removeLast();
            });
          },
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          for (var row in _rows) {
            allRows.add({
              'Day': row['Day'],
              'Time': row['Time'],
              'Paper Name': row['Paper Name'],
              'Lecture Type': row['Lecture Type'],
              'Faculty 1': row['Faculty 1'],
              'Faculty 2': row['Faculty 2'],
              'Faculty 3': row['Faculty 3'],
              'Faculty 4': row['Faculty 4'],
              'Room Number': row['Room Number'],
            });
          }
          setState(() {
            allRows = allRows;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Objects Created Successfully'),
            ),
          );
        }
      },
      child: const Text('Generate Objects'),
    );
  }

  Widget _buildGeneratedObjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: allRows.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextFormField(
                    initialValue: allRows[index].toString(),
                    style: const TextStyle(color: Colors.black),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        String jsonString = allRows
                            .map((row) => json.encode(row))
                            .toList()
                            .toString();
                        Clipboard.setData(ClipboardData(text: jsonString));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Objects copied to clipboard'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          allRows.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
