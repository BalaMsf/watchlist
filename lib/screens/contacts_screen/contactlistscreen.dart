import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/Constacts_bloc/contacts_list_bloc.dart';
import 'package:watchlist/commonWidgets/sort_widget.dart';
import 'package:watchlist/constants/textconstants.dart';
import 'package:watchlist/screens/contacts_screen/contacts_widgets/contactlist.dart';
import 'package:watchlist/screens/contacts_screen/contacts_widgets/searchview.dart';
import 'package:watchlist/screens/contacts_screen/contacts_widgets/watchlist.dart';

class ContactlistScreen extends StatelessWidget {
  const ContactlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocListener<ContactsListBloc, ContactsListState>(
        listener: (context, state) {
          if (state is ShowSortingpopupState) {
            BlocProvider.value(
                value: BlocProvider.of<ContactsListBloc>(context),
                child: showSortWidget(
                    context, state.sortList, state.watchlistModel));
          }
        },
        child: buildAppbody(context),
      ),
    );
  }

  Widget buildAppbody(context) {
    return Column(
      children: [
        const WatchList(),
        Expanded(
          child: Stack(children: [
            Column(
              children: [
                Container(height: 35, color: Colors.white),
                Container(height: 40, color: Colors.white),
                const Contactlist()
              ],
            ),
            SearchView(),
          ]),
        ),
      ],
    );
  }

  buildAppBar(context) {
    return AppBar(
      leading: Icon(
        Icons.menu,
        size: 30,
        color: Colors.black,
      ),
      elevation: 0,
      toolbarHeight: 60,
      title: Text(TextConstants.watchlistHeadertxt,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[],
    );
  }

  watchlistDoneAction(value, context) {
    if (value != "") {
      BlocProvider.of<ContactsListBloc>(context)
          .add(WatchListAddedEvent(listName: value));
    }
  }
}
