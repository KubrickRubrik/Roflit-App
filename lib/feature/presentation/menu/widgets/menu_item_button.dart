import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:roflit/feature/common/themes/colors.dart';

class MainMenuItemButton extends HookWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? bgHoverColor;

  const MainMenuItemButton({
    required this.child,
    this.onTap,
    this.bgHoverColor = const Color(AppColors.bgDarkHover),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hoverState = useState(false);
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        hoverState.value = value;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        height: 64,
        decoration: BoxDecoration(
          color: hoverState.value ? bgHoverColor?.withOpacity(0.6) : null,
          border: const Border(
            bottom: BorderSide(
              width: 2,
              color: Color(AppColors.borderLineOnLight0),
            ),
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
