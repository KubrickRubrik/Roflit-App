import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roflit/core/extension/estring.dart';
import 'package:roflit/feature/common/providers/file_manager/provider.dart';
import 'package:roflit/feature/common/themes/colors.dart';
import 'package:roflit/feature/common/themes/sizes.dart';
import 'package:roflit/feature/common/themes/text.dart';
import 'package:roflit/feature/presentation/menu/widgets/menu_button.dart';
import 'package:roflit/feature/presentation/menu_file/pages/menu_file_list/menu_file_list_content.dart';

class MenuFileList extends HookConsumerWidget {
  const MenuFileList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(fileManagerBlocProvider.notifier);

    final managerState = ref.watch(
      fileManagerBlocProvider.select(
        (v) {
          var title = v.account?.activeStorage?.title ?? '';
          final bucket = switch (v.account?.activeStorage?.activeBucket) {
            null => '',
            _ => ' / ${v.account?.activeStorage?.activeBucket}',
          };
          title = '$title$bucket';

          return (isEmpty: v.bootloaders.isEmpty, isEdit: v.action.isEditBootloader, title: title);
        },
      ),
    );

    return InkWell(
      onTap: bloc.closMenu,
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
            margin: const EdgeInsets.symmetric(vertical: 100),
            constraints: const BoxConstraints(
              minHeight: 300,
              maxHeight: 600,
            ),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: borderRadius12,
              color: const Color(AppColors.bgDarkBlue1),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Color(AppColors.borderLineOnLight0),
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      managerState.title,
                      overflow: TextOverflow.fade,
                      style: appTheme.textTheme.title2.bold.onDark1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 56, bottom: 76),
                  child: const MenuFileListContent(),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: switch (managerState) {
                      (isEdit: _, isEmpty: true, title: _) => MainMenuButton(
                          title: 'Добавить'.translate,
                          onTap: bloc.onAddMoreFiles,
                        ),
                      (isEdit: true, isEmpty: _, title: _) => MainMenuButton(
                          title: 'Редактировать'.translate,
                          onTap: bloc.onNextEditBootloader,
                        ),
                      (isEdit: _, isEmpty: false, title: _) => MainMenuButton(
                          title: 'Продолжить'.translate,
                          onTap: bloc.onNextUploadBootloader,
                        ),
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
