import 'package:get_it/get_it.dart';

import 'app/app_bloc.dart';
import 'base_bloc.dart';
import 'blocs/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';


final GetIt sL = GetIt.I;
final Set<BaseBloc> usedBlocs = <BaseBloc>{};

Future<void> setupLocators() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString("language");
  final AppBloc appBloc = AppBloc(locale: locale);
  final UserBloc userBloc = UserBloc();
  final PostBloc postBloc = PostBloc();
  final ChatBloc chatBloc = ChatBloc();
  final MessageBloc messageBloc = MessageBloc();
  // final InsterestBloc interestBloc = InsterestBloc();

  usedBlocs.add(appBloc);
  usedBlocs.add(userBloc);
  usedBlocs.add(postBloc);
  usedBlocs.add(chatBloc);
  usedBlocs.add(messageBloc);
  // usedBlocs.add(interestBloc);

  sL.registerSingleton<AppBloc>(appBloc);
  sL.registerSingleton<UserBloc>(userBloc);
  sL.registerSingleton<PostBloc>(postBloc);
  sL.registerSingleton<ChatBloc>(chatBloc);
  sL.registerSingleton<MessageBloc>(messageBloc);
  // sL.registerSingleton<InsterestBloc>(interestBloc);
}

void disposeBlocs() {
  for (final BaseBloc bloc in usedBlocs) {
    bloc.dispose();
  }
}
