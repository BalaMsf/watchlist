import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/NetworkServices/NetworkServices.dart';
import 'package:watchlist/constants/textconstants.dart';
import 'package:watchlist/models/contactlistmodel.dart';
import 'package:watchlist/models/watchlistModel.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactsListBloc() : super(ContactsListInitialState()) {
    List<Contactlistmodel> contactsList = [];
    List<Contactlistmodel> currentList = [];

    List<WatchlistModel> watchlistArray = [
      WatchlistModel(
          sortIndex: 0, watchlistIndex: 1, watchlistName: "WatchList 1"),
      WatchlistModel(
          sortIndex: 0, watchlistIndex: 1, watchlistName: "WatchList 2"),
      WatchlistModel(
          sortIndex: 0, watchlistIndex: 1, watchlistName: "WatchList 3")
    ];

    int selectedWatchlistIndex = 0;
    List<String> sortList = [
      "A-Z  UserName ",
      "A-Z  Contacts ",
    ];

    List<Contactlistmodel> getFilteredList() {
      int indexvalue = selectedWatchlistIndex * 10;
      final filteredContactsList = (contactsList.where((element) =>
          (int.parse(element.id ?? "0") > indexvalue &&
              int.parse(element.id ?? "0") <= indexvalue + 10))).toList();
      currentList = filteredContactsList;
      return filteredContactsList;
    }

    sortValues(int sortingTag) {
      final vals = watchlistArray[selectedWatchlistIndex];
      vals.sortIndex = sortingTag;
      watchlistArray[selectedWatchlistIndex] = vals;
      List<Contactlistmodel> templist = currentList;
      if (sortingTag == 1) {
        templist.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
      } else if (sortingTag == 3) {
        templist.sort((a, b) {
          return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
        });
      } else if (sortingTag == 2) {
        templist.sort((a, b) {
          return a.contacts!.toLowerCase().compareTo(b.contacts!.toLowerCase());
        });
      } else if (sortingTag == 4) {
        templist.sort((a, b) {
          return b.contacts!.toLowerCase().compareTo(a.contacts!.toLowerCase());
        });
      } else {
        templist = getFilteredList();
      }

      if (templist.isEmpty) {
        emit((ContactslistSearchEmptyState(
            message: contactsList.isEmpty
                ? TextConstants.somethingwentwrongtxt
                : TextConstants.searchEmptytxt)));
      } else {
        emit((ContactslistSuccessState(contactslist: templist)));
      }
      emit(SortUIEnableState(enabled: sortingTag != 0 ? true : false));
    }

    List<Contactlistmodel> filterSerchvalues(String txt) {
      final filteredContactlist = getFilteredList();
      final vals = filteredContactlist
          .where((element) => (element.name ?? "").contains(txt))
          .toList();
      currentList = vals;
      return vals;
    }

    getApiValues() async {
      emit((ContactsloadingState()));
      final myContactslist = (await NetworkService().getContactlist())!;
      if (myContactslist.isEmpty) {
        emit((ContactsloadingErrorState(
            message: TextConstants.somethingwentwrongtxt)));
      } else {
        contactsList = myContactslist;
        final vals = getFilteredList();
        emit((ContactslistSuccessState(contactslist: vals)));
      }
      emit(SearchViewEnableState(enabled: contactsList.isNotEmpty));
    }

    searchResult(event) {
      final contactslistFiltervalue = filterSerchvalues(event.searchtext);
      if (contactslistFiltervalue.isEmpty) {
        emit((ContactslistSearchEmptyState(
            message: contactsList.isEmpty
                ? TextConstants.somethingwentwrongtxt
                : TextConstants.searchEmptytxt)));
      } else {
        emit((ContactslistSearchResultState(
            contactslist: contactslistFiltervalue)));
      }
    }

    watchlistChangeResult(event) {
      emit((ClearSerchState()));
      selectedWatchlistIndex = event.clickIndex;
      if (contactsList.isEmpty) {
        emit(WatchListLoadState(
            watchlist: watchlistArray, selectedIndex: selectedWatchlistIndex));
      } else {
        final vals = getFilteredList();
        emit((ContactslistSuccessState(contactslist: vals)));
        emit(WatchListLoadState(
            watchlist: watchlistArray, selectedIndex: selectedWatchlistIndex));
        if (vals.isEmpty) {
          emit((ContactslistSearchEmptyState(
              message: contactsList.isEmpty
                  ? TextConstants.somethingwentwrongtxt
                  : TextConstants.searchEmptytxt)));
        }
        emit(SearchViewEnableState(enabled: contactsList.isNotEmpty));
      }

      if (watchlistArray[selectedWatchlistIndex].sortIndex != 0) {
        sortValues(watchlistArray[selectedWatchlistIndex].sortIndex);
      }
    }

    on<ContactsListEvent>((event, emit) {
      if (event is ContactsLoadEvent) {
        emit(WatchListLoadState(
            watchlist: watchlistArray, selectedIndex: selectedWatchlistIndex));
        getApiValues();
      } else if (event is ContactsSearchEvent) {
        searchResult(event);
      } else if (event is WatchListClickEvent) {
        watchlistChangeResult(event);
      } else if (event is ShowSortUIEvent) {
        emit(ShowSortingpopupState(
            sortList: sortList,
            watchlistModel: watchlistArray[selectedWatchlistIndex]));
      } else if (event is SortlisClicktEvent) {
        sortValues(event.clickIndex);
      }
    });
  }
}
