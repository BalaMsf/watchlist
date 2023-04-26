import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/Constacts_bloc/contacts_list_bloc.dart';
import 'package:watchlist/constants/textconstants.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsListBloc, ContactsListState>(
        listenWhen: (previous, current) {
      return current is ClearSerchState;
    }, listener: (context, state) {
      if (state is ClearSerchState) {
        searchController.text = "";
      }
    }, buildWhen: (previous, current) {
      return current is SearchViewEnableState || current is SortUIEnableState;
    }, builder: (context, state) {
      if (state is SearchViewEnableState) {
        return buildSearchView(context, state.enabled, false);
      } else if (state is SortUIEnableState) {
        return buildSearchView(context, true, state.enabled);
      } else {
        return buildSearchView(context, true, false);
      }
    });
  }

  Widget buildSearchView(context, bool iteractionState, isEnableSortUI) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      height: 90,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black)),
        child: Center(
          child: TextField(
            controller: searchController,
            enabled: iteractionState,
            onChanged: (term) {
              BlocProvider.of<ContactsListBloc>(context)
                  .add(ContactsSearchEvent(searchtext: term));
            },
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
              hintText: TextConstants.serachbartxt,
              prefixIcon:
                  const Icon(Icons.search, size: 28, color: Colors.black),
              suffixIcon: Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: () {
                      BlocProvider.of<ContactsListBloc>(context)
                          .add(ShowSortUIEvent());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
