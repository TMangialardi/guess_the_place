import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/pages/about_page.dart';
import 'package:guess_the_place/pages/account_page.dart';
import 'package:guess_the_place/pages/arcade_page.dart';
import 'package:guess_the_place/pages/final_result_page.dart';
import 'package:guess_the_place/pages/history_page.dart';
import 'package:guess_the_place/pages/leaderboard_page.dart';
import 'package:guess_the_place/pages/login_page.dart';
import 'package:guess_the_place/pages/match_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ByteData data = await PlatformAssetBundle().load('assets/ca/certificate.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkThemeEnabled = ref.watch(darkThemeProvider);

    final lightTokens = MoonTokens.light.copyWith(
      colors: MoonColors.light,
      typography: MoonTypography.typography.copyWith(
        heading: MoonTypography.typography.heading.apply(
          fontFamily: "DMSans",
          fontWeightDelta: -1,
          fontVariations: [const FontVariation('wght', 500)],
        ),
      ),
    );

    final darkTokens = MoonTokens.dark.copyWith(
      colors: MoonColors.dark,
      typography: MoonTypography.typography.copyWith(
        heading: MoonTypography.typography.heading.apply(
          fontFamily: "DMSans",
          fontWeightDelta: -1,
          fontVariations: [const FontVariation('wght', 500)],
        ),
      ),
    );

    final lightTheme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: lightTokens)],
    );

    final darkTheme = ThemeData.dark().copyWith(
      extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: darkTokens)],
    );

    return MaterialApp(
      title: 'Guess the Place',
      initialRoute: '/',
      routes: {
        '/about': (context) => const AboutPage(),
        '/login': (context) => const LoginPage(),
        '/arcadeLogin': (context) => const ArcadePage(),
        '/account': (context) => const AccountPage(),
        '/match': (context) => const MatchPage(),
        '/result': (context) => const FinalResultPage(),
        '/history': (context) => const HistoryPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
      },
      theme: darkThemeEnabled ? darkTheme : lightTheme,
      home: HomePage(darkThemeEnabled: darkThemeEnabled),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
