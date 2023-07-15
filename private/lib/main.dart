import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal/core/colors.dart';
import 'package:personal/core/router.dart';
import 'package:personal/features/dashboard/logic/cubit/navigation_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  IconThemeData getIconThemeData(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const IconThemeData(color: Colors.white70, size: 20);
    }
    const Set<MaterialState> activeStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(activeStates.contains)) {
      return const IconThemeData(color: Colors.black87, size: 24);
    }
    return const IconThemeData(color: Colors.white30, size: 20);
  }

  TextStyle getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const TextStyle(color: Colors.white54, fontSize: 11);
    }
    const Set<MaterialState> activeStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(activeStates.contains)) {
      return const TextStyle(color: primarColor, fontSize: 11);
    }
    return const TextStyle(color: Colors.white30, fontSize: 11);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: primarColor,
            secondary: secondaryColor,
            tertiary: tertiaryColor,
            background: backgroundColor,
            surface: quaternaryColor,
            outline: Colors.white10,
            outlineVariant: Colors.white12,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.rubikTextTheme(
              ThemeData.dark(useMaterial3: true).textTheme),
        ).copyWith(
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: backgroundColor,
              surfaceTintColor: surfaceColor,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white, size: 24),
            ),
            cardTheme: CardTheme(
              color: Colors.black,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.white12, width: 2),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.black,
              elevation: 0,
              surfaceTintColor: surfaceColor,
              indicatorColor: primarColor,
              iconTheme: MaterialStateProperty.resolveWith(getIconThemeData),
              labelTextStyle: MaterialStateProperty.resolveWith(getColor),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            ),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                const Set<MaterialState> interactiveStates = <MaterialState>{
                  MaterialState.pressed,
                  MaterialState.hovered,
                  MaterialState.focused,
                };
                if (states.any(interactiveStates.contains)) {
                  return iconBackground.withAlpha(64);
                }
                const Set<MaterialState> activeStates = <MaterialState>{
                  MaterialState.selected,
                };
                if (states.any(activeStates.contains)) {
                  return iconBackground;
                }
                return iconBackground.withAlpha(180);
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                const baseColor = Colors.white;
                const Set<MaterialState> interactiveStates = <MaterialState>{
                  MaterialState.pressed,
                  MaterialState.hovered,
                  MaterialState.focused,
                };
                if (states.any(interactiveStates.contains)) {
                  return baseColor.withAlpha(64);
                }
                const Set<MaterialState> activeStates = <MaterialState>{
                  MaterialState.selected,
                };
                if (states.any(activeStates.contains)) {
                  return baseColor;
                }
                return baseColor.withAlpha(192);
              }),
            ))),
        themeMode: ThemeMode.dark,
        routerConfig: router,
      ),
    );
  }
}
