import 'dart:async';

import 'package:ecomapp/domain/usecase/login_usecase.dart';

import '../../common/freezed_data_class.dart';
import '../base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController isAllInputValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject(userName: "userName", password: "password");
  LoginUseCase loginUseCase;
  LoginViewModel(this.loginUseCase);

  @override
  void dispose() {
    passwordStreamController.close();
    userNameStreamController.close();
    isAllInputValidStreamController.close();
  }

  @override
  void start() {}

  //inputs

  @override
  setPassword({required String password}) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUsername({required String userName}) {
    inputUsername.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
        _validate();

  }

  @override
  login() async {
    (await loginUseCase.execute(
      LoginUseCaseInput(
          email: loginObject.userName, password: loginObject.password),
    ))
        .fold(
      (failure) {},
      (data) {},
    );
  }

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputUsername => userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => isAllInputValidStreamController.sink;

  //Outputs

  @override
  Stream<bool> get outputIsUsernameValid => userNameStreamController.stream
      .map((userName) => isUserNameValid(userName: userName));

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => isPasswordValid(password: password));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      isAllInputValidStreamController.stream
          .map((isAllInputValid) => _allInputsValid());
  //Private Funcs

  bool isPasswordValid({required String password}) {
    return password.isNotEmpty;
  }

  bool isUserNameValid({required String userName}) {
    return userName.isNotEmpty;
  }

  bool _allInputsValid() {
    return isPasswordValid(password: loginObject.password) &&
        isUserNameValid(userName: loginObject.userName);
  }
  
  void _validate() {}
}

abstract class LoginViewModelInputs {
  setUsername({required String userName});
  setPassword({required String password});
  login();
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
