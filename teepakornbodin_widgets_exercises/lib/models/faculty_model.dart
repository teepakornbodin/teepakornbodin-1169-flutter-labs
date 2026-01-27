class FacultyModel {
  final String name;
  final String thaiName;
  final String imageUrl;
  final String description;

  const FacultyModel({
    required this.name,
    required this.thaiName,
    required this.imageUrl,
    required this.description,
  });

  static List<FacultyModel> getFaculties() {
    return const [
      FacultyModel(
        name: 'Engineering',
        thaiName: 'วิศวกรรมศาสตร์',
        imageUrl: 'assets/images/engineering.jpg',
        description: 'https://www.en.kku.ac.th/',
      ),
      FacultyModel(
        name: 'Medicine',
        thaiName: 'แพทยศาสตร์',
        imageUrl: 'assets/images/medicine.jpg',
        description: 'https://www.md.kku.ac.th/',
      ),
      FacultyModel(
        name: 'Architecture',
        thaiName: 'สถาปัตยกรรมศาสตร์',
        imageUrl: 'assets/images/architecture.jpg',
        description: 'https://www.arch.kku.ac.th/',
      ),
    ];
  }
}
