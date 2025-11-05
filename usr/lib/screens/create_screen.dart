import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _contentController = TextEditingController();
  String _selectedPostType = 'text';

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {
              // Post logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post shared successfully! 🎉'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text(
              'Post',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryPurple,
                  child: const Text(
                    'U',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Name',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Public',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Content Input
            TextField(
              controller: _contentController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkCard
                    : Colors.grey[100],
              ),
            ),
            const SizedBox(height: 24),
            // Post Type Selection
            Text(
              'Add to your post',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildPostTypeButton(
                  icon: Icons.photo_library_rounded,
                  label: 'Photo',
                  type: 'photo',
                  gradient: AppTheme.accentGradient,
                ),
                _buildPostTypeButton(
                  icon: Icons.videocam_rounded,
                  label: 'Video',
                  type: 'video',
                  gradient: AppTheme.primaryGradient,
                ),
                _buildPostTypeButton(
                  icon: Icons.poll_rounded,
                  label: 'Poll',
                  type: 'poll',
                  gradient: AppTheme.vibrantGradient,
                ),
                _buildPostTypeButton(
                  icon: Icons.location_on_rounded,
                  label: 'Location',
                  type: 'location',
                  gradient: LinearGradient(
                    colors: [AppTheme.successGreen, AppTheme.secondaryBlue],
                  ),
                ),
                _buildPostTypeButton(
                  icon: Icons.emoji_emotions_rounded,
                  label: 'Feeling',
                  type: 'feeling',
                  gradient: LinearGradient(
                    colors: [AppTheme.warningOrange, AppTheme.accentPink],
                  ),
                ),
                _buildPostTypeButton(
                  icon: Icons.group_rounded,
                  label: 'Tag People',
                  type: 'tag',
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryPurple, AppTheme.secondaryBlue],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Quick Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkCard
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Settings',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingTile(
                    icon: Icons.comment_outlined,
                    title: 'Allow Comments',
                    value: true,
                  ),
                  _buildSettingTile(
                    icon: Icons.share_outlined,
                    title: 'Allow Sharing',
                    value: true,
                  ),
                  _buildSettingTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notify Followers',
                    value: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostTypeButton({
    required IconData icon,
    required String label,
    required String type,
    required Gradient gradient,
  }) {
    final isSelected = _selectedPostType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPostType = type;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected
              ? null
              : (Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkCard
                  : Colors.grey[100]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required bool value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {},
            activeColor: AppTheme.primaryPurple,
          ),
        ],
      ),
    );
  }
}