import 'package:ecomapp/presentation/view/onboard/onboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ecomapp/app/app_shelf.dart';
import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel onBoardingViewModel = OnBoardingViewModel();
  _bind() {
    onBoardingViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    onBoardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
      stream: onBoardingViewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContent(context, snapshot.data);
      },
    );
  }

  Widget _getContent(BuildContext context, SlideViewObject? data) {
    if (data == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          itemBuilder: (context, index) {
            return OnBoardingPage(
              sliderObject: data.sliderObject,
            );
          },
          onPageChanged: (index) {
            onBoardingViewModel.onPageChanged(index: index);
          },
          controller: _pageController,
          itemCount: data.numOfSlides,
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(onPrimary: ColorManager.white),
                  child: Text(
                    StringManager.skip,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomDots(data)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomDots(SlideViewObject data) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppPadding.p14,
            ),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  onBoardingViewModel.goPrevious(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.easeInBack,
                );
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageManagement.leftArrow),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < data.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: _getProperCircle(
                    index: i,
                    currentindex: data.currentIndex,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppPadding.p14,
            ),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  onBoardingViewModel.goNext(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.easeInBack,
                );
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageManagement.rightArrow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getProperCircle({required int index, required int currentindex}) {
    if (index == currentindex) {
      return SvgPicture.asset(ImageManagement.hollowCircle);
    } else {
      return SvgPicture.asset(ImageManagement.solidCircle);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingPage({
    Key? key,
    required this.sliderObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
