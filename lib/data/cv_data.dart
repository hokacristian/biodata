class CvData {
  final String fullName;
  final String currentPosition;
  final String email;
  final String phoneNumber;
  final String address;
  final String linkedin;
  final String bio;
  final String imageUrl;
  final List<Experience> experience;
  final List<Education> education;
  final List<String> skills;
  final List<String> certificates;
  final List<String> projects;
  final String organization;

  CvData({
    required this.fullName,
    required this.currentPosition,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.linkedin,
    required this.bio,
    required this.imageUrl,
    required this.experience,
    required this.education,
    required this.skills,
    required this.certificates,
    required this.projects,
    required this.organization,
  });
}

class Experience {
  final String title;
  final String company;
  final String period;
  final List<String> descriptions;

  Experience({
    required this.title,
    required this.company,
    required this.period,
    required this.descriptions,
  });
}

class Education {
  final String degree;
  final String institution;
  final String period;
  final String score;

  Education({required this.degree, required this.institution, required this.period, required this.score});
}

final cvData = CvData(
  fullName: 'Della Nur Aini',
  currentPosition: 'Admin & Data Management',
  email: 'dellanurainii@gmail.com',
  phoneNumber: '0878-7791-6553',
  address: 'Jl. Al-Muhajirin No. 12 Tanah Tinggi, Tangerang',
  linkedin: 'linkedin.com/in/dellanuraini',
  bio: 'Lulusan Teknik Komputer & Jaringan (TKJ) dari SMK Telkom Jakarta dengan pengalaman networking teknologi, manajemen data, dan administrasi perkantoran. Memiliki minat dan aspirasi tinggi di bidang telekomunikasi & jaringan, teliti, cepat belajar dengan nilai kelulusan yang baik.',
  imageUrl: 'assets/della.jpg',
  experience: [
    Experience(
      title: 'Admin Marketing Export',
      company: 'PT. Starmas Inti Aluminium Industry',
      period: 'Juni 2022 – April 2023',
      descriptions: [
        'Membuat dan memastikan detail orderan sesuai permintaan pelanggan',
        'Mengkonsolidasi data penjualan dalam laporan terperinci',
        'Monitoring dan koordinasi dengan bagian terkait secara administratif',
        'Membuat laporan kerja harian dan bulanan secara berkala',
      ],
    ),
    Experience(
      title: 'Admin Aktivasi (Magang)',
      company: 'PT. Indonesia Comnets Plus',
      period: 'Juni 2021 – Juni 2022',
      descriptions: [
        'Input dan integrasi data untuk kelancaran operasional administrasi',
        'Memelihara basis data pada Microsoft Dynamics CRM',
        'Membuat Purchase Requisition/Purchase Order di SAP',
        'Mempromosikan produk dan melayani kebutuhan pelanggan',
        'Membuat laporan kerja harian dan bulanan secara berkala',
      ],
    ),
  ],
  education: [
    Education(
      degree: 'Teknik Komputer dan Jaringan',
      institution: 'SMK Telkom Jakarta',
      period: '2018 - 2021',
      score: 'Nilai rata-rata: 92,23',
    ),
  ],
  skills: ['Microsoft Word', 'Microsoft Excel', 'Microsoft PowerPoint', 'Packet Tracer', 'Problem Solving'],
  certificates: ['TOEIC', 'LPIA-EPT', 'CISCO'],
  projects: [
    'Konfigurasi VLAN, Trunk, Server DHCP dengan simulasi Packet Tracer',
    'Konfigurasi routing V.2 dengan simulasi Packet Tracer',
  ],
  organization: 'Pimpinan penanggung jawab latihan, bendahara, serta ketua dalam ekstrakurikuler di SMK Telkom Jakarta',
);
