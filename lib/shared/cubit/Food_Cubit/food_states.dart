abstract class FoodStates {}

class InitialFoodStates extends FoodStates {}

class FoodLoadingState extends FoodStates {}

class GetSelectedUserDataSuccessState extends FoodStates {
  final String selectedUserId;

  GetSelectedUserDataSuccessState(this.selectedUserId);
}

class GetCurrentUserDataSuccessState extends FoodStates {}

class GetCurrentUserDataErrorState extends FoodStates {}

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

class GetPostRequestsLoadingState extends FoodStates {}

class GetPostRequestsSuccessState extends FoodStates {}

class GetPostRequestsErrorState extends FoodStates {}

class GetMyRequestsSuccessState extends FoodStates {}

class RequestItemSuccessState extends FoodStates {}

class CancelPostRequestSuccessState extends FoodStates {}

class FoodGetMyHistoryTransactionsLoadingState extends FoodStates {}

class FoodGetMyHistoryTransactionsSuccessState extends FoodStates {}

class FoodGetMyHistoryTransactionsErrorState extends FoodStates {}

class AcceptRequestSuccessState extends FoodStates {}

class FoodFavoriteState extends FoodStates {}

class ChangeLoginState extends FoodStates {}

class ChangeSearchButtonIconState extends FoodStates {}

class ChangeFilterValue extends FoodStates {}

class ClearSearch extends FoodStates {}

class Search extends FoodStates {}

class GetFilteredPostsSuccessState extends FoodStates {}

