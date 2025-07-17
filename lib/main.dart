import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/app.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
