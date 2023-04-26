part of 'contacts_list_bloc.dart';

@immutable
abstract class ContactsListEvent {}

class ContactsLoadEvent extends ContactsListEvent {}

class ContactsSearchEvent extends ContactsListEvent {
  final String searchtext;
  ContactsSearchEvent({required this.searchtext});
}

//For watchlist
class WatchListAddActionClickEvent extends ContactsListEvent {}
 
class WatchListAddedEvent extends ContactsListEvent {
  final String listName;
  WatchListAddedEvent({required this.listName});
}
class WatchListClickEvent extends ContactsListEvent {
  final int clickIndex;
  WatchListClickEvent({required this.clickIndex});
}

class ContactlistRetryEvent extends ContactsListEvent {}


class ShowSortUIEvent extends ContactsListEvent {}

class SortlisClicktEvent extends ContactsListEvent {
  final int clickIndex;
  SortlisClicktEvent({required this.clickIndex});
}