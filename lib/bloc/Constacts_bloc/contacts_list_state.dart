part of 'contacts_list_bloc.dart';

@immutable
abstract class ContactsListState {}

class ContactsListInitialState extends ContactsListState {}

class ContactsloadingState extends ContactsListState {}

class ContactsloadingErrorState extends ContactsListState {
  final String message;
  ContactsloadingErrorState({required this.message});
}

class ContactslistSuccessState extends ContactsListState {
  final List<Contactlistmodel> contactslist;
  ContactslistSuccessState({required this.contactslist});
}

//for search
class ContactslistSearchEmptyState extends ContactsListState {
  final String message;
  ContactslistSearchEmptyState({required this.message});
}

class ContactslistSearchResultState extends ContactsListState {
  final List<Contactlistmodel> contactslist;
  ContactslistSearchResultState({required this.contactslist});
}

//For watchlist
class WatchListAddpopupState extends ContactsListState {
  final List<WatchlistModel> watchlist;
  WatchListAddpopupState({required this.watchlist});
}

class ClearSerchState extends ContactsListState {}

class WatchListLoadState extends ContactsListState {
  final List<WatchlistModel> watchlist;
  final int selectedIndex;

  WatchListLoadState({required this.watchlist, required this.selectedIndex});
}

class SearchViewEnableState extends ContactsListState {
  final bool enabled;
  SearchViewEnableState({required this.enabled});
}

class SortUIEnableState extends ContactsListState {
  final bool enabled;
  SortUIEnableState({required this.enabled});
}
//For sorting
class ShowSortingpopupState extends ContactsListState {
  final List<String> sortList;
  final  WatchlistModel watchlistModel;

  ShowSortingpopupState({required this.sortList,required this.watchlistModel});
}

class StartSortListState extends ContactsListState {
  final List<Contactlistmodel> contactslist;
  StartSortListState({required this.contactslist});
}
