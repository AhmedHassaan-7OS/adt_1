import 'package:adt_1/bloc/bloc/fetch_product_bloc.dart';
import 'package:adt_1/bloc/bloc/search_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adt_1/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FetchProductBloc()..add(FetchProducts())),
        BlocProvider(create: (context) => SearchProductBloc()),
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dummy Products',
        home: HomeScreen(),
        ),
      );
  }
}
