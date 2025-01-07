import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Courses:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            buildCourseCard(context, 'Introduction to Programming'),
            buildCourseCard(context, 'Intermediate Programming with Objects'),
            buildCourseCard(context, 'Data Structure and Algorithms'),
            buildCourseCard(context, 'Database'),
            buildCourseCard(context, 'Linear Algebra'),
            buildCourseCard(context, 'Calculus 2'),
          ],
        ),
      ),
    );
  }

  Widget buildCourseCard(BuildContext context, String courseName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorPage(courseName: courseName)),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              courseName,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorPage extends StatelessWidget {
  final String courseName;
  TutorPage({required this.courseName});

  @override
  Widget build(BuildContext context) {
    // Map of courses to tutors
    final Map<String, Map<String, String>> courseTutors = {
      'Introduction to Programming': {
        'tutorName': 'Dr. John Doe',
        'availability': 'Mon-Wed, 9 AM - 12 PM',
      },
      'Intermediate Programming with Objects': {
        'tutorName': 'Dr. Jane Smith',
        'availability': 'Tue-Thu, 2 PM - 5 PM',
      },
      'Data Structure and Algorithms': {
        'tutorName': 'Dr. Mark Brown',
        'availability': 'Mon, Wed, Fri, 10 AM - 1 PM',
      },
      'Database': {
        'tutorName': 'Dr. Alice White',
        'availability': 'Mon-Tue, 11 AM - 3 PM',
      },
      'Linear Algebra': {
        'tutorName': 'Dr. Bob Green',
        'availability': 'Mon-Fri, 9 AM - 12 PM',
      },
      'Calculus 2': {
        'tutorName': 'Dr. Charlie Black',
        'availability': 'Mon-Wed, 1 PM - 4 PM',
      },
    };

    // Fetch the tutor details based on the selected course
    final tutorInfo = courseTutors[courseName];

    // If the course is not in the map, show default info
    if (tutorInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$courseName Tutor'),
        ),
        body: Center(
          child: Text('No tutor information available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName Tutor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tutor: ${tutorInfo['tutorName']}', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text('Availability: ${tutorInfo['availability']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentPage(tutorName: tutorInfo['tutorName']!)),
                );
              },
              child: Text('Register or Log in with ${tutorInfo['tutorName']}'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentPage extends StatefulWidget {
  final String tutorName;
  StudentPage({required this.tutorName});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in with ${widget.tutorName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for login could be added here, like checking username and password
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionPage(tutorName: widget.tutorName)),
                );
              },
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionPage extends StatelessWidget {
  final String tutorName;
  SessionPage({required this.tutorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions with $tutorName'),
      ),
      body: Center(
        child: Text('Welcome, you can now access sessions with $tutorName.'),
      ),
    );
  }
}