part of 'settings_cubit.dart';
abstract class SettingsState extends Equatable{}

 class SettingsLoading extends SettingsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

 class SettingsLoaded extends SettingsState{
  final SettingsModel settings;

  SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [this.settings];
}