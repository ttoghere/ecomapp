import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:flutter/material.dart';
import 'package:ecomapp/data/data_shelf.dart';

enum StateRendererType {
  //Popups
  popupLoadingState,
  popupErrorState,
  //Full Screen
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState,
  emptyScreenState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function? retryActionFunction;
  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : message = message ?? StringManager.loading,
        title = title ?? Empty,
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context: context);
  }

  Widget _getStateWidget({required BuildContext context}) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getItemsInColumn(
            widgets: [_getAnimatedImage(), _getMessage(message: message)]);
      case StateRendererType.popupErrorState:
        return _getItemsInColumn(
            widgets: [_getAnimatedImage(), _getMessage(message: message)]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(
            widgets: [_getAnimatedImage(), _getMessage(message: message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn(widgets: [
          _getAnimatedImage(),
          _getMessage(message: failure.message),
          _getRetryButton(title: StringManager.retryAgain, context: context)
        ]);
      case StateRendererType.contentScreenState:
        return _getItemsInColumn(
            widgets: [_getAnimatedImage(), _getMessage(message: message)]);
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn(
            widgets: [_getAnimatedImage(), _getMessage(message: message)]);
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Container(),
    );
  }

  Widget _getMessage({required String message}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(
      {required String title, required BuildContext context}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType == StateRendererType.fullScreenErrorState) {
                  retryActionFunction?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(title)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn({required List<Widget> widgets}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}
