class CodeModel {
  final int id;
  final String title;
  final String code;

  CodeModel({
    required this.id,
    required this.title,
    required this.code,
  });
  static CodeModel fromJson(Map<String, dynamic> json) {
    return CodeModel(
      id: json['id'],
      title: json['title'],
      code: json['code'],
    );
  }
}
