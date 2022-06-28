import '../base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  //inputs

  @override
  setPassword({required String password}) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUsername({required String userName}) {
    // TODO: implement setUsername
    throw UnimplementedError();
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => throw UnimplementedError();
  
  //Outputs

  @override
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();
}

abstract class LoginViewModelInputs {
  setUsername({required String userName});
  setPassword({required String password});
  login();
  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
}
