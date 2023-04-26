import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/Constacts_bloc/contacts_list_bloc.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsListBloc, ContactsListState>(
      bloc: BlocProvider.of<ContactsListBloc>(context),
      buildWhen: (ContactsListState prevState, ContactsListState currentState) {
        return currentState is WatchListLoadState;
      },
      builder: (context, state) {
        if (state is WatchListLoadState) {
          return buildWatchList(state.watchlist, context, state.selectedIndex);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildWatchList(watchlist, context, selectedWatchlistIndex) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        // color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(watchlist.length, (index) {
              return index == watchlist.length
                  ? buildAddlist()
                  : watchlistRow(
                      watchlist, context, selectedWatchlistIndex, index);
            }))));
  }

  Widget watchlistRow(watchlist, context, selectedWatchlistIndex, index) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              BlocProvider.of<ContactsListBloc>(context)
                  .add(WatchListClickEvent(clickIndex: index));
            },
            child: Text(
              watchlist[index].watchlistName.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            )),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget buildAddlist() {
    return SizedBox();
  }
}
