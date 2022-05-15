class FoodRegisterStates {}

class FoodIntialRegisterState extends FoodRegisterStates {}

class FoodLoadingRegisterstate extends FoodRegisterStates {}

class FoodSuccessRegisterState extends FoodRegisterStates {}

class FoodErrorRegisterState extends FoodRegisterStates {}

class FoodSuccessCreateState extends FoodRegisterStates {
  final String uId;

  FoodSuccessCreateState(this.uId);
}

class FoodErrorCreateState extends FoodRegisterStates {}

class FoodChangePasswordVisibilityRegisterState extends FoodRegisterStates {}

//
