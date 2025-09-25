import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/presentation/home/cubit/profile/profile_cubit.dart';
import 'package:todyapp/presentation/home/cubit/profile/profile_state.dart';

import '../../../common/helpers/notification.dart';
import '../../../common/widgets/appbar_widget.dart';
import '../../../core/service_locator.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final appConfig = sl<AppConfig>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileErrorState) {
          NotificationHelper.getAlertNotification(
            state.message,
            color: Colors.red,
          );
        }
        if (state is ProfileLogoutState) {
          NotificationHelper.getAlertNotification(
            "Usuário deslogado com sucesso",
            color: Colors.green,
          );
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(title: Text('Configurações')),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          children: [
            Column(
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: appConfig.photo.isEmpty
                      ? AssetImage('assets/images/icons/no-image-user.png')
                      : NetworkImage(appConfig.photo),
                ),
                SizedBox(height: 8),
                appConfig.name.isEmpty
                    ? SizedBox.shrink()
                    : Text(
                        appConfig.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
              ],
            ),
            const SizedBox(height: 24),
            _itemMenu(
              title: "Conta",
              icon: Icons.person,
              onTap: () => context.push('/account'),
            ),
            Divider(),
            _itemMenu(
              title: "Sobre TodyApp",
              icon: Icons.info_outline,
              onTap: () => showAboutDialog(
                applicationIcon: Card(
                  color: Colors.teal,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                applicationVersion: appConfig.version,

                context: context,
              ),
            ),
            _itemMenu(
              title: "Encerrar sessão",
              icon: Icons.logout_outlined,
              onTap: () => context.read<ProfileCubit>().logOut(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemMenu({
    required String title,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
