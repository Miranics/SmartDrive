import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/services/preferences_service.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/utils/theme_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/providers/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String _appVersion = 'Loading...';
  bool _notifications = true;
  bool _studyReminders = true;
  bool _soundEffects = true;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    _loadPreferences();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  Future<void> _loadPreferences() async {
    final notifications = await PreferencesService.getNotifications();
    final studyReminders = await PreferencesService.getStudyReminders();
    final soundEffects = await PreferencesService.getSoundEffects();
    setState(() {
      _notifications = notifications;
      _studyReminders = studyReminders;
      _soundEffects = soundEffects;
    });
  }

  void _showProfile(BuildContext context) {
    final user = AuthService.currentUser;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ThemeHelper.getDialogBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF006FFF), Color(0xFF004299)],
                  ),
                ),
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                user?.displayName ?? 'User',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 24),
              _buildProfileRow('Status', user?.emailVerified == true ? 'Verified' : 'Not Verified'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600)),
        Text(value, style: GoogleFonts.montserrat(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ThemeHelper.getHeaderGradientStart(context),
                  ThemeHelper.getHeaderGradientEnd(context),
                ],
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text(
                  'Settings',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSettingSection(
                  'Account',
                  [
                    _buildSettingTile(
                      icon: Icons.person,
                      title: 'Profile',
                      onTap: () => _showProfile(context),
                    ),
                    _buildSettingTile(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSettingSection(
                  'Preferences',
                  [
                    _buildSettingTile(
                      icon: Icons.dark_mode,
                      title: 'Dark Mode',
                      trailing: Switch(
                        value: ref.watch(themeProvider) == ThemeMode.dark,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).setTheme(value);
                        },
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    _buildSettingTile(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      trailing: Switch(
                        value: _notifications,
                        onChanged: (value) async {
                          await PreferencesService.setNotifications(value);
                          setState(() => _notifications = value);
                        },
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    _buildSettingTile(
                      icon: Icons.alarm,
                      title: 'Study Reminders',
                      trailing: Switch(
                        value: _studyReminders,
                        onChanged: (value) async {
                          await PreferencesService.setStudyReminders(value);
                          setState(() => _studyReminders = value);
                        },
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    _buildSettingTile(
                      icon: Icons.volume_up,
                      title: 'Sound Effects',
                      trailing: Switch(
                        value: _soundEffects,
                        onChanged: (value) async {
                          await PreferencesService.setSoundEffects(value);
                          setState(() => _soundEffects = value);
                        },
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    _buildSettingTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSettingSection(
                  'About',
                  [
                    _buildSettingTile(
                      icon: Icons.info,
                      title: 'App Version',
                      subtitle: _appVersion,
                    ),
                    _buildSettingTile(
                      icon: Icons.description,
                      title: 'Terms & Conditions',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await AuthService.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/homepage',
                          (route) => false,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: Text(
                      'Logout',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlue,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1A1A2E)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF0F3460)
              : AppColors.paleBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryBlue, size: 24),
      ),
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            )
          : null,
      trailing: trailing ??
          (onTap != null
              ? Icon(Icons.chevron_right, 
                  color: Theme.of(context).textTheme.bodyMedium?.color)
              : null),
      onTap: onTap,
    );
  }
}
