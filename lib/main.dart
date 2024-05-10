import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_service/auth/bloc/auth_bloc.dart';
import 'package:second_service/content/field_schedule/field_schedule_provider.dart';
import 'package:second_service/firebase_options.dart';
import 'package:second_service/forms/players_forms/players_provider.dart';
import 'package:second_service/forms/reservation_match_forms/reservation_provider.dart';
import 'package:second_service/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:second_service/login/login_page.dart';
//import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      ),
      ChangeNotifierProvider(create: (context) => FieldScheduleProvider()),
      ChangeNotifierProvider(create: (context) => ReservationProvider()),
      ChangeNotifierProvider(create: (context) => PlayersProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Second Service',
        home: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        }, listener: (context, state) {
          if (state is AuthErrorState) {
            print("Error al autenticar");
            print(state);
          }
        }));
  }
}
