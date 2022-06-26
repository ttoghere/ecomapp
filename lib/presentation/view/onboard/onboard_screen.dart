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
  late final List<SliderObject> _list = _getSliderData();
  int _currentIndex = 0;
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

  @override
  Widget build(BuildContext context) {
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
            sliderObject: _list[index],
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        itemCount: _list.length,
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
                style: ElevatedButton.styleFrom(onPrimary: ColorManager.white),
                child: Text(
                  StringManager.skip,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomDots()
          ],
        ),
      ),
    );
  }

  Widget _getBottomDots() {
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
                  _getPreviousIndex(),
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
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: _getProperCircle(index: i),
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
                  _getNextIndex(),
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

  _getProperCircle({required int index}) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageManagement.hollowCircle);
    } else {
      return SvgPicture.asset(ImageManagement.solidCircle);
    }
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0;
    }
    return _currentIndex;
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
