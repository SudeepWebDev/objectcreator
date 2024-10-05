### User Documentation for Object Creator

`objcreator.web.app` is a web application designed to create JSON objects for managing and uploading timetables. This tool ensures that timetables are organized and standardized.

#### Table of Contents
1. [Getting Started](#getting-started)
2. [Features](#features)
   - [Paper Management](#paper-management)
   - [Faculty Selection](#faculty-selection)
   - [Timetable Management](#timetable-management)
3. [User Interface](#user-interface)
   - [Paper Addition](#paper-addition)
   - [Row Management](#row-management)
   - [Input Fields for Timetable](#input-fields-for-timetable)
   - [Group Management](#group-management)
   - [Additional Features](#additional-features)
   - [Generating Objects](#generating-objects)
4. [Examples](#examples)
   - [Example 1: Adding a Paper](#example-1-adding-a-paper)
   - [Example 2: Creating a Timetable Entry](#example-2-creating-a-timetable-entry)
   - [Example 3: Adding Groups (Single Faculty)](#example-3-adding-groups-single-faculty)
   - [Example 4: Adding Groups (Multiple Faculties)](#example-4-adding-groups-multiple-faculties)
   - [Example 5: Adding Additional Papers](#example-5-adding-additional-papers)
5. [Note](#note)

#### Getting Started
1. **Visit the Website**: Open [objcreator.web.app](http://objcreator.web.app) in your web browser.

#### Features

- **Paper Management**:
  - **Add Paper**: Takes two inputs—Paper Code (must be unique) and Paper Name. This step is done before creating objects.

- **Faculty Selection**: If no matching faculty is found, select "ABC." If there is no Faculty 2 in the timetable, you don’t need to select anything.

- **Timetable Management**: Fields like GE, SEC, and VAC are not required.

#### User Interface

1. **Paper Addition**
   - **Paper Code**: Must be unique.
   - **Paper Name**: Add or select the paper name.

2. **Row Management**
   - **Add Button**: Adds a new row for timetable entry.
   - **Select Row Drop-Down**: Allows copying a particular row (used when there are two continuous classes on the same day for a paper, only the time changes).
   - **Remove Button**: Removes the last row.

3. **Input Fields for Timetable**
   - **Day/Time**: Specify the day and time.
   - **Lecture Type**: Select the type of lecture.
   - **Faculty Addition (+ Button)**: Adds up to four faculty members per row.
   - **Room Number**: Specify the room number.

4. **Group Management**
   - **Add Group Button**:
     - **Group Name**: Enter a name for the group.
     - **Room and Faculty Number**: Enter the room number followed by the corresponding faculty number(s) (formatted as Room Number@Faculty Number). Multiple faculties should be separated by a dash (-). The numbers refer to the corresponding faculty number.
     - **Remove Group Button**: Removes the group entry.
     
     **Example for Group Management**: 
     - **Single Faculty**: 102@1 (means room 102 with Faculty 1)
     - **Multiple Faculties**: 102@1-2 (means room 102 with Faculty 1 and Faculty 2)

5. **Additional Features**
   - **Additional Papers**: Each main row can have up to two more papers. Each added paper will have a remove (–) button to discard it.

6. **Generating Objects**
   - **Generate Objects Button**: After filling all required fields, click this button to generate JSON objects.
   - **Copying JSON**: Copy the generated JSON object and include it along with course section and semester.

#### Examples

**Example 1: Adding a Paper**
1. Enter a unique Paper Code (e.g., 101).
2. Enter the Paper Name (e.g., Theory of Computation).
3. Click "Add Paper".

**Example 2: Creating a Timetable Entry**
1. Select the Day (e.g., Monday).
2. Select the Time (e.g., 09:30).
3. Select the Lecture Type (e.g., Theory).
4. Add Faculty (e.g., Dr. Shalini Ma'am). Use the + button to add more faculty members.
5. Enter the Room Number (e.g., 101).
6. Click "Generate Objects".

**Generated JSON:**
```json
[
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "Theory of Computation",
    "Lecture Type": "Theory",
    "Faculty 1": "Dr. Shalini Ma'am",
    "Room Number": "101"
  }
]
```

**Example 3: Adding Groups (Single Faculty)**
1. Enter Group Name (e.g., Group A).
2. Enter Room Number and Faculty Number (e.g., 102@1).
3. Click "Add Group".

**Generated JSON with Group (Single Faculty):**
```json
[
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "Theory of Computation",
    "Lecture Type": "Theory",
    "Faculty 1": "Dr. Shalini Ma'am",
    "Room Number": "101",
    "Grp Name": ["Group A"],
    "Group A": "102@1"
  }
]
```

**Example 4: Adding Groups (Multiple Faculties)**
1. Enter Group Name (e.g., Group B).
2. Enter Room Number and Faculty Number (e.g., 102@1-2).
3. Click "Add Group".

**Generated JSON with Group (Multiple Faculties):**
```json
[
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "Theory of Computation",
    "Lecture Type": "Theory",
    "Faculty 1": "Dr. Shalini Ma'am",
    "Room Number": "101",
    "Grp Name": ["Group B"],
    "Group B": "102@1-2"
  }
]
```

**Example 5: Adding Additional Papers**
1. After creating a timetable entry, click the add button to include another paper (e.g., 102).
2. Enter the Paper Name (e.g., Software Engineering) and other relevant details.
3. Click the remove (–) button to discard the additional paper if necessary.

**Generated JSON with Additional Papers:**
```json
[
  {
    "Day": "Monday",
    "Time": "09:30",
    "Paper Name": "Theory of Computation",
    "Lecture Type": "Theory",
    "Faculty 1": "Dr. Shalini Ma'am",
    "Room Number": "101",
    "Paper Name_2": "Software Engineering",
    "Lecture Type_2": "Theory",
    "Faculty 1_2": "Ms. Uma Ojha",
    "Room Number_2": "102"
  }
]
```

#### Note:
- Always ensure that the correct information is inputted for each paper to maintain reliability.

For a complete guide, refer to the [README.md](https://github.com/SudeepWebDev/objectcreator/blob/main/README.md) in the repository.


