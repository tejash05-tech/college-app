import 'package:flutter/material.dart';

void main() {
  runApp(const CollegePortalApp());
}

class CollegePortalApp extends StatelessWidget {
  const CollegePortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Academic Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  // નમૂના માટે લોકલ ડેટા (પછી આપણે આને ડેટાબેઝ સાથે જોડીશું)
  final List<Map<String, String>> sampleNotices = [
    {
      'title': 'Mid-Semester Exam Timetable Announced',
      'category': 'Exam',
      'date': 'Today',
      'desc': 'Mid-sem exams will commence from next Monday. Check your department schedule.'
    },
    {
      'title': 'Fee Submission & Scholarship Circular',
      'category': 'Academic',
      'date': 'Yesterday',
      'desc': 'Eligible students must verify their documents in the office by Friday.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Portal', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildNoticesTab(),
          _buildMaterialsTab(),
          _buildApplicationsTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: 'Notices',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Materials',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Forms / Apply',
          ),
        ],
      ),
    );
  }

  // ટેબ ૧: નોટિસ બોર્ડ
  Widget _buildNoticesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: sampleNotices.length,
      itemBuilder: (context, index) {
        final item = sampleNotices[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['category']!,
                        style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Text(item['date']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(item['desc']!, style: TextStyle(fontSize: 13.5, color: Colors.grey.shade700)),
              ],
            ),
          ),
        );
      },
    );
  }

  // ટેબ ૨: સ્ટડી મટિરિયલ
  Widget _buildMaterialsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Semester Subjects', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _materialTile('Mathematics & Statistics', 'Unit 1 & 2 Notes', Icons.picture_as_pdf),
        _materialTile('Computer Fundamentals', 'Lecture Presentation (PPT)', Icons.slideshow),
        _materialTile('Engineering Mechanics', 'Question Bank & Solved Papers', Icons.menu_book),
      ],
    );
  }

  Widget _materialTile(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.indigo.shade50, child: Icon(icon, color: Colors.indigo)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.download, color: Colors.indigo),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title મટિરિયલ ડાઉનલોડ ટૂંક સમયમાં શરૂ થશે.')),
          );
        },
      ),
    );
  }

  // ટેબ ૩: ડિજિટલ ફોર્મ્સ
  Widget _buildApplicationsTab() {
    final forms = ['Leave Application', 'Bonafide Certificate', 'Medical Leave', 'Character Certificate', 'TC Application'];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Apply for Documents / Leave', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...forms.map((form) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.description, color: Colors.white)),
                title: Text(form, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$form ફોર્મ ખોલ્યું.')),
                  );
                },
              ),
            )),
      ],
    );
  }
}
