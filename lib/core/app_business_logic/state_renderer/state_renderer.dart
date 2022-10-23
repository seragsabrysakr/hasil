import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '/../shared/app_utils/app_assets.dart';
import '/../shared/app_utils/app_fonts.dart';
import '/../shared/app_utils/app_text_style.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,
  popupSuccess,
  toastErrorState,
  toastSuccess,
  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenSuccessState,
  fullScreenEmptyState,
  // general
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  double? maxContentHeight;
  bool? isSliver;

  StateRenderer({
    required this.stateRendererType,
    this.message = "loading",
    this.title = "",
    required this.retryActionFunction,
    required this.maxContentHeight,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    var widget = Container(
        constraints: BoxConstraints(
          maxHeight: maxContentHeight ?? 100.h,
        ),
        child: _getStateWidget(context));
    return isSliver!
        ? SliverToBoxAdapter(
            child: widget,
          )
        : widget;
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpLoadingDialog(
            context, [_getAnimatedImage(AppJsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(AppJsonAssets.error),
          _getMessage(message),
          getRetryButton('ok', context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [_getAnimatedImage(AppJsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return
            // EmptyViewScreen(item: EmptyItems.connectionEmpty);
            _getItemsColumn([
          _getAnimatedImage(AppJsonAssets.error),
          _getMessage(message),
          getRetryButton('try Again', context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
            [_getAnimatedImage(AppJsonAssets.empty), _getMessage(message)]);
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.popupSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage(AppJsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          getRetryButton('ok', context)
        ]);

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
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getPopUpLoadingDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        child: Lottie.asset(AppJsonAssets.loading, width: 400, height: 400),
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

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Lottie.asset(
      animationName,
      width: 30.h,
      height: 30.h,
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: AppTextStyle.getRegularStyle(
              color: Colors.white, fontSize: FontSize.s18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(
                          // style: BorderStyle.solid,
                          color: AppColors.primaryColor,
                          width: 1), // <-- this doesn't work?
                      borderRadius: BorderRadius.all(Radius.circular(1.h)),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return 0;
                    }
                    if (states.contains(MaterialState.focused)) {
                      return 0;
                    }
                    if (states.contains(MaterialState.hovered)) {
                      return 0;
                    }
                    return 0;
                  }),
                ),
                onPressed: () {
                  if (stateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    // call retry function
                    retryActionFunction.call();
                  } else {
                    // popup error state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }
}
