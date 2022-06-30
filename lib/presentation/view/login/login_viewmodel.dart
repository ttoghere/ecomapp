import 'dart:async';

import 'package:ecomapp/domain/usecase/login_usecase.dart';
import 'package:ecomapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ecomapp/presentation/view/view_shelf.dart';

import '../../common/freezed_data_class.dart';
import '../base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject(userName: "", password: "");
  LoginUseCase loginUseCase;
  LoginViewModel(this.loginUseCase);

  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  void start() {
    //communicate to view for showing the content on the screen
    inputState.add(ContentState());
  }

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
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    (await loginUseCase.execute(
      LoginUseCaseInput(
          email: loginObject.userName, password: loginObject.password),
    ))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.popupErrorState,
                      message: failure.message))
                },
            (data) => {
                  // right -> success (data)
                  inputState.add(ContentState())
                });
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputValidStreamController.sink;

  //Outputs

  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((userName) => isUserNameValid(userName: userName));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password: password));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream.map((_) => _allInputsValid());
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

  void _validate() {
    inputIsAllInputsValid.add(null);
  }

  @override
  // TODO: implement inputState
  Sink get inputState => throw UnimplementedError();

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => throw UnimplementedError();
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
