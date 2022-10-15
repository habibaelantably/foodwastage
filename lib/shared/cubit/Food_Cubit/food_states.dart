
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

class DeleteProfileImgSuccessState extends FoodStates {}

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

class GetAllPostsSuccessState extends FoodStates {}

class GetAllPostsErrorState extends FoodStates {}

class GetMyPostsLoadingState extends FoodStates {}

class FoodGetMyPostsSuccessState extends FoodStates {}

class GetMyPostsErrorState extends FoodStates {
  final String error;

  GetMyPostsErrorState(this.error);
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

class GetFavoritePostsSuccessState extends FoodStates {}

class FavoritePostSuccessState extends FoodStates {}

class FavoritePostErrorState extends FoodStates {}

class UnFavoritePostSuccessState extends FoodStates {}

class UnFavoritePostErrorState extends FoodStates {}

class CommentSuccessState extends FoodStates{}

class CommentErrorState extends FoodStates{}

class GetCommentsSuccessState extends FoodStates{}

class GetCommentsLoadingState extends FoodStates{}

class CommentsButtonActivationState extends FoodStates{}

class EnableEditButtonState extends FoodStates {}

class DisableEditButtonState extends FoodStates {}

class PhoneVerificationCodeSendLoadingState extends FoodStates {}

class PhoneVerificationCodeSentSuccessState extends FoodStates {}

class PhoneVerificationCodeSentErrorState extends FoodStates {}

class PhoneVerifiedLoadingState extends FoodStates {}

class PhoneVerifiedSuccessState extends FoodStates {}

class PhoneVerifiedErrorState extends FoodStates {}

class SendMessageSuccessState extends FoodStates{}

class SendMessageErrorState extends FoodStates{}

class GetMessageSuccessState extends FoodStates{}

class UploadProfileImageSuccessState extends FoodStates{}

class UploadProfileImageErrorState extends FoodStates{}

class UpdateUserLoadingState extends FoodStates{}

class UpdateUserSuccessState extends FoodStates{}

class UpdateUserErrorState extends FoodStates{}

class ProfileImagePickedSuccessState extends FoodStates{}

class GetChatUsersSuccessState extends FoodStates{}

class GetChatUsersErrorState extends FoodStates
{
  final String error;
  GetChatUsersErrorState(this.error);
}








