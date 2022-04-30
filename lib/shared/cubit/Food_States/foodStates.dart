
abstract class FoodStates {}

class InitialFoodStates extends FoodStates{}

class ChangeBottomNavState extends FoodStates{}

class DonateFoodState extends FoodStates{}

class IsCheckedState extends FoodStates {}

class ChangeVerticalGroupValue extends FoodStates {}

class ChangeVerticalGroupValue2 extends FoodStates {}

class ChangeDateTimeState extends FoodStates {}

class CounterIncrementState extends FoodStates {}

class CounterMinusState extends FoodStates {}

class DeleteImage1State extends FoodStates {}

class DeleteImage2State extends FoodStates {}

class CreatePostLoadingState extends FoodStates {}

class CreatePostSuccessState extends FoodStates {}

class CreatePostErrorState extends FoodStates {
  final String error;

  CreatePostErrorState(this.error);
}

class UpdatePostLoadingState extends FoodStates {}

class UpdatePostSuccessState extends FoodStates {}

class UpdatePostErrorState extends FoodStates {
  final String error;

  UpdatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends FoodStates {}

class PostImagePickedErrorState extends FoodStates {}