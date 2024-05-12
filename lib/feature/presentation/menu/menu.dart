import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roflit/feature/common/providers/ui/provider.dart';
import 'package:roflit/feature/common/themes/colors.dart';
import 'package:roflit/feature/common/themes/sizes.dart';

import 'router/router.dart';

class MainMenu extends ConsumerWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDisplayedMainMenu = ref.watch(
      uiBlocProvider.select((v) => v.isDisplayedMainMenu),
    );

    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        sizeCurve: Curves.ease,
        crossFadeState:
            (!isDisplayedMainMenu) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: const SizedBox.shrink(),
        secondChild: const _Menu(),
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            children: [
              Positioned.fill(
                key: bottomChildKey,
                child: bottomChild,
              ),
              Positioned.fill(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Menu extends ConsumerWidget {
  const _Menu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(uiBlocProvider.notifier);
    return InkWell(
      onTap: () {
        bloc.menuActivity(
          typeMenu: TypeMenu.main,
          action: ActionMenu.openClose,
        );
      },
      onHover: (value) {
        bloc.menuActivity(
          typeMenu: TypeMenu.main,
          action: ActionMenu.hoverLeave,
          isHover: value,
        );
      },
      mouseCursor: MouseCursor.defer,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(AppColors.bgDarkBlue1).withOpacity(0.4),
        ),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {},
          enableFeedback: false,
          mouseCursor: MouseCursor.defer,
          child: Container(
            height: 500,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: borderRadius12,
              color: const Color(AppColors.bgDarkBlue1),
            ),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: MainMenuRouter.getRoute(false),
            ),
          ),
        ),
      ),
    );
  }
}
