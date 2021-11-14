import 'package:ecoinclution_proyect/repository/user_repository.dart';
import 'package:ecoinclution_proyect/routes/route_generator.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:ecoinclution_proyect/views/main/tabs_view.dart';
import 'package:ecoinclution_proyect/views/views.dart';
import 'package:ecoinclution_proyect/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'models/models_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:ecoinclution_proyect/my_widgets/notifications/_notification_service.dart';


NotificationApi notification = NotificationApi();

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelsManager()),

        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  UserRepository userRepository = UserRepository();
  @override
  void initState() {
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: MyManager(),
      placeholderWidget: Center(
        child: CircularProgressIndicator()
      ),
      builder: (ThemeMode themeMode){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context){
            AppLocalizations? t = AppLocalizations.of(context);
            return t!.welcomeTitle;
          },
          title: 'EcoCordoba',
          theme: CustomTheme.lightTheme,
          highContrastTheme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
          home: FutureBuilder<bool>(
              future: userRepository.hasToken(id: 0),
              builder: (context,snapshot) {

                notification.showScheduleNotification(5, "Hola, querido/a Usuario", "hace click para hacer un deposito");

                if (snapshot.hasData){
                  if (snapshot.data!){
                    return HomePage();
                  }else{
                    return WelcomePage();
                  }
                }
                return Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/gifs/loading.gif",
                    width: 200, // con estas proporciones
                    height: 200,
                  ),
                );
              }
          ),
        );
      },
    );
  }


}