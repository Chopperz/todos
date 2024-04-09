import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void onChangedThemeMode({required ThemeMode themeMode}) {
    emit(state.copyWith(themeMode: themeMode));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      themeMode: (json["themeModeKey"] != null)
          ? ThemeMode.values.byName(json["themeModeKey"])
          : ThemeMode.system,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      "themeModeKey": state.themeMode.name,
    };
  }
}
