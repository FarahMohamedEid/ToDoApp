abstract class AppStates {}

class AppInitialState extends AppStates {}

/// notes validation states
class ValidateId extends AppStates {}
class ValidateTitle extends AppStates {}
class ValidateDate extends AppStates {}
class ValidateTime extends AppStates {}
class ValidateContent extends AppStates {}
class ValidateState extends AppStates {}

/// SetNoteModel states
class SetNoteModelSuccess extends AppStates {}
class SetFormFieldsValuesSuccess extends AppStates {}


/// notes get states
class GetNoteLoading extends AppStates {}
class GetNoteSuccess extends AppStates {}
class GetNoteError extends AppStates {
  final String error;
  GetNoteError(this.error);

}


/// notes create states
class CreateNoteLoading extends AppStates {}
class CreateNoteSuccess extends AppStates {}
class CreateNoteError extends AppStates {
  final String error;
  CreateNoteError(this.error);
}

/// notes update states
class UpdateNoteLoading extends AppStates {}
class UpdateNoteSuccess extends AppStates {}
class UpdateNoteError extends AppStates {
  final String error;
  UpdateNoteError(this.error);
}

/// notes update states
class DeleteNoteLoading extends AppStates {}
class DeleteNoteSuccess extends AppStates {}
class DeleteNoteError extends AppStates {
  final String error;
  DeleteNoteError(this.error);
}