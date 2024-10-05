import 'package:flutter/material.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Documentation for objcreator.web.app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Text(
              'Table of Contents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildTableOfContents(),
            const SizedBox(height: 16),
            _buildSectionTitle('Overview'),
            const Text(
              'objcreator.web.app is a web application designed to create JSON objects for managing and uploading timetables. This tool ensures that timetables are organized and standardized.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Getting Started'),
            const Text(
              '1. Visit the Website: Open objcreator.web.app in your web browser.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Features'),
            _buildFeature('Paper Management', 'Add Paper: Takes two inputs—Paper Code (must be unique and above 100) and Paper Name. This step is done before creating objects.'),
            _buildFeature('Generate Object Button', 'Generates a JSON object for the timetable.'),
            _buildFeature('Faculty Selection', 'If no matching faculty is found, select "ABC." If there is no Faculty 2 in the timetable, you don’t need to select anything.'),
            _buildFeature('Timetable Management', 'Fields like GE, SEC, and VAC are managed separately.'),
            const SizedBox(height: 16),
            _buildSectionTitle('User Interface'),
            _buildFeature('Paper Addition', 'Paper Code: Must be unique and above 100.\nPaper Name: Add or select the paper name.'),
            _buildFeature('Row Management', 'Add Button: Adds a new row for timetable entry.\nSelect Row Drop-Down: Allows copying a particular row (used when there are two continuous classes on the same day for a paper, only the time changes).\nRemove Button: Removes the last row.'),
            _buildFeature('Input Fields for Timetable', 'Day/Time: Specify the day and time.\nLecture Type: Select the type of lecture.\nFaculty (1-4): Add faculty members, defaulting to "ABC" if no match is found. If there is no Faculty 2, 3, or 4, you can leave them blank.\nRoom Number: Specify the room number.'),
            _buildFeature('Generating Objects', 'Generate Objects Button: After filling all required fields, click this button to generate JSON objects.\nCopying JSON: Copy the generated JSON object and include it along with course section and semester.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Handling Special Cases'),
            _buildFeature('Simultaneous Papers', 'When two or more papers occur at the same time on the same day, create a separate JSON object for each paper. For example:'),
            const SizedBox(height: 8),
            _buildJsonCodeExample(),
            _buildFeature('Grouped Timetables', 'For groups in the timetable, objects are not created using objcreator.web.app at this stage. These need to be managed separately. Ensure that this information is communicated to the relevant stakeholders.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Note'),
            const Text(
              'Always ensure that the correct information is inputted for each paper to maintain reliability.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableOfContents() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. Overview'),
        Text('2. Getting Started'),
        Text('3. Features'),
        Text('   - Paper Management'),
        Text('   - Generate Object Button'),
        Text('   - Faculty Selection'),
        Text('   - Timetable Management'),
        Text('4. User Interface'),
        Text('   - Paper Addition'),
        Text('   - Row Management'),
        Text('   - Input Fields for Timetable'),
        Text('   - Generating Objects'),
        Text('5. Handling Special Cases'),
        Text('6. Note'),
        // Text('7. Troubleshooting'),
        // Text('8. Contributing'),
        // Text('9. License'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFeature(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonCodeExample() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black87,
      child: const Text(
        '[\n'
        '  {\n'
        '    "Day": "Monday",\n'
        '    "Time": "09:30",\n'
        '    "Paper Name": "सामान्य भाषा विज्ञान",\n'
        '    "Lecture Type": "Theory",\n'
        '    "Faculty 1": "Prof. Rajesh Chand Adarsh",\n'
        '    "Room Number": "05"\n'
        '  },\n'
        '  {\n'
        '    "Day": "Monday",\n'
        '    "Time": "09:30",\n'
        '    "Paper Name": "हिंदी नाटक एवं एकाँकी",\n'
        '    "Lecture Type": "Theory",\n'
        '    "Faculty 1": "Dr. Rashmi Bahl",\n'
        '    "Room Number": "05"\n'
        '  }\n'
        ']',
        style: TextStyle(
          fontFamily: 'monospace',
          color: Colors.white,
        ),
      ),
    );
  }
}
