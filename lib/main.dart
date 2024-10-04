import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Object Creator',
        debugShowCheckedModeBanner: false,
        home: ObjectCreatorForm());
  }
}

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
      'Faculty 2': null,
      'Faculty 3': null,
      'Faculty 4': null,
      'Room Number': null,
    }
  ];
  final List<String> _mapCollections = [
    'Papers',
    'Faculties',
    'Faculties',
    'Faculties',
    'Faculties',
    'Rooms',
  ];
  final List<String> _mapDataSaveName = [
    'Paper Name',
    'Faculty 1',
    'Faculty 2',
    'Room Number',
  ];
  final List<String> _mapDataCollectionField = [
    'Paper Name',
    'Faculty Name',
    'Faculty Name',
    'Room Number',
  ];
  List<Map<String, String?>> allRows = [];

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  final List<String> _timings = [
    '08:30',
    '09:30',
    '10:30',
    '11:30',
    '12:30',
    '13:30',
    '14:30',
    '15:30',
    '16:30',
    '17:30',
  ];
  final List<String> _lectureType = ['Theory', 'Practical', 'Tutorial'];

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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Row(
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
                        paperData.add(Paper(paperCodeController.text,
                            paperNameController.text));
                      });
                    },
                    child: const Text("Add Paper")),
              ],
            ),

            for (int i = 0; i < _rows.length; i++)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 600) {
                    // For desktop
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Day'],
                            items: _days.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Day'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Day',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a day';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Time'],
                            items: _timings.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Time'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Time',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a time';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Lecture Type'],
                            items: _lectureType.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Lecture Type'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Lecture Type',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Lecture Type';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Paper Name'],
                            items: paperData.map((paper) {
                              return DropdownMenuItem<String>(
                                value: paper.paperName.toString(),
                                child: Text(
                                  paper.paperName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Paper Name'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Paper Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Paper Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Faculty 1'],
                            items: facultyData.map((faculty) {
                              return DropdownMenuItem<String>(
                                value: faculty['Faculty Name'].toString(),
                                child: Text(faculty['Faculty Name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Faculty 1'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Faculty 1',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Faculty 1';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Faculty 2'],
                            items: facultyData.map((faculty) {
                              return DropdownMenuItem<String>(
                                value: faculty['Faculty Name'].toString(),
                                child: Text(faculty['Faculty Name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Faculty 2'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Faculty 2',
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Faculty 3'],
                            items: facultyData.map((faculty) {
                              return DropdownMenuItem<String>(
                                value: faculty['Faculty Name'].toString(),
                                child: Text(faculty['Faculty Name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Faculty 3'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Faculty 3',
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Faculty 4'],
                            items: facultyData.map((faculty) {
                              return DropdownMenuItem<String>(
                                value: faculty['Faculty Name'].toString(),
                                child: Text(faculty['Faculty Name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Faculty 4'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Faculty 4',
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _rows[i]['Room Number'],
                            items: roomData.map((room) {
                              return DropdownMenuItem<String>(
                                value: room,
                                child: Text(room),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _rows[i]['Room Number'] = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Room Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Room Number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    // For mobile
                    return Column(
                      children: <Widget>[
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Day'],
                          items: _days.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Day'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Day',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a day';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Time'],
                          items: _timings.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Time'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Time',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a time';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Lecture Type'],
                          items: _lectureType.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Lecture Type'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Lecture Type',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Lecture Type';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Paper Name'],
                          items: paperData.map((paper) {
                            return DropdownMenuItem<String>(
                              value: paper.paperName.toString(),
                              child: Text(paper.paperName.toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Paper Name'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Paper Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Paper Name';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Faculty 1'],
                          items: facultyData.map((faculty) {
                            return DropdownMenuItem<String>(
                              value: faculty['Faculty Name'].toString(),
                              child: Text(faculty['Faculty Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Faculty 1'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Faculty 1',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Faculty 1';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Faculty 2'],
                          items: facultyData.map((faculty) {
                            return DropdownMenuItem<String>(
                              value: faculty['Faculty Name'].toString(),
                              child: Text(faculty['Faculty Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Faculty 2'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Faculty 2',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Faculty 3'],
                          items: facultyData.map((faculty) {
                            return DropdownMenuItem<String>(
                              value: faculty['Faculty Name'].toString(),
                              child: Text(faculty['Faculty Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Faculty 3'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Faculty 3',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Faculty 4'],
                          items: facultyData.map((faculty) {
                            return DropdownMenuItem<String>(
                              value: faculty['Faculty Name'].toString(),
                              child: Text(faculty['Faculty Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Faculty 4'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Faculty 4',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: _rows[i]['Room Number'],
                          items: roomData.map((room) {
                            return DropdownMenuItem<String>(
                              value: room,
                              child: Text(room),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rows[i]['Room Number'] = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Room Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Room Number';
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
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
                        'Faculty 2': null,
                        'Room Number': null,
                      });
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<int>(
                  value: copyRowIndex,
                  onChanged: (int? newValue) {
                    setState(() {
                      copyRowIndex = newValue!;
                    });
                  },
                  items: List.generate(_rows.length, (index) => index)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('Row ${value + 1}'),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rows.add(Map<String, String?>.from(_rows[copyRowIndex]));
                    });
                  },
                  child: const Icon(Icons.copy),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rows.removeLast();
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
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
                                Clipboard.setData(
                                    ClipboardData(text: jsonString));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Objects copied to clipboard'),
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
            ),
            const SizedBox(
              height: 20,
            ),
            // const Divider(),
            // const Center(
            //     child: Text(
            //   'Course Coder Finder',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // )),
            // const CourseDropdown(),
          ],
        ),
      ),
    );
  }
}
