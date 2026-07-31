import 'package:events/core/providers/app_event_provider.dart';
import 'package:events/core/providers/app_language_provider.dart';
import 'package:events/core/providers/app_theme_provider.dart';
import 'package:events/core/utils/app_theme.dart';
import 'package:events/feature/auth/register/register_page.dart';
import 'package:events/feature/homePage/add_event_page.dart';
import 'package:events/feature/homePage/home_page.dart';
import 'package:events/feature/homePage/tabs/favorite_tab.dart';
import 'package:events/feature/auth/login/login_page.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(languageProvider.appLanguage),
      title: 'Localizations Sample App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/register',
      routes: {
        '/': (context) => HomePage(),
        '/add_event': (context) => AddEventPage(),
        '/Favorite': (context) => FavoriteTab(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
