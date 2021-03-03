import 'package:get_it/get_it.dart';
import 'app/app_bloc.dart';
import 'base_bloc.dart';
// import 'blocs/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sL = GetIt.I;
final Set<BaseBloc> usedBlocs = <BaseBloc>{};

Future<void> setupLocators() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString("language");
  final AppBloc appBloc = AppBloc(locale: locale);
  // final UserBloc userBloc = UserBloc();
  // final CategoryBloc categoryBloc = CategoryBloc();
  // final CountryBloc countryBloc = CountryBloc();
  // final AdsBloc adsBloc = AdsBloc();
  // final StoreBloc storeBloc = StoreBloc();

  usedBlocs.add(appBloc);
  // usedBlocs.add(userBloc);
  // usedBlocs.add(categoryBloc);
  // usedBlocs.add(countryBloc);
  // usedBlocs.add(adsBloc);
  // usedBlocs.add(storeBloc);

  sL.registerSingleton<AppBloc>(appBloc);
  // sL.registerSingleton<UserBloc>(userBloc);
  // sL.registerSingleton<CategoryBloc>(categoryBloc);
  // sL.registerSingleton<CountryBloc>(countryBloc);
  // sL.registerSingleton<AdsBloc>(adsBloc);
  // sL.registerSingleton<StoreBloc>(storeBloc);
}

void disposeBlocs() {
  for (final BaseBloc bloc in usedBlocs) {
    bloc.dispose();
  }
}
