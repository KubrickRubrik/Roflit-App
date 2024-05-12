import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roflit/core/extension/estring.dart';
import 'package:roflit/feature/common/themes/colors.dart';
import 'package:roflit/feature/common/themes/sizes.dart';
import 'package:roflit/feature/common/themes/text.dart';
import 'package:roflit/feature/presentation/menu/router/router.dart';
import 'package:roflit/feature/presentation/menu/widgets/account_list.dart';
import 'package:roflit/feature/presentation/menu/widgets/menu_button.dart';

class MainMenuAccountsPage extends StatelessWidget {
  const MainMenuAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(AppColors.bgDarkBlue1),
      borderRadius: borderRadius12,
      child: Column(
        children: [
          Container(
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
            //TODO добавить иконку Инфо
            child: Text(
              'Аккаунты'.translate,
              overflow: TextOverflow.fade,
              style: appTheme.textTheme.title2.bold.onDark1,
            ),
          ),
          const Expanded(
            child: MainMenuContent(),
          ),
          MainMenuButton(
            title: 'Создать аккаунт'.translate,
            onTap: () {
              context.pushNamed(RouteEndPoints.accounts.account.name, extra: true);
            },
          ),
        ],
      ),
    );
  }
}
