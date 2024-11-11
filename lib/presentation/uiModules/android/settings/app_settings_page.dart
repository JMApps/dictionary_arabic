import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/services/notifications/local_notice_service.dart';
import '../../../../data/state/app_settings_state.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final localNotice = LocalNoticeService();
    return Scaffold(
      body: Consumer<AppSettingsState>(
        builder: (BuildContext context, settings, _) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: appColors.inversePrimary,
                forceElevated: true,
                centerTitle: true,
                floating: true,
                title: const Text(AppStrings.settings),
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
                child: ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: AppStyles.mardingSymmetricHor,
                  title: const Text(
                    AppStrings.openWithWordSearch,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: const Icon(Icons.keyboard_alt_outlined),
                  trailing: Switch(
                    value: settings.getIsSearchWord,
                    onChanged: (bool value) {
                      settings.changeIsSearchWord = value;
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: AppStyles.mardingSymmetricHor,
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
                child: ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: AppStyles.mardingSymmetricHor,
                  title: const Text(
                    AppStrings.dailyNotifications,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    '${AppStrings.remindIn} ${settings.getNotificationTime.toString().substring(0, settings.getNotificationHours < 10 ? 4 : 5)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  leading: IconButton(
                    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.access_time,
                      color: appColors.error,
                    ),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.dialOnly,
                        initialTime: TimeOfDay.fromDateTime(
                          DateTime(2024, 12, 31, settings.getNotificationHours, settings.getNotificationMinutes),
                        ),
                        helpText: AppStrings.notifications,
                        cancelText: AppStrings.cancel,
                        confirmText: AppStrings.apply,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                      ).then(
                        (TimeOfDay? time) {
                          if (time != null) {
                            settings.changeNotificationTime = Duration(hours: time.hour, minutes: time.minute);
                            if (settings.getDailyNotification) {
                              localNotice.dailyZonedScheduleNotification(
                                DateTime(2024, 12, 31, settings.getNotificationHours, settings.getNotificationMinutes),
                                AppStrings.appName,
                                AppStrings.notificationBody,
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                  trailing: Switch(
                    value: settings.getDailyNotification,
                    onChanged: (bool value) {
                      settings.changeNotificationState = value;
                      if (value) {
                        localNotice.dailyZonedScheduleNotification(
                          DateTime(2024, 12, 31, settings.getNotificationHours, settings.getNotificationMinutes),
                          AppStrings.appName,
                          AppStrings.notificationBody,
                        );
                      } else {
                        localNotice.cancelNotificationWithId(LocalNoticeService.dailyNotificationID);
                      }
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: AppStyles.mardingSymmetricHor,
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
                child: ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: AppStyles.mardingSymmetricHor,
                  title: const Text(
                    AppStrings.alwaysOnDisplay,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: const Icon(Icons.light_mode_outlined),
                  trailing: Switch(
                    value: settings.getIsAlwaysOnDisplay,
                    onChanged: (bool value) {
                      settings.changeOnDisplayState = value;
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: AppStyles.mardingSymmetricHor,
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
                child: ListTile(
                  onTap: () {
                    _launchUrl(link: 'https://play.google.com/store/apps/dev?id=8649252597553656018');
                  },
                  title: const Text(
                    AppStrings.applications,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Image.asset(
                    'assets/icons/google-play.png',
                    width: 45,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: AppStyles.horizontalVerticalMini,
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
                child: ListTile(
                  onTap: () {
                    _launchUrl(link: 'https://ummalife.com/jmapps');
                  },
                  title: const Text(
                    AppStrings.ummaLife,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Image.asset(
                    'assets/icons/ummalife.png',
                    width: 45,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () {
                    _launchUrl(link: 'https://instagram.com/dev_muslim');
                  },
                  title: const Text(
                    AppStrings.instagram,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Image.asset(
                    'assets/icons/instagram.png',
                    width: 45,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () {
                    _launchUrl(link: 'https://t.me/jmapps');
                  },
                  title: const Text(
                    AppStrings.telegram,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Image.asset(
                    'assets/icons/telegram.png',
                    width: 45,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _launchUrl({required String link}) async {
    final Uri urlLink = Uri.parse(link);
    await launchUrl(urlLink);
  }
}
