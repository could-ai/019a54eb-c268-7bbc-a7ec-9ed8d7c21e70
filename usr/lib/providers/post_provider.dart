import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class PostProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _supabase
          .from('posts')
          .select('''
            *,
            profiles:user_id (
              id,
              username,
              full_name,
              avatar_url
            ),
            post_likes:likes(count),
            post_comments:comments(count)
          ''')
          .order('created_at', ascending: false);

      _posts = (response as List).map((post) => Post.fromJson(post)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createPost({
    required String content,
    String? imageUrl,
    String? videoUrl,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      await _supabase.from('posts').insert({
        'user_id': userId,
        'content': content,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'created_at': DateTime.now().toIso8601String(),
      });

      await fetchPosts();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> likePost(String postId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      // Check if already liked
      final existing = await _supabase
          .from('likes')
          .select()
          .eq('user_id', userId)
          .eq('post_id', postId)
          .maybeSingle();

      if (existing != null) {
        // Unlike
        await _supabase
            .from('likes')
            .delete()
            .eq('user_id', userId)
            .eq('post_id', postId);
      } else {
        // Like
        await _supabase.from('likes').insert({
          'user_id': userId,
          'post_id': postId,
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      await fetchPosts();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      await _supabase.from('posts').delete().eq('id', postId);
      await fetchPosts();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}