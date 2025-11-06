import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  Profile? _currentProfile;
  bool _isLoading = false;
  String? _errorMessage;

  Profile? get currentProfile => _currentProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCurrentProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      _isLoading = true;
      notifyListeners();

      final response = await _supabase
          .from('profiles')
          .select('''
            *,
            followers:followers!followed_id(count),
            following:followers!follower_id(count),
            posts(count)
          ''')
          .eq('id', userId)
          .single();

      _currentProfile = Profile.fromJson(response);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Profile?> fetchProfileById(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select('''
            *,
            followers:followers!followed_id(count),
            following:followers!follower_id(count),
            posts(count)
          ''')
          .eq('id', userId)
          .single();

      return Profile.fromJson(response);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    String? username,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (username != null) updates['username'] = username;
      if (bio != null) updates['bio'] = bio;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

      await _supabase.from('profiles').update(updates).eq('id', userId);

      await fetchCurrentProfile();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> followUser(String userId) async {
    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) return false;

      // Check if already following
      final existing = await _supabase
          .from('followers')
          .select()
          .eq('follower_id', currentUserId)
          .eq('followed_id', userId)
          .maybeSingle();

      if (existing != null) {
        // Unfollow
        await _supabase
            .from('followers')
            .delete()
            .eq('follower_id', currentUserId)
            .eq('followed_id', userId);
      } else {
        // Follow
        await _supabase.from('followers').insert({
          'follower_id': currentUserId,
          'followed_id': userId,
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      await fetchCurrentProfile();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<String?> uploadAvatar(String filePath) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final fileExt = filePath.split('.').last;
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _supabase.storage.from('avatars').upload(fileName, filePath);

      final avatarUrl = _supabase.storage.from('avatars').getPublicUrl(fileName);

      await updateProfile(avatarUrl: avatarUrl);
      return avatarUrl;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}