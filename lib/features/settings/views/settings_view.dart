import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/features/settings/controller/settings_bloc.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageBloc = context.read<SettingsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // App Settings Section
            _buildSectionHeader("appSettings".tr()),
            _buildSettingCard(
              context,
              icon: Icons.language_rounded,
              title: "language".tr(),
              subtitle: "changeAppLanguage".tr(),
              trailing: _buildLanguageDropdown(context, languageBloc),
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.palette_rounded,
              title: "theme".tr(),
              subtitle: "changeAppTheme".tr(),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),

            const SizedBox(height: 24),

            // Support Section
            _buildSectionHeader("support".tr()),
            _buildSettingCard(
              context,
              icon: Icons.help_center_rounded,
              title: "helpCenter".tr(),
              subtitle: "getHelpSupport".tr(),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.feedback_rounded,
              title: "sendFeedback".tr(),
              subtitle: "shareYourThoughts".tr(),
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // About Section
            _buildSectionHeader("about".tr()),
            _buildSettingCard(
              context,
              icon: Icons.info_rounded,
              title: "aboutApp".tr(),
              subtitle: "versionInfo".tr(),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.security_rounded,
              title: "privacyPolicy".tr(),
              subtitle: "readOurPolicy".tr(),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.description_rounded,
              title: "termsOfService".tr(),
              subtitle: "readTerms".tr(),
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // App Info
            _buildAppInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, SettingsBloc languageBloc) {
    return DropdownButton<String>(
      value: context.locale.languageCode,
      underline: const SizedBox(),
      icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[400]),
      items: [
        DropdownMenuItem(
          value: "en",
          child: Row(
            children: [
              Text("🇺🇸"),
              const SizedBox(width: 8),
              Text("english".tr()),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "ar",
          child: Row(
            children: [
              Text("🇸🇦"),
              const SizedBox(width: 8),
              Text("arabic".tr()),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          context.setLocale(Locale(value));
          languageBloc.add(LanguageChanged(value)); // Notify about language change
        }
      },
    );
  }
  Widget _buildAppInfo(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.settings_suggest_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "sama".tr(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "version 1.0.0",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "© 2024 Sama App. All rights reserved",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}