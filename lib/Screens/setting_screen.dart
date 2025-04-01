import 'package:douga2/service/firebaseService/auth_service.dart';
import 'package:douga2/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/UserUtils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // Settings state variables
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPublishEnabled = false;
  String _selectedLanguage = 'English';

  // List of available languages
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Portuguese'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildSettingsList(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildSettingsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        _buildProfileSection(),
        const SizedBox(height: 24),
        _buildGeneralSettingsSection(),
        const SizedBox(height: 24),
        _buildNotificationSettingsSection(),
        const SizedBox(height: 24),
        _buildAccountSettingsSection(),
        const SizedBox(height: 24),

        // Add logout button here before Danger Zone
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildLogoutButton(),
        ),
        const SizedBox(height: 24),
        _buildDangerZoneSection(),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<Map<String, dynamic>>( // Use FutureBuilder to fetch user data
        future: UserUtils.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading profile: ${snapshot.error}")); // Show error message
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            final userName = userData['name'] ?? 'User Name'; 
            final userEmail = userData['email'] ?? 'email@example.com';

            return Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                  child: const Icon(
                    Iconsax.user,
                    size: 40,
                    color: Colors.purpleAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName, // Display dynamic user name
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail, // Display dynamic user email
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _editProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No user data found.")); // Handle case with no data
          }
        },
      ),
    );
  }

  Widget _buildGeneralSettingsSection() {
    return _buildSettingsCard(
      title: 'General Settings',
      icon: Iconsax.setting_2,
      children: [
        _buildSwitchListTile(
          title: 'Dark Mode',
          subtitle: 'Switch between light and dark themes',
          icon: Iconsax.moon,
          value: _darkModeEnabled,
          onChanged: (bool value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
        _buildDropdownListTile(
          title: 'Language',
          subtitle: 'Select your preferred language',
          icon: Iconsax.language_circle,
          value: _selectedLanguage,
          items: _languages,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNotificationSettingsSection() {
    return _buildSettingsCard(
      title: 'Notifications',
      icon: Iconsax.notification,
      children: [
        _buildSwitchListTile(
          title: 'Enable Notifications',
          subtitle: 'Receive updates and alerts',
          icon: Iconsax.notification_status,
          value: _notificationsEnabled,
          onChanged: (bool value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
        ),
        _buildSwitchListTile(
          title: 'Auto Publish',
          subtitle: 'Automatically publish content',
          icon: Iconsax.export,
          value: _autoPublishEnabled,
          onChanged: (bool value) {
            setState(() {
              _autoPublishEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAccountSettingsSection() {
    return _buildSettingsCard(
      title: 'Account Settings',
      icon: Iconsax.user,
      children: [
        _buildListTile(
          title: 'Connected Platforms',
          subtitle: 'Manage your social media connections',
          icon: Iconsax.link,
          onTap: _managePlatforms,
        ),
        _buildListTile(
          title: 'Change Password',
          subtitle: 'Update your account password',
          icon: Iconsax.lock,
          onTap: _changePassword,
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      height: 50,
      child: ActionButton(
        label: 'Log out',
        onPressed: () => _signout(context),
      ),
    );
  }

  Widget _buildDangerZoneSection() {
    return _buildSettingsCard(
      title: 'Danger Zone',
      icon: Iconsax.warning_2,
      color: const Color.fromARGB(26, 255, 0, 0),
      children: [
        _buildListTile(
          title: 'Delete Account',
          subtitle: 'Permanently remove your account',
          icon: Iconsax.trash,
          textColor: Colors.red,
          onTap: _deleteAccount,
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.purpleAccent),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      secondary: Icon(icon),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.purpleAccent,
    );
  }

  Widget _buildDropdownListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        underline: Container(),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: textColor),
      ),
      trailing: const Icon(Iconsax.arrow_right_3),
      onTap: onTap,
    );
  }

  // Action methods
  void _editProfile() {
    // TODO: Implement profile editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Profile clicked')),
    );
  }

  void _managePlatforms() {
    // TODO: Implement platform management
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Manage Platforms clicked')),
    );
  }

  void _changePassword() {
    // TODO: Implement password change
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Change Password clicked')),
    );
  }

  void _deleteAccount() {
    // TODO: Implement account deletion with confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'Are you sure you want to permanently delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () {
                // TODO: Implement actual account deletion logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deletion initiated')),
                );
              },
            ),
          ],
        );
      },
    );
  }

    void _signout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout',
          textAlign: TextAlign.center
          ),
          content: const Text('Are you sure you want to log out?',
          textAlign: TextAlign.center,),
          actions: <Widget>[
            Expanded(
              child: TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              ),
            ),
            Expanded(
              child: 
              ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                // Perform logout actions here
                AuthService authService = AuthService();
                await authService.signOut();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged Out Successfully!")),
                );
                Navigator.pushReplacementNamed(context, '/login');

                Navigator.of(context).pop(); // Close the dialog after logout
              },
            ),
            )
          ],
        );
      },
    );
  }
}