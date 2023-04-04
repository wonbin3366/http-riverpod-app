import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_riverpod_app/model/post/post.dart';

//같은페이지에 관리자 창고 데이터 넣은이유 : 따로분리할필요없어서


// 창고 관리자 (Provider)
final postHomePageProvider = StateNotifierProvider<PostHomePageViewModel, PostHomePageModel?>((ref) {
  return PostHomePageViewModel(null);
});

// 창고(store)
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  void init(List<Post> postDtoList){
    state = PostHomePageModel(posts: postDtoList);
  }
 // state값은 기존 state 값을 넣는다고 변경안된다 무조건 새로운 값을 넣어야한다.
  void add(Post post) {
    List<Post> posts = state!.posts;
    List<Post> newPosts = [...posts, post];//추가, 삭제, 수정, 검색
    state = PostHomePageModel(posts: newPosts); //레퍼런스가 달라지면 된다(값이 동일해도 다시 그린다)
  }

  void remove(int id){
    List<Post> posts = state!.posts;
    // where = 검색과 삭제할때 쓴다
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    state = PostHomePageModel(posts: newPosts);
  }

  void update(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }

}

// 창고 데이터
class PostHomePageModel {
  List<Post> posts;
  PostHomePageModel({required this.posts});
}
