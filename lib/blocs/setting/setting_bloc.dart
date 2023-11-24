import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/data/local/shared_prefs_storage.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<DoChangeNotification>(doChangeNotification);
  }

  Future<void> doChangeNotification(
    DoChangeNotification event,
    Emitter<SettingState> emit,
  ) async {
    try {
      if (event.isNotification == 0) {
        await SharedPrefsStorage.setNotification(
            notification: event.isNotification);
        emit(OnSuccessChangeNotification(isEnabled: false));
      } else {
        await SharedPrefsStorage.setNotification(
            notification: event.isNotification);
        emit(OnSuccessChangeNotification(isEnabled: true));
      }
    } on SocketException catch (e) {
      emit(OnFailedSetting(message: e.toString()));
    } catch (e) {
      emit(OnFailedSetting(message: e.toString()));
    }
  }
}
