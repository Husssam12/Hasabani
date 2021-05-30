import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/database/daos/_export_daos.dart';
import 'package:flutter_app5/ui/add_person_screen/add_person_screen.dart';
import 'package:flutter_app5/ui/home_screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moor_inspector/moor_inspector.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'common/style/theme.dart';
import 'database/daos/persons_dao.dart';
import 'ui/add_item_screen/add_item_screen.dart';

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: SimpleLocationBuilder(
      routes: {
        "/": (context) => HomeScreen(),
        "/add_persons": (context) => AddPersonScreen(),
        "/add_items": (context) => AddItemScreen(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) {
            final AppDatabase appDatabase = AppDatabase();
            _initMoorInspector(appDatabase);
            return appDatabase;
          },
          dispose: (_, appDatabase) => appDatabase.close(),
        ),
        Provider<PersonsDao>(
          create: (context) =>
              Provider.of<AppDatabase>(context, listen: false).personsDao,
        ),
        Provider<ItemsDao>(
          create: (context) =>
              Provider.of<AppDatabase>(context, listen: false).itemsDao,
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            fontFamily: appFontFamily,
            primaryColorDark: Colors.blue.shade700,
            accentColor: Colors.lightBlueAccent,
            snackBarTheme: SnackBarThemeData(
                contentTextStyle: TextStyle(fontFamily: appFontFamily),
                backgroundColor: Colors.black26),
            textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
            brightness: Brightness.dark,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.lightBlueAccent)),
            ),
            outlinedButtonTheme:
                OutlinedButtonThemeData(style: outlineButtonStyle),
            bottomSheetTheme: BottomSheetThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
            cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        supportedLocales: [Locale('ar', 'SY')],
        locale: Locale('ar', 'SY'),
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: 'MOBILE'),
              ResponsiveBreakpoint.autoScale(800, name: 'TABLET'),
              ResponsiveBreakpoint.resize(1000, name: 'DESKTOP'),
            ],
            // debugLog: true,
            background: Container(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  Future<void> _initMoorInspector(AppDatabase appDatabase) async {
    final moorInspectorBuilder = MoorInspectorBuilder()
      ..bundleId = 'com.example.flutter_app5'
      ..icon = 'flutter'
      ..addDatabase('AppDatabase', appDatabase);
    final inspector = moorInspectorBuilder.build();
    await inspector.start();
  }
}
