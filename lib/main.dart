import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_bloc.dart';
import 'package:adt_1/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => ProductBloc()..add(FetchProducts()),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dummy Products',
        home: HomeScreen(),
        ),
      );
  }
}
