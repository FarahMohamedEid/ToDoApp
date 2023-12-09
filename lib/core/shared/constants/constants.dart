import 'package:flutter/animation.dart';
import 'package:todo_app/core/models/note_model.dart';
import 'package:todo_app/core/network/local/key.dart';
import 'package:todo_app/core/network/local/preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';

Future setNotesModel({required value}) async {
  await Pref(sharedPreferences: SharedPref.sharedPreferences)
      .set(key: notesList, value: value);
}

Future<List<NoteModel>> getNotesModel() async {
  List<NoteModel> list = [];
  var notes = await Pref(sharedPreferences: SharedPref.sharedPreferences)
      .get(key: notesList);
  if (notes != null) {
    notes.forEach((element) {
      list.add(NoteModel.fromJson(element));
    });
  }
  return list;
}

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength:
      state == ToastStates.ERROR ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: chooseToastColor(state),
      textColor: ColorsManager.white,
      fontSize: 16,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = ColorsManager.green;
      break;
    case ToastStates.ERROR:
      color = ColorsManager.red;
      break;
    case ToastStates.WARNING:
      color = ColorsManager.secondary;
      break;
  }

  return color;
}
