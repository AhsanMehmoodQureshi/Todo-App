import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/ui/home/home_bloc.dart';
import 'package:test_project/ui/home/home_screen.dart';
import 'package:test_project/ui/login/login_bloc.dart';
import 'package:test_project/ui/login/login_screen.dart';
import 'package:test_project/utils/color.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeBloc()),

      ],
      child: MaterialApp(
        title: 'Test Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,


          // Text field Theme
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              errorMaxLines: 2,
              iconColor: Colors.grey.shade300,
              suffixIconColor: AppColors.primary,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300))),

          // app bar theme
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),

          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, color: AppColors.primaryBtnText,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(25.0), // Adjust the radius as needed
              ),
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Padding
            ),
          ),
          // text theme
        ),
        //home: const LoginScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/HomeScreen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}


// TextStyle _getTextStyle({
//   required double fontSize,
//   required FontWeight fontWeight,
//   // FontWeight fontWeight = FontWeight.w600,
//   required Color color,
// }) {
//   return GoogleFonts.poppins(
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     color: color,
//   );
// }