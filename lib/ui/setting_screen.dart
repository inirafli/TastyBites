import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/scheduling_provider.dart';
import '../widgets/bottom_navigation.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Settings',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: 32.0),
              _buildNotificationSetting(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Consumer<SchedulingProvider>(
      builder: (context, schedulingProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Enable Restaurant Notifications',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
              ],
            ),
            Switch(
              value: schedulingProvider.isNotificationEnabled,
              onChanged: (value) {
                schedulingProvider.toggleNotification(value);
              },
              activeColor: Theme
                  .of(context)
                  .colorScheme
                  .onSecondary,
              activeTrackColor: Theme
                  .of(context)
                  .colorScheme
                  .secondary,
              inactiveThumbColor: Theme
                  .of(context)
                  .colorScheme
                  .secondary,
              inactiveTrackColor: Theme
                  .of(context)
                  .colorScheme
                  .onSecondary,
            ),
          ],
        );
      },
    );
  }
}