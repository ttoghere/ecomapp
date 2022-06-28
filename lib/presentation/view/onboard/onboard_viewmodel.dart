import 'dart:async';

import 'package:ecomapp/app/app_shelf.dart';
import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:ecomapp/presentation/view/base/base_viewmodel.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //Stream Controllers

  final StreamController streamController = StreamController<SlideViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //Private Funcs

  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: StringManager.onBoardTitle1,
          subtitle: StringManager.onBoardSubtitle1,
          image: ImageManagement.onBoardingLogo1,
        ),
        SliderObject(
          title: StringManager.onBoardTitle2,
          subtitle: StringManager.onBoardSubtitle2,
          image: ImageManagement.onBoardingLogo2,
        ),
        SliderObject(
          title: StringManager.onBoardTitle3,
          subtitle: StringManager.onBoardSubtitle3,
          image: ImageManagement.onBoardingLogo3,
        ),
        SliderObject(
          title: StringManager.onBoardTitle4,
          subtitle: StringManager.onBoardSubtitle4,
          image: ImageManagement.onBoardingLogo4,
        ),
      ];

  //İnputs

  @override
  void dispose() {
    streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged({required int index}) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => streamController.sink;

  //Outputs

  @override
  // TODO: implement outputSliderViewObject
  Stream<SlideViewObject> get outputSliderViewObject =>
      streamController.stream.map((slideViewObject) => slideViewObject);

  void _postDataToView() {
    inputSliderViewObject.add(SlideViewObject(
      sliderObject: _list[_currentIndex],
      numOfSlides: _list.length,
      currentIndex: _currentIndex,
    ));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged({required int index});
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}
