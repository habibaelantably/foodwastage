abstract class PostStates {}

class PostInitialState extends PostStates {}

class IsCheckedState extends PostStates {}

class ChangeVerticalGroupValue extends PostStates {}

class ChangeVerticalGroupValue2 extends PostStates {}

class ChangeDateTimeState extends PostStates {}

class CounterIncrementState extends PostStates {}

class CounterMinusState extends PostStates {}

class DeleteImage1State extends PostStates {}

class DeleteImage2State extends PostStates {}

class CreatePostLoadingState extends PostStates {}

class CreatePostSuccessState extends PostStates {}

class CreatePostErrorState extends PostStates {
  final String error;

  CreatePostErrorState(this.error);
}

class UpdatePostLoadingState extends PostStates {}

class UpdatePostSuccessState extends PostStates {}

class UpdatePostErrorState extends PostStates {
  final String error;

  UpdatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends PostStates {}

class PostImagePickedErrorState extends PostStates {}
