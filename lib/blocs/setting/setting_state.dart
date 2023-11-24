part of 'setting_bloc.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class OnLoadingSetting extends SettingState {}

class OnSuccessChangeNotification extends SettingState {
  final bool isEnabled;

  OnSuccessChangeNotification({required this.isEnabled});
}

class OnFailedSetting extends SettingState {
  final String message;
  final int? statusCode;

  OnFailedSetting({required this.message, this.statusCode});
}
