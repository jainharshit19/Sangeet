import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {

// set ThemeMode.System as default option which would be used for initial case
ThemeCubit() : super(ThemeMode.system);
 

void updateTheme(ThemeMode theme) => emit(theme);


 @override
 ThemeMode? fromJson(Map<String, dynamic> json) {
   return ThemeMode.values[json['theme'] as int];
 }

 @override
 Map<String, dynamic>? toJson(ThemeMode mode) {
   return {'theme': mode.index};
 }

}





// import 'package:flutter/material.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';

// class ThemeCubit extends HydratedCubit<ThemeMode> {

//   ThemeCubit() :super(ThemeMode.system);

//   void updateTheme (ThemeMode themeMode) => emit(themeMode);

//   @override
//   ThemeMode? fromJson(Map<String, dynamic> json) {
//     // TODO: implement fromJson
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic>? toJson(ThemeMode state) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }

// }