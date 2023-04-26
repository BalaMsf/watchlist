import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/Constacts_bloc/contacts_list_bloc.dart';
import 'package:watchlist/constants/textconstants.dart';

class Contactlist extends StatelessWidget {
  const Contactlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ContactsListBloc>(context),
      buildWhen: (ContactsListState prevState, ContactsListState currentState) {
        return currentState is ContactsloadingState ||
            currentState is ContactsloadingErrorState ||
            currentState is ContactslistSuccessState ||
            currentState is ContactslistSearchResultState ||
            currentState is ContactslistSearchEmptyState;
      },
      builder: (context, state) {
        if (state is ContactsloadingState) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor));
        } else if (state is ContactslistSuccessState) {
          return buildDataList(state.contactslist, context);
        } else if (state is ContactsloadingErrorState) {
          return showErrorView(state.message, context);
        } else if (state is ContactslistSearchResultState) {
          return buildDataList(state.contactslist, context);
        } else if (state is ContactslistSearchEmptyState) {
          return showMessage(state.message, context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildDataList(contactsList, context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text((contactsList[index].name ?? "").toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                Text(
                  contactsList[index].contacts ?? "",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
              ],
            ),
            // trailing: const Icon(Icons.contact_phone, size: 35)
            leading: CircleAvatar(
              // backgroundImage: NetworkImage(userList[index].url.toString()),
              backgroundImage: NetworkImage(
                  'https://pm.epages.com/WebRoot/Store/Shops/apidocu/51E7/F905/2E4C/78C2/30C2/AC14/145F/A4E5/013-headphone-red_m.jpg'),
            ),
          );
        },
      ),
    );
  }

  Widget showMessage(String message, context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 200),
          Text(
            message,
            style: TextStyle(
                fontSize: 22.0,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget showErrorView(String message, context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 200),
          Text(
            message,
            style: TextStyle(
                fontSize: 22.0,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<ContactsListBloc>(context)
                    .add(ContactlistRetryEvent());
              },
              child: Text(
                TextConstants.retrytxt,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ))
        ],
      ),
    );
  }
}
