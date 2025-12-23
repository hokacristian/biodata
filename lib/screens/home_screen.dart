import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/cv_data.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Fluttertoast.showToast(msg: "Berhasil logout! Sampai jumpa 👋", backgroundColor: const Color(0xFF2E7D32), textColor: Colors.white);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A5F)),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Della Nur Aini', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5478)]))),
        foregroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () => _showLogoutDialog(context))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildSection('Tentang Saya', Text(cvData.bio, style: const TextStyle(height: 1.5))),
            _buildSection('Pengalaman Kerja', _buildExperience()),
            _buildSection('Pendidikan', _buildEducation()),
            _buildSection('Keahlian', _buildChips(cvData.skills, const Color(0xFF1E3A5F), Colors.white)),
            _buildSection('Sertifikat', _buildChips(cvData.certificates, const Color(0xFF2E7D32), Colors.white)),
            _buildSection('Project Work', _buildProjects()),
            _buildSection('Pengalaman Organisasi', Text(cvData.organization, style: const TextStyle(height: 1.5))),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF1E3A5F), width: 3)),
              child: CircleAvatar(radius: 50, backgroundImage: AssetImage(cvData.imageUrl)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cvData.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E3A5F))),
                  Text(cvData.currentPosition, style: const TextStyle(fontSize: 14, color: Color(0xFF5A7A9A))),
                  const SizedBox(height: 10),
                  _infoRow(Icons.email, cvData.email),
                  _infoRow(Icons.phone, cvData.phoneNumber),
                  _infoRow(Icons.location_on, cvData.address),
                  _infoRow(Icons.link, cvData.linkedin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(icon, size: 16, color: const Color(0xFF1E3A5F)), const SizedBox(width: 6), Flexible(child: Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF5A7A9A))))]),
  );

  Widget _buildSection(String title, Widget content) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A5F))),
        const Divider(color: Color(0xFFE8EEF4), thickness: 1.5),
        const SizedBox(height: 8),
        content,
      ]),
    ),
  );

  Widget _buildExperience() => Column(
    children: cvData.experience.map((e) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E3A5F))),
        Text(e.company, style: const TextStyle(color: Color(0xFF5A7A9A), fontWeight: FontWeight.w500)),
        Text(e.period, style: const TextStyle(color: Color(0xFF5A7A9A), fontSize: 12)),
        const SizedBox(height: 8),
        ...e.descriptions.map((d) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('• ', style: TextStyle(color: Color(0xFF1E3A5F))),
            Expanded(child: Text(d, style: const TextStyle(height: 1.4))),
          ]),
        )),
      ]),
    )).toList(),
  );

  Widget _buildEducation() => Column(
    children: cvData.education.map((e) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFFE8EEF4), borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.school, color: Color(0xFF1E3A5F)),
      ),
      title: Text(e.degree, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(e.institution, style: const TextStyle(color: Color(0xFF5A7A9A))),
        Text('${e.period} • ${e.score}', style: const TextStyle(color: Color(0xFF1E3A5F), fontSize: 12, fontWeight: FontWeight.w500)),
      ]),
    )).toList(),
  );

  Widget _buildChips(List<String> items, Color bg, Color textColor) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items.map((s) => Chip(label: Text(s, style: TextStyle(color: textColor)), backgroundColor: bg)).toList(),
  );

  Widget _buildProjects() => Column(
    children: cvData.projects.map((p) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.code, size: 18, color: Color(0xFF1E3A5F)),
        const SizedBox(width: 8),
        Expanded(child: Text(p, style: const TextStyle(height: 1.4))),
      ]),
    )).toList(),
  );
}
