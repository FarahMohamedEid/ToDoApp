import 'package:flutter/material.dart';
import 'package:todo_app/core/cubit/app_states/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/models/note_model.dart';
/// TODO: if you want to use API uncomment this code
// import 'package:todo_app/core/network/remote/end_points.dart';
// import 'package:todo_app/core/network/remote/networkHelper.dart';
import 'package:todo_app/core/shared/constants/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NoteModel _noteModel = NoteModel();

  set validateId(String value) {
    _noteModel = _noteModel.copyWith(id:value);
    emit(ValidateId());
  }
  set validateTitle(String value) {
    _noteModel = _noteModel.copyWith(title:value);
    emit(ValidateTitle());
  }
  set validateDate(String value) {
    _noteModel = _noteModel.copyWith(date:value);
    emit(ValidateDate());
  }
  set validateTime(String value) {
    _noteModel = _noteModel.copyWith(time:value);
    emit(ValidateTime());
  }
  set validateContent(String value) {
    _noteModel = _noteModel.copyWith(content:value);
    emit(ValidateContent());
  }
  set validateState(bool value) {
    _noteModel = _noteModel.copyWith(done:value);
    emit(ValidateState());
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  bool get isValidateTitle => _noteModel.title == null ? false : _noteModel.title!.isNotEmpty;
  bool get isValidateDate => _noteModel.date == null ? false : _noteModel.date!.isNotEmpty;
  bool get isValidateTime => _noteModel.time == null ? false : _noteModel.time!.isNotEmpty;
  bool get isValidateContent => _noteModel.content == null ? false : _noteModel.content!.isNotEmpty;
  bool get isValidateState=> _noteModel.done == null ? false : _noteModel.done != null;


  bool get isButtonEnable =>
      isValidateTitle &&
          isValidateDate &&
          isValidateTime &&
          isValidateContent &&
          isValidateState;

  set noteModel (NoteModel value) {
    _noteModel = value;
    emit(SetNoteModelSuccess());
  }

  void setFormFieldsValues(){
    titleController.text = _noteModel.title ?? '';
    dateController.text = _noteModel.date ?? '';
    timeController.text = _noteModel.time ?? '';
    contentController.text = _noteModel.content ?? '';
    emit(SetFormFieldsValuesSuccess());
  }

  List<NoteModel> notesList = [];

  Future<void> getNotes() async {
    emit(GetNoteLoading());
    notesList = await getNotesModel();
    /// TODO: if you want to use API uncomment this code and change the token
    /// + add the API to the end_points.dart file
    // await NetworkingHelper(endPoint: getNoteAPI).get(
    //     headers: {
    //   "Authorization": "Bearer ${'user token'}"
    // },
    // ).then((value){
    //   notesList = [];
    //   value.data.forEach((element) {
    //     notesList.add(NoteModel.fromJson(element));
    //   });
    // }).catchError((e){
    //   emit(GetNoteError(e));
    // });
    emit(GetNoteSuccess());
  }

  Future<void> createNote() async {
    emit(CreateNoteLoading());
    notesList.add(_noteModel);
    await setNotesModel(value: notesList).then((value) {
      getNotes();
    });

    /// TODO: if you want to use API uncomment this code and change the token
    /// + add the API to the end_points.dart file
    // await NetworkingHelper(endPoint: createNoteAPI).post(
    //     headers: {
    //   "Authorization": "Bearer ${'user token'}"
    // }, postRequest: _noteModel.toJson()
    // ).catchError((e){
    //   emit(CreateNoteError(e));
    // });

    emit(CreateNoteSuccess());
  }

  Future<void> updateNote({required String id}) async {
    emit(UpdateNoteLoading());
    notesList[notesList.indexWhere((element) => element.id == id)] = _noteModel;
    await setNotesModel(value: notesList).then((value) {
      getNotes();
    });
    /// TODO: if you want to use API uncomment this code and change the token
    /// + add the API to the end_points.dart file
    // await NetworkingHelper(endPoint: updateNoteAPI).put(
    //     headers: {
    //   "Authorization": "Bearer ${'user token'}"
    // }, postRequest: _noteModel.toJson()
    // ).catchError((e){
    //   emit(UpdateNoteError(e));
    // });
    emit(UpdateNoteSuccess());
  }

  Future<void> deleteNote({required String id}) async {
    emit(DeleteNoteLoading());
    notesList.remove(notesList.firstWhere((element) => element.id == id));
    await setNotesModel(value: notesList).then((value) {
      getNotes();
    });
    /// TODO: if you want to use API uncomment this code and change the token
    /// + add the API to the end_points.dart file
    // await NetworkingHelper(endPoint: deleteNoteAPI).deleteData(
    //     headers: {
    //   "Authorization": "Bearer ${'user token'}"
    // }, postRequest: _noteModel.toJson()
    // );
    emit(DeleteNoteSuccess());
  }

}
