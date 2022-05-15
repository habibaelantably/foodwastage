abstract class FoodStates {}

class InitialFoodStates extends FoodStates {}

class FoodLoadingState extends FoodStates {}

class FoodGetSelectedUserSuccessState extends FoodStates {
  final String selectedUserId;

  FoodGetSelectedUserSuccessState(this.selectedUserId);
}

class FoodSuccessState extends FoodStates {
  final String uId;

  FoodSuccessState(this.uId);
}

//
class FoodErrorState extends FoodStates {}

class ChangeBottomNavState extends FoodStates {}

class DonateFoodState extends FoodStates {}

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

class FoodGetPostsSuccessState extends FoodStates {}

class FoodGetPostsErrorState extends FoodStates {}

class FoodGetMyPostsLoadingState extends FoodStates {}

class FoodGetMyPostsSuccessState extends FoodStates {}

class FoodGetMyPostsErrorState extends FoodStates {
  final String error;

  FoodGetMyPostsErrorState(this.error);
}

class FoodGetSelectedUserPostsLoadingState extends FoodStates {}

class FoodGetSelectedUserPostsSuccessState extends FoodStates {}

class FoodDeletePostSuccessState extends FoodStates {}

class FoodRatingUpdateSuccessState extends FoodStates {}

class FoodReceiveFoodLoadingState extends FoodStates {}

class FoodReceiveFoodSuccessState extends FoodStates {}

class FoodReceiveFoodErrorState extends FoodStates {}

class FoodGetMyReceiveFoodLoadingState extends FoodStates {}

class FoodGetMyReceiveFoodSuccessState extends FoodStates {}

class FoodGetMyReceiveFoodErrorState extends FoodStates {}

class FoodFavoriteState extends FoodStates {}
