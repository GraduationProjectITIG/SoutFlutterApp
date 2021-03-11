import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

class PostBloc extends BaseBloc {
static final PostModel post = PostModel();
static List<PostModel> list = [];

  final BehaviorSubject<PostModel> _postController =
      BehaviorSubject<PostModel>.seeded(post);

  final BehaviorSubject<List<PostModel>> _postListController =
      BehaviorSubject<List<PostModel>>.seeded(list);

  Stream<PostModel> get postStream => _postController.stream;

Stream<PostModel> get postListStream => _postListController.stream;

  // Future getAllPosts() async {
  //   await  post.getAllPosts().then((value){
  //     _postListController.add(value);
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _postController.drain();
    _postController.close();
  }
}
