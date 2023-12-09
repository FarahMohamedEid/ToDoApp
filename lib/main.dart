import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/core/cubit/app_cubit/app_cubit.dart';
import 'package:todo_app/core/network/local/preference.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'core/shared/bloc_observer_manager.dart';
import 'feature/home/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getNotes(),
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: ColorsManager.primary, primary: ColorsManager.secondary),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
