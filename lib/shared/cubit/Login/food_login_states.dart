abstract class FoodLoginStates {}

class FoodLoginInitialState extends FoodLoginStates {}

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

class FoodLoginWithGoogleLoadingstate extends FoodLoginStates{}

class FoodLoginGoogleSuccessState extends FoodLoginStates
{
  final String uId;
  FoodLoginGoogleSuccessState(this.uId);
}

class FoodLoginGoogleErrorState extends FoodLoginStates
{
  final String error;

  FoodLoginGoogleErrorState(this.error);
}

class FoodLoginWithFacebookLoadingState extends FoodLoginStates{}

class FoodLoginFacebookSuccessState extends FoodLoginStates
{
  final String uId;
  FoodLoginFacebookSuccessState(this.uId);
}

class FoodLoginFacebookErrorState extends FoodLoginStates
{
  final String error;

  FoodLoginFacebookErrorState(this.error);
}

class FoodSuccessCreateFacebookUserState extends FoodLoginStates{
  final String uId;
  FoodSuccessCreateFacebookUserState(this.uId);
}

class FoodErrorCreateFacebookUserState extends FoodLoginStates {}

class FoodSuccessCreateGoogleUserState extends FoodLoginStates{
  final String uId;
  FoodSuccessCreateGoogleUserState(this.uId);
}

class FoodErrorCreateGoogleUserState extends FoodLoginStates {}
