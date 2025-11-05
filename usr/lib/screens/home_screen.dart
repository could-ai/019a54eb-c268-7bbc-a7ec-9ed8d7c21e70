import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';
import '../widgets/story_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            title: ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: const Text(
                'Tvog Social',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: () {},
              ),
            ],
          ),
          // Stories
          const SliverToBoxAdapter(
            child: StoryCarousel(),
          ),
          // Posts
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostCard(
                    userName: _getMockUserName(index),
                    userAvatar: _getMockAvatar(index),
                    timeAgo: '${index + 1}h ago',
                    content: _getMockContent(index),
                    likes: (index + 1) * 156,
                    comments: (index + 1) * 23,
                    shares: (index + 1) * 7,
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMockUserName(int index) {
    final names = [
      'Alex Chen',
      'Sarah Johnson',
      'Mike Rodriguez',
      'Emma Thompson',
      'David Kim',
      'Lisa Wang',
      'James Wilson',
      'Maria Garcia',
      'Ryan Foster',
      'Sophia Lee'
    ];
    return names[index % names.length];
  }

  String _getMockAvatar(int index) {
    return String.fromCharCode(65 + (index % 26));
  }

  String _getMockContent(int index) {
    final contents = [
      'Just launched my new project! Excited to share this journey with all of you. 🚀',
      'Beautiful sunset today. Sometimes we need to pause and appreciate the little things in life. 🌅',
      'Coffee and coding - the perfect combination for a productive morning! ☕️💻',
      'Grateful for this amazing community. You all inspire me every day! 💜',
      'New blog post is live! Check out my thoughts on the future of social media.',
      'Weekend vibes! What are your plans? Share below! 🎉',
      'Just finished an amazing book. Highly recommend it to everyone! 📚',
      'Exploring new places and meeting amazing people. Life is an adventure! 🗺️',
      'Working on something exciting. Stay tuned for updates! 👀',
      'Celebrating small wins today. Progress is progress! 🎯'
    ];
    return contents[index % contents.length];
  }
}