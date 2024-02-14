import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/app_settings_state.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: Consumer<AppSettingsState>(
          builder: (BuildContext context, AppSettingsState settings, _) {
            return CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  stretch: true,
                  alwaysShowMiddle: false,
                  middle: Text(AppStrings.settings),
                  previousPageTitle: AppStrings.main,
                  largeTitle: Text(AppStrings.settings),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.mardingWithoutBottom,
                    child: Text(
                      AppStrings.options,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    title: const Text(AppStrings.openWithWordSearch),
                    leading: const Icon(CupertinoIcons.keyboard),
                    trailing: CupertinoSwitch(
                      value: settings.getIsSearchWord,
                      onChanged: (bool value) {
                        settings.changeIsSearchWord = value;
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.mardingWithoutBottom,
                    child: Text(
                      AppStrings.notifications,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    title: const Text(AppStrings.dailyNotifications),
                    additionalInfo: Text(settings.getNotificationTime.toString().substring(0, 5)),
                    leading: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.time, color: CupertinoColors.systemRed),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text(AppStrings.notificationTime),
                              content: SizedBox(
                                height: 200,
                                child: CupertinoTimerPicker(
                                  initialTimerDuration: settings.getNotificationTime,
                                  mode: CupertinoTimerPickerMode.hm,
                                  onTimerDurationChanged: (Duration time) {
                                    settings.changeNotificationTime = time;
                                  },
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(
                                    AppStrings.apply,
                                    style: TextStyle(
                                      color: CupertinoColors.systemRed,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text(AppStrings.cancel),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    trailing: CupertinoSwitch(
                      value: settings.getDailyNotification,
                      onChanged: (bool value) {
                        settings.changeNotificationState = value;
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.mardingWithoutBottom,
                    child: Text(
                      AppStrings.display,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    title: const Text(AppStrings.alwaysOnDisplay),
                    leading: const Icon(CupertinoIcons.brightness),
                    trailing: CupertinoSwitch(
                      value: settings.getIsAlwaysOnDisplay,
                      onChanged: (bool value) {
                        settings.changeOnDisplayState = value;
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.mardingWithoutBottom,
                    child: Text(
                      AppStrings.applications,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    onTap: () {
                      _launchUrl(
                          link:
                              'https://apps.apple.com/ru/developer/imanil-binyaminov/id1564920953');
                    },
                    title: const Text(AppStrings.applications),
                    leading: Image.asset('assets/icons/appstore.png'),
                    trailing: const Icon(CupertinoIcons.forward),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.mardingWithoutBottom,
                    child: Text(
                      AppStrings.contacts,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    onTap: () {
                      _launchUrl(link: 'https://instagram.com/dev_muslim');
                    },
                    title: const Text(AppStrings.instagram),
                    leading: Image.asset('assets/icons/instagram.png'),
                    trailing: const Icon(CupertinoIcons.forward),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CupertinoListTile(
                    onTap: () {
                      _launchUrl(link: 'https://t.me/jmapps');
                    },
                    title: const Text(AppStrings.telegram),
                    leading: Image.asset('assets/icons/telegram.png'),
                    trailing: const Icon(CupertinoIcons.forward),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl({required String link}) async {
    final Uri urlLink = Uri.parse(link);
    await launchUrl(urlLink);
  }
}
