class FoodRegisterStates {}

class FoodInitialRegisterState extends FoodRegisterStates {}

class FoodLoadingRegisterState extends FoodRegisterStates {}

class FoodSuccessRegisterState extends FoodRegisterStates {}

class FoodErrorRegisterState extends FoodRegisterStates {}

class FoodSuccessCreateState extends FoodRegisterStates {
  final String uId;

  FoodSuccessCreateState(this.uId);
}

class FoodErrorCreateState extends FoodRegisterStates {}

class FoodChangePasswordVisibilityRegisterState extends FoodRegisterStates {}

class FoodErrorSendOTPState extends FoodRegisterStates {}

class FoodErrorVerifyOTPState extends FoodRegisterStates {}

class FoodSuccessSentOTPState extends FoodRegisterStates {}

class FoodSuccessVerifyOTPState extends FoodRegisterStates {}

class FoodSendOTPLoadingState extends FoodRegisterStates {}
