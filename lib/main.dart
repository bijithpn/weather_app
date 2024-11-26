import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weather_app/src/core/core.dart';
import 'package:weather_app/src/data/services/network_service.dart';

import 'src/cubit/cubit.dart';
import 'src/data/repositories/weather_repository.dart';
import 'src/view/view.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserNotification.init(navigatorKey);
  runApp(MyApp(navigatorKey: navigatorKey));
  initNoInternetListener();
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WeatherCubit(WeatherRepository())),
        BlocProvider(create: (_) => NetworkCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Weather App',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}
