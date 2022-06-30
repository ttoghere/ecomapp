import 'package:ecomapp/data/data_shelf.dart';
import 'package:ecomapp/presentation/management/string_management.dart';
import 'package:ecomapp/presentation/view/view_shelf.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//Loading State (Popup, Fullscreen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState({
    required this.stateRendererType,
    this.message,
  });
  @override
  String getMessage() => message!;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Error State (Popup, Full Loading)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? StringManager.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Content State

class ContentState extends FlowState {
  @override
  String getMessage() => Empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

//Content State

class EmptyState extends FlowState {
  String message;
  EmptyState({
    required this.message,
  });
  @override
  String getMessage() => Empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

//Flow Extension

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentScreenWidget,
    required Function retryActionFunction,
  }) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            //Popup
            _showPopUp(
              context: context,
              state: getStateRendererType(),
              message: getMessage(),
            );
            return contentScreenWidget;
          } else {
            //Content
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }

      case ErrorState:
        {
          dismissDialog(context: context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            //Popup
            _showPopUp(
              context: context,
              state: getStateRendererType(),
              message: getMessage(),
            );
            return contentScreenWidget;
          } else {
            //Content
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }

      case EmptyState:
        {
          //Content
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }

      case ContentState:
        {
          dismissDialog(context: context);
          return contentScreenWidget;
        }

      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog({required BuildContext context}) {
    if (_isThereCurrentDialogShowing(context: context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing({required BuildContext context}) =>
      ModalRoute.of(context)?.isCurrent != true;

  _showPopUp({
    required BuildContext context,
    required StateRendererType state,
    required String message,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showDialog(
          context: context,
          builder: (context) => StateRenderer(
            stateRendererType: state,
            retryActionFunction: () {
              return StateRenderer(
                stateRendererType: getStateRendererType(),
                retryActionFunction: () {},
              );
            },
            message: message,
          ),
        );
      },
    );
  }
}
