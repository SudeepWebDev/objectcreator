// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:objectcreator/models/data.dart';
// import 'package:objectcreator/components/drawer.dart';
// import 'package:objectcreator/models/models.dart';

// class ObjectCreatorForm extends StatefulWidget {
//   const ObjectCreatorForm({super.key});

//   @override
//   State<ObjectCreatorForm> createState() => _ObjectCreatorFormState();
// }

// class _ObjectCreatorFormState extends State<ObjectCreatorForm> {
//   final List<Map<String, String?>> _rows = [
//     {
//       'Day': null,
//       'Time': null,
//       'Paper Name': null,
//       'Lecture Type': null,
//       'Faculty 1': null,
//       'Room Number': null,
//     }
//   ];

//   List<Map<String, String?>> allRows = [];
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController paperCodeController = TextEditingController();
//   final TextEditingController paperNameController = TextEditingController();
//   int copyRowIndex = 0;

//   void init() {
//     paperData.sort((a, b) => a.paperName.compareTo(b.paperName));
//     facultyData.sort((a, b) => a['Faculty Name']?.compareTo(b['Faculty Name']));
//     roomData.sort();
//   }

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Object Creator'),
//       ),
//       drawer: const ObjDrawer(),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(20.0),
//           children: <Widget>[
//             _buildPaperInputRow(),
//             ..._buildRows(),
//             const SizedBox(height: 10),
//             _buildRowActions(),
//             const SizedBox(height: 20),
//             _buildGenerateButton(),
//             const SizedBox(height: 20),
//             _buildGeneratedObjects(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaperInputRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: paperCodeController,
//             decoration: const InputDecoration(
//               labelText: 'Paper Code',
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: TextField(
//             controller: paperNameController,
//             decoration: const InputDecoration(
//               labelText: 'Paper Name',
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               paperData.add(
//                   Paper(paperCodeController.text, paperNameController.text));
//             });
//           },
//           child: const Text("Add Paper"),
//         ),
//       ],
//     );
//   }

//   List<Widget> _buildRows() {
//     return List.generate(_rows.length, (i) {
//       return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return constraints.maxWidth > 600
//               ? _buildDesktopRow(i)
//               : _buildMobileRow(i);
//         },
//       );
//     });
//   }

//   Widget _buildDesktopRow(int i) {
//     return Column(
//       children: [
//         Row(
//           children: _buildFields(i),
//         ),
//         if (_rows[i].containsKey('Paper Name_2')) _buildAdditionalFields(i, 2),
//         if (_rows[i].containsKey('Paper Name_3')) _buildAdditionalFields(i, 3),
//       ],
//     );
//   }

//   Widget _buildMobileRow(int i) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Column(
//           children: _buildFields(i),
//         ),
//         if (_rows[i].containsKey('Paper Name_2')) _buildAdditionalFields(i, 2),
//         if (_rows[i].containsKey('Paper Name_3')) _buildAdditionalFields(i, 3),
//       ],
//     );
//   }

//   List<Widget> _buildFields(int i) {
//     return [
//       buildDropdownField(i, 'Day', Constants.days),
//       buildDropdownField(i, 'Time', Constants.timings),
//       buildDropdownField(i, 'Lecture Type', Constants.lectureType),
//       buildDropdownField(
//           i, 'Paper Name', paperData.map((paper) => paper.paperName).toList()),
//       ..._buildFacultyFields(i),
//       buildDropdownField(i, 'Room Number', roomData),
//       if (!_rows[i].containsKey('Paper Name_3'))
//         IconButton(
//           tooltip: 'Add Additional Paper',
//           onPressed: () {
//             setState(() {
//               if (!_rows[i].containsKey('Paper Name_2')) {
//                 _rows[i]['Paper Name_2'] = null;
//                 _rows[i]['Lecture Type_2'] = null;
//                 _rows[i]['Faculty 1_2'] = null;
//                 _rows[i]['Room Number_2'] = null;
//               } else if (!_rows[i].containsKey('Paper Name_3')) {
//                 _rows[i]['Paper Name_3'] = null;
//                 _rows[i]['Lecture Type_3'] = null;
//                 _rows[i]['Faculty 1_3'] = null;
//                 _rows[i]['Room Number_3'] = null;
//               }
//             });
//           },
//           icon: const Icon(Icons.add),
//         ),
//     ];
//   }

//   List<Widget> _buildFacultyFields(int i) {
//     List<Widget> facultyFields = [];
//     int facultyCount =
//         _rows[i].keys.where((key) => key.startsWith('Faculty') && !key.contains('_')).length;

//     for (int j = 1; j <= facultyCount; j++) {
//       facultyFields.add(buildDropdownField(
//           i,
//           'Faculty $j',
//           facultyData
//               .map((faculty) => faculty['Faculty Name'] as String)
//               .toList()));
//     }

//     if (facultyCount < 4) {
//       facultyFields.add(
//         IconButton.filledTonal(
//           tooltip: 'Add Faculty ${facultyCount + 1}',
//           onPressed: () {
//             setState(() {
//               _rows[i]['Faculty ${facultyCount + 1}'] = null;
//             });
//           },
//           icon: const Icon(Icons.add),
//         ),
//       );
//     }

//     if (facultyCount > 1) {
//       facultyFields.add(
//         IconButton.filledTonal(
//           tooltip: 'Remove Faculty $facultyCount',
//           onPressed: () {
//             setState(() {
//               _rows[i].remove('Faculty $facultyCount');
//             });
//           },
//           icon: const Icon(Icons.remove),
//         ),
//       );
//     }

//     return facultyFields;
//   }

//   Widget buildDropdownField(int i, String field, List<String> items) {
//     return Flexible(
//       child: DropdownButtonFormField<String>(
//         value: _rows[i][field],
//         items: items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(
//               value,
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             _rows[i][field] = newValue;
//           });
//         },
//         decoration: InputDecoration(
//           labelText: field,
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please select a $field';
//           }
//           return null;
//         },
//         isExpanded: true,
//       ),
//     );
//   }

//   Widget _buildAdditionalFields(int i, int paperIndex) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             buildDropdownField(i, 'Paper Name_$paperIndex',
//                 paperData.map((paper) => paper.paperName).toList()),
//             buildDropdownField(i, 'Lecture Type_$paperIndex',
//                 Constants.lectureType),
//             buildDropdownField(i, 'Faculty 1_$paperIndex',
//                 facultyData.map((faculty) => faculty['Faculty Name'] as String).toList()),
//             buildDropdownField(i, 'Room Number_$paperIndex', roomData),
//             IconButton(
//               tooltip: 'Remove Paper Name_$paperIndex',
//               onPressed: () {
//                 setState(() {
//                   _rows[i].remove('Paper Name_$paperIndex');
//                   _rows[i].remove('Lecture Type_$paperIndex');
//                   _rows[i].remove('Faculty 1_$paperIndex');
//                   _rows[i].remove('Room Number_$paperIndex');
//                 });
//               },
//               icon: const Icon(Icons.remove),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildRowActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _rows.add({
//                 'Day': null,
//                 'Time': null,
//                 'Paper Name': null,
//                 'Faculty 1': null,
//                 'Room Number': null,
//               });
//             });
//           },
//           child: const Icon(Icons.add),
//         ),
//         const SizedBox(width: 10),
//         DropdownButton<int>(
//           value: copyRowIndex,
//           onChanged: (int? newValue) {
//             setState(() {
//               copyRowIndex = newValue!;
//             });
//           },
//           items: List.generate(_rows.length, (index) => index).map((int value) {
//             return DropdownMenuItem<int>(
//               value: value,
//               child: Text('Row ${value + 1}'),
//             );
//           }).toList(),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _rows.add(Map<String, String?>.from(_rows[copyRowIndex]));
//             });
//           },
//           child: const Icon(Icons.copy),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _rows.removeLast();
//             });
//           },
//           child: const Icon(Icons.remove),
//         ),
//       ],
//     );
//   }

//   Widget _buildGenerateButton() {
//     return ElevatedButton(
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           for (var row in _rows) {
//             allRows.add({
//               if (row['Day'] != null) 'Day': row['Day'],
//               if (row['Time'] != null) 'Time': row['Time'],
//               if (row['Paper Name'] != null) 'Paper Name': row['Paper Name'],
//               if (row['Lecture Type'] != null) 'Lecture Type': row['Lecture Type'],
//               if (row['Faculty 1'] != null) 'Faculty 1': row['Faculty 1'],
//               if (row['Faculty 2'] != null) 'Faculty 2': row['Faculty 2'],
//               if (row['Faculty 3'] != null) 'Faculty 3': row['Faculty 3'],
//               if (row['Faculty 4'] != null) 'Faculty 4': row['Faculty 4'],
//               if (row['Room Number'] != null) 'Room Number': row['Room Number'],
//               if (row['Paper Name_2'] != null) 'Paper Name_2': row['Paper Name_2'],
//               if (row['Lecture Type_2'] != null) 'Lecture Type_2': row['Lecture Type_2'],
//               if (row['Faculty 1_2'] != null) 'Faculty 1_2': row['Faculty 1_2'],
//               if (row['Room Number_2'] != null) 'Room Number_2': row['Room Number_2'],
//               if (row['Paper Name_3'] != null) 'Paper Name_3': row['Paper Name_3'],
//               if (row['Lecture Type_3'] != null) 'Lecture Type_3': row['Lecture Type_3'],
//               if (row['Faculty 1_3'] != null) 'Faculty 1_3': row['Faculty 1_3'],
//               if (row['Room Number_3'] != null) 'Room Number_3': row['Room Number_3'],
//                   if (row['Grp A'] != null) "Grp A": row['Grp A'],
//       // if (row['Grp B'] != null) "Grp B": row['Grp B'],
//       // if (row['Grp C'] != null) "Grp C": row['Grp C'],
//       // if (row['Grp B + C'] != null) "Grp B + C": row['Grp B + C'],
//       // if (row['Grp Name'] != null) "Grp Name": row['Grp Name'],
//             });
//           }
//           setState(() {
//             allRows = allRows;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Objects Created Successfully'),
//             ),
//           );
//         }
//       },
//       child: const Text('Generate Objects'),
//     );
//   }

//   Widget _buildGeneratedObjects() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 20.0),
//           padding: const EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: Stack(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: allRows.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return TextFormField(
//                     initialValue: allRows[index].toString(),
//                     style: const TextStyle(color: Colors.black),
//                   );
//                 },
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         String jsonString = allRows
//                             .map((row) => json.encode(row))
//                             .toList()
//                             .toString();
//                         Clipboard.setData(ClipboardData(text: jsonString));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Objects copied to clipboard'),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.copy),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           allRows.clear();
//                         });
//                       },
//                       icon: const Icon(Icons.clear),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
  final List<Map<String, dynamic>> _rows = [
    {
      'Day': null,
      'Time': null,
      'Paper Name': null,
      'Lecture Type': null,
      'Faculty 1': null,
      'Room Number': null,
      'Grp Name': [],
    }
  ];

  List<Map<String, dynamic>> allRows = [];
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
    return Column(
      children: [
        Row(
          children: _buildFields(i),
        ),
        if (_rows[i].containsKey('Paper Name_2')) _buildAdditionalFields(i, 2),
        if (_rows[i].containsKey('Paper Name_3')) _buildAdditionalFields(i, 3),
        _buildGroupFields(i),
      ],
    );
  }

  Widget _buildMobileRow(int i) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: _buildFields(i),
        ),
        if (_rows[i].containsKey('Paper Name_2')) _buildAdditionalFields(i, 2),
        if (_rows[i].containsKey('Paper Name_3')) _buildAdditionalFields(i, 3),
        _buildGroupFields(i),
      ],
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
      if (!_rows[i].containsKey('Paper Name_3'))
        IconButton(
          tooltip: 'Add Additional Paper',
          onPressed: () {
            setState(() {
              if (!_rows[i].containsKey('Paper Name_2')) {
                _rows[i]['Paper Name_2'] = null;
                _rows[i]['Lecture Type_2'] = null;
                _rows[i]['Faculty 1_2'] = null;
                _rows[i]['Room Number_2'] = null;
              } else if (!_rows[i].containsKey('Paper Name_3')) {
                _rows[i]['Paper Name_3'] = null;
                _rows[i]['Lecture Type_3'] = null;
                _rows[i]['Faculty 1_3'] = null;
                _rows[i]['Room Number_3'] = null;
              }
            });
          },
          icon: const Icon(Icons.add),
        ),
    ];
  }

  List<Widget> _buildFacultyFields(int i) {
    List<Widget> facultyFields = [];
    int facultyCount =
        _rows[i].keys.where((key) => key.startsWith('Faculty') && !key.contains('_')).length;

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
    return Flexible(
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

  Widget _buildAdditionalFields(int i, int paperIndex) {
    return Column(
      children: [
        Row(
          children: [
            buildDropdownField(i, 'Paper Name_$paperIndex',
                paperData.map((paper) => paper.paperName).toList()),
            buildDropdownField(i, 'Lecture Type_$paperIndex',
                Constants.lectureType),
            buildDropdownField(i, 'Faculty 1_$paperIndex',
                facultyData.map((faculty) => faculty['Faculty Name'] as String).toList()),
            buildDropdownField(i, 'Room Number_$paperIndex', roomData),
            IconButton(
              tooltip: 'Remove Paper Name_$paperIndex',
              onPressed: () {
                setState(() {
                  _rows[i].remove('Paper Name_$paperIndex');
                  _rows[i].remove('Lecture Type_$paperIndex');
                  _rows[i].remove('Faculty 1_$paperIndex');
                  _rows[i].remove('Room Number_$paperIndex');
                });
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupFields(int i) {
    List<Widget> groupFields = [];
    List<String> groupNames = List<String>.from(_rows[i]['Grp Name']);

    for (int j = 0; j < groupNames.length; j++) {
      groupFields.add(
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: groupNames[j],
                decoration: InputDecoration(
                  labelText: 'Grp Name ${j + 1}',
                ),
                onChanged: (value) {
                  setState(() {
                    groupNames[j] = value;
                    _rows[i]['Grp Name'][j] = value;
                  });
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Number@Faculty Number',
                ),
                onChanged: (value) {
                  setState(() {
                    _rows[i][groupNames[j]] = value;
                  });
                },
              ),
            ),
            IconButton(
              tooltip: 'Remove Group ${j + 1}',
              onPressed: () {
                setState(() {
                  _rows[i]['Grp Name'].removeAt(j);
                  _rows[i].remove(groupNames[j]);
                });
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      );
    }

    groupFields.add(
      IconButton.filledTonal(
        tooltip: 'Add Group',
        onPressed: () {
          setState(() {
            _rows[i]['Grp Name'].add('');
          });
        },
        icon: const Icon(Icons.add),
      ),
    );

    return Column(children: groupFields);
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
                'Grp Name': [],
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
              _rows.add(Map<String, dynamic>.from(_rows[copyRowIndex]));
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
            Map<String, dynamic> generatedRow = {
              if (row['Day'] != null) 'Day': row['Day'],
              if (row['Time'] != null) 'Time': row['Time'],
              if (row['Paper Name'] != null) 'Paper Name': row['Paper Name'],
              if (row['Lecture Type'] != null) 'Lecture Type': row['Lecture Type'],
              if (row['Faculty 1'] != null) 'Faculty 1': row['Faculty 1'],
              if (row['Faculty 2'] != null) 'Faculty 2': row['Faculty 2'],
              if (row['Faculty 3'] != null) 'Faculty 3': row['Faculty 3'],
              if (row['Faculty 4'] != null) 'Faculty 4': row['Faculty 4'],
              if (row['Room Number'] != null) 'Room Number': row['Room Number'],
              if (row['Paper Name_2'] != null) 'Paper Name_2': row['Paper Name_2'],
              if (row['Lecture Type_2'] != null) 'Lecture Type_2': row['Lecture Type_2'],
              if (row['Faculty 1_2'] != null) 'Faculty 1_2': row['Faculty 1_2'],
              if (row['Room Number_2'] != null) 'Room Number_2': row['Room Number_2'],
              if (row['Paper Name_3'] != null) 'Paper Name_3': row['Paper Name_3'],
              if (row['Lecture Type_3'] != null) 'Lecture Type_3': row['Lecture Type_3'],
              if (row['Faculty 1_3'] != null) 'Faculty 1_3': row['Faculty 1_3'],
              if (row['Room Number_3'] != null) 'Room Number_3': row['Room Number_3'],
              if (row['Grp Name'] != null) "Grp Name": row['Grp Name'],
            };

            for (String groupName in row['Grp Name']) {
              if (row[groupName] != null) {
                generatedRow[groupName] = row[groupName];
              }
            }

            allRows.add(generatedRow);
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