part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class LanguageChanged extends SettingsEvent {
  final String locale;
  LanguageChanged(this.locale);
}