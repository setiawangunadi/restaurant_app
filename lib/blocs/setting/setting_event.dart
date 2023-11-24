part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class DoChangeNotification extends SettingEvent {
  final int isNotification;

  DoChangeNotification({required this.isNotification});
}
