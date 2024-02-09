class SettingsModel {
  final String theme;

  SettingsModel({
    required this.theme,
  });

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      theme: json['theme'],
    );
  }
}
