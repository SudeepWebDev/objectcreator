

### Documentation for objcreator.web.app

#### Overview
`objcreator.web.app` is a web application designed to create JSON objects for managing and uploading timetables. This tool ensures that timetables are organized and standardized.

#### Getting Started
1. **Visit the Website**: Open [objcreator.web.app](http://objcreator.web.app) in your web browser.

#### Features
- **Paper Management**:
  - **Add Paper**: Takes two inputs—Paper Code (must be unique and above 100) and Paper Name. This step is done before creating objects.
- **Generate Object Button**: Generates a JSON object for the timetable.
- **Faculty Selection**: If no matching faculty is found, select "ABC." If there is no Faculty 2 in the timetable, you don’t need to select anything.
- **Timetable Management**: Fields like GE, SEC, and VAC are managed separately.

#### User Interface

1. **Paper Addition**
   - **Paper Code**: Must be unique and above 100.
   - **Paper Name**: Add or select the paper name.

2. **Row Management**
   - **Add Button**: Adds a new row for timetable entry.
   - **Select Row Drop-Down**: Allows copying a particular row (used when there are two continuous classes on the same day for a paper, only the time changes).
   - **Remove Button**: Removes the last row.

3. **Input Fields for Timetable**
   - **Day/Time**: Specify the day and time.
   - **Lecture Type**: Select the type of lecture.
   - **Faculty (1-4)**: Add faculty members, defaulting to "ABC" if no match is found. If there is no Faculty 2, 3, or 4, you can leave them blank.
   - **Room Number**: Specify the room number.

4. **Generating Objects**
   - **Generate Objects Button**: After filling all required fields, click this button to generate JSON objects.
   - **Copying JSON**: Copy the generated JSON object and include it along with course section and semester.

#### Handling Special Cases

**Simultaneous Papers**: When two or more papers occur at the same time on the same day, create a separate JSON object for each paper. For example:
```json
[
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "सामान्य भाषा विज्ञान",
    "Lecture Type": "Theory",
    "Faculty 1": "Prof. Rajesh Chand Adarsh",
    "Room Number": "05"
  },
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "हिंदी नाटक एवं एकाँकी",
    "Lecture Type": "Theory",
    "Faculty 1": "Dr. Rashmi Bahl",
    "Room Number": "05"
  }
]
```

**Grouped Timetables**: For groups in the timetable, objects are not created using `objcreator.web.app` at this stage. These need to be managed separately. Ensure that this information is communicated to the relevant stakeholders.

### Note:
- Always ensure that the correct information is inputted for each paper to maintain reliability.
- Continuously update the documentation as the tool evolves to handle more complex cases like grouped timetables.

#### Troubleshooting
- **Common Issues**: Ensure all fields are filled out correctly, especially unique codes.
- **FAQs**: Provide a list of frequently asked questions and answers.

#### Contributing
- **How to Contribute**: Steps on how to contribute to the project.
- **Code of Conduct**: Guidelines for contributors.

#### License
- **Project License**: Details about the project's license.

