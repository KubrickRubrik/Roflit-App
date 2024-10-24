import 'package:flutter/material.dart';
import 'package:roflit/feature/common/themes/colors.dart';
import 'package:roflit/feature/common/themes/sizes.dart';

class DownloadSectionHoverObjects extends StatefulWidget {
  final Widget child;
  const DownloadSectionHoverObjects({required this.child, super.key});

  @override
  State<DownloadSectionHoverObjects> createState() => _DownloadSectionHoverObjectsState();
}

class _DownloadSectionHoverObjectsState extends State<DownloadSectionHoverObjects> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        decoration: BoxDecoration(
          color: isHover ? const Color(AppColors.bgLightGrayOpacity10) : null,
          borderRadius: borderRadius12,
        ),
        child: widget.child,
      ),
    );
  }
}
