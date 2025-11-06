class Profile {
  final String id;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String? bio;
  final String? email;
  final DateTime? createdAt;
  final int followersCount;
  final int followingCount;
  final int postsCount;

  Profile({
    required this.id,
    this.username,
    this.fullName,
    this.avatarUrl,
    this.bio,
    this.email,
    this.createdAt,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      followersCount: json['followers'] != null
          ? (json['followers'] is List 
              ? (json['followers'] as List).length
              : (json['followers'] as Map<String, dynamic>)['count'] ?? 0)
          : 0,
      followingCount: json['following'] != null
          ? (json['following'] is List 
              ? (json['following'] as List).length
              : (json['following'] as Map<String, dynamic>)['count'] ?? 0)
          : 0,
      postsCount: json['posts'] != null
          ? (json['posts'] is List 
              ? (json['posts'] as List).length
              : (json['posts'] as Map<String, dynamic>)['count'] ?? 0)
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'bio': bio,
      'email': email,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}