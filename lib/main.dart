import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/Constacts_bloc/contacts_list_bloc.dart';
import 'package:watchlist/screens/contacts_screen/contactlistscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => ContactsListBloc()..add(ContactsLoadEvent()),
          child: const ContactlistScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
