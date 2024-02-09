import 'package:fl_ide/app/interactor/models/settings_model.dart';

abstract class SettingsRepository {
  Future<SettingsModel> setSettings(SettingsModel model);
  Future<SettingsModel> getSettings(SettingsModel model);
}
