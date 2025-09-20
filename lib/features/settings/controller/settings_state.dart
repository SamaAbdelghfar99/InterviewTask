part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class LanguageChangedState extends SettingsState {
  final String locale;
  LanguageChangedState(this.locale);
}
