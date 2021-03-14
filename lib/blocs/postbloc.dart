import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

class PostBloc extends BaseBloc {
  static final PostModel postModel = PostModel();
  static List<PostModel> allPostslist = [];
  static List<PostModel> userPostsList = [];
  static List<PostModel> talentPostsList = [];

  final BehaviorSubject<PostModel> _postController =
      BehaviorSubject<PostModel>.seeded(postModel);

  final BehaviorSubject<List<PostModel>> _postListController =
      BehaviorSubject<List<PostModel>>.seeded(allPostslist);

  final BehaviorSubject<List<PostModel>> _userPostsListController =
      BehaviorSubject<List<PostModel>>.seeded(userPostsList);

  final BehaviorSubject<List<PostModel>> _talentPostsListController =
      BehaviorSubject<List<PostModel>>.seeded(talentPostsList);

  Stream<PostModel> get postStream => _postController.stream;

  Stream<List<PostModel>> get postListStream => _postListController.stream;

  Stream<List<PostModel>> get userPostListStream =>
      _userPostsListController.stream;

  Stream<List<PostModel>> get talentPostsListStream =>
      _talentPostsListController.stream;

  Future getAllPosts() async {
    await postModel.getAllPosts().then((value) {
      _postListController.add(value);
    });
  }

  Future getAllUserPosts(userId) async {
    await postModel.getAllUserPosts(userId).then((value) {
      _userPostsListController.add(value);
    });
  }

  Future deletePost(id) async {
    await postModel.deletePost(id);
  }

  Future getPostsbyTalent(talentId) async {
    await postModel.getPostsbyTalent(talentId).then((value) {
      _talentPostsListController.add(value);
    });
  }

  Future addPost(post) async {
    await postModel.addPost(post);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _postController.drain();
    _postController.close();
  }
}
