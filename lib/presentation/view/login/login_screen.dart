import 'package:ecomapp/app/di.dart';
import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:ecomapp/presentation/view/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = instance<LoginViewModel>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  _bind() {
    loginViewModel.start();
    _userNameController.addListener(
        () => loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => loginViewModel.setPassword(_passwordController.text));
    loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    super.dispose();
    loginViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: AppPadding.p100,
        ),
        decoration: BoxDecoration(color: ColorManager.white),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(ImageManagement.appLogo),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: loginViewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: StringManager.username,
                          labelText: StringManager.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : StringManager.usernameError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: loginViewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: StringManager.password,
                          labelText: StringManager.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : StringManager.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: loginViewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  loginViewModel.login();
                                }
                              : null,
                          child: const Text(StringManager.login),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.forgotPassRoute);
                        },
                        child: Text(
                          StringManager.fPassword,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.registerRoute);
                        },
                        child: Text(
                          StringManager.register,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
