import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/pages/about_page.dart';
import 'package:guess_the_place/pages/arcade_page.dart';
import 'package:guess_the_place/pages/login_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';
import 'pages/home_page.dart';

void main() {
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
      },
      theme: darkThemeEnabled ? darkTheme : lightTheme,
      home: HomePage(darkThemeEnabled: darkThemeEnabled),
    );
  }
}
