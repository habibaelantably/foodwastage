abstract class FoodLoginStates {}

class FoodLoginIntialState extends FoodLoginStates {}

class FoodLoginLoadingState extends FoodLoginStates {}

class FoodLoginSuccessState extends FoodLoginStates {
  final String uId;

  FoodLoginSuccessState(this.uId);
}

class FoodLoginErrorState extends FoodLoginStates {
  final String error;

  FoodLoginErrorState(this.error);
}

class FoodLoginChangePasswordVisibilityState extends FoodLoginStates {}

//
