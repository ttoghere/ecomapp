import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:flutter/material.dart';
import 'package:ecomapp/data/data_shelf.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? StringManager.loading,
        title = title ?? Empty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(StringManager.ok, context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(StringManager.retryAgain, context)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunction
                      ?.call(); // to call the API function again to retry
                } else {
                  Navigator.of(context)
                      .pop(); // popup state error so we need to dismiss the dialog
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

// enum StateRendererType {
//   //Popups
//   popupLoadingState,
//   popupErrorState,
//   //Full Screen
//   fullScreenLoadingState,
//   fullScreenErrorState,
//   contentScreenState,
//   emptyScreenState,
// }

// class StateRenderer extends StatelessWidget {
//   StateRendererType stateRendererType;
//   String message;
//   String title;
//   Function? retryActionFunction;
//   StateRenderer({
//     Key? key,
//     required this.stateRendererType,
//     String? message,
//     String? title,
//     required this.retryActionFunction,
//   })  : message = message ?? StringManager.loading,
//         title = title ?? Empty,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return _getStateWidget(context: context);
//   }

//   Widget _getStateWidget({required BuildContext context}) {
//     switch (stateRendererType) {
//       case StateRendererType.popupLoadingState:
//         return _getPopupLoadingState(context: context, children: []);
//       case StateRendererType.popupErrorState:
//         return _getPopupLoadingState(context: context, children: [
//           _getAnimatedImage(animationName: JsonAssets.error),
//           _getMessage(message: message),
//           _getRetryButton(title: StringManager.ok, context: context)
//         ]);
//       case StateRendererType.fullScreenLoadingState:
//         return _getItemsInColumn(widgets: [
//           _getAnimatedImage(animationName: JsonAssets.loading),
//           _getMessage(message: message)
//         ]);
//       case StateRendererType.fullScreenErrorState:
//         return _getItemsInColumn(widgets: [
//           _getAnimatedImage(animationName: JsonAssets.error),
//           _getMessage(message: message),
//           _getRetryButton(title: StringManager.retryAgain, context: context)
//         ]);
//       case StateRendererType.contentScreenState:
//         return Container();
//       case StateRendererType.emptyScreenState:
//         return _getItemsInColumn(widgets: [
//           _getAnimatedImage(animationName: JsonAssets.empty),
//           _getMessage(message: message)
//         ]);
//       default:
//         return Container();
//     }
//   }

//   Widget _getAnimatedImage({required String animationName}) {
//     return SizedBox(
//       height: AppSize.s100,
//       width: AppSize.s100,
//       child: Lottie.asset(animationName),
//     );
//   }

//   Widget _getMessage({required String message}) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(AppPadding.p18),
//         child: Text(
//           message,
//           style:
//               getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
//         ),
//       ),
//     );
//   }

//   Widget _getRetryButton(
//       {required String title, required BuildContext context}) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(AppPadding.p18),
//         child: SizedBox(
//           width: AppSize.s180,
//           child: ElevatedButton(
//               onPressed: () {
//                 if (stateRendererType ==
//                     StateRendererType.fullScreenErrorState) {
//                   retryActionFunction?.call();
//                 } else {
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text(title)),
//         ),
//       ),
//     );
//   }

//   Widget _getItemsInColumn({required List<Widget> widgets}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: widgets,
//     );
//   }

//   Widget _getPopupLoadingState(
//       {required BuildContext context, required List<Widget> children}) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//           AppSize.s14,
//         ),
//       ),
//       elevation: AppSize.s1_5,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(AppSize.s14),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: AppSize.s12,
//                 offset: Offset(AppSize.s0, AppSize.s12),
//               ),
//             ]),
//         child: _getDialogContent(context: context),
//       ),
//     );
//   }

//   _getDialogContent({required BuildContext context}) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//           AppSize.s14,
//         ),
//       ),
//       elevation: AppSize.s1_5,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(AppSize.s14),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: AppSize.s12,
//                 offset: Offset(AppSize.s0, AppSize.s12),
//               ),
//             ]),
//         child: _getDialogContent(context: context),
//       ),
//     );
//   }
// }
