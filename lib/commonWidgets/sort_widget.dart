import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/constants/sizes.dart';
import 'package:watchlist/constants/textconstants.dart';

import '../bloc/Constacts_bloc/contacts_list_bloc.dart';

showSortWidget(context, sortList, sortModel) {
  int rowsSortTag = (sortModel.sortIndex > 2 ? 1 : 0);
  var sortList1 = sortList;
  int selectedIndex = sortModel.sortIndex <= 0 ? -1 : (sortModel.sortIndex - 1);

  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (contexts) {
        Widget sortOptionsWidget(
            String name, index, bool isSelected, setState) {
          selectedIndex =
              selectedIndex >= 2 ? (selectedIndex - 2) : selectedIndex;
          return Builder(builder: (contexts) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              rowsSortTag = 0;
                            });
                            BlocProvider.of<ContactsListBloc>(context)
                                .add(SortlisClicktEvent(clickIndex: index + 1));
                          },
                          child: Text(name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18))),
                    ),
                    Visibility(
                      visible: selectedIndex == index,
                      replacement: const SizedBox(height: 45),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              rowsSortTag = rowsSortTag == 0 ? 1 : 0;
                              sortList1 = sortList;
                            });
                            BlocProvider.of<ContactsListBloc>(context).add(
                                SortlisClicktEvent(
                                    clickIndex: index +
                                        (rowsSortTag == 1 ? 3 : (index + 1))));
                          },
                          icon: Icon(
                            rowsSortTag == 1
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
                Divider(
                  thickness: index == (sortList.length - 1) ? 0 : 1,
                  color: Colors.grey[300],
                ),
              ],
            );
          });
        }

        return StatefulBuilder(
            builder: (BuildContext contexts, StateSetter setState) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  right: 30,
                  left: 30,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                  height: Sizefactors.sortPopupHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            TextConstants.sorttxt,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedIndex = -1;
                                });
                                BlocProvider.of<ContactsListBloc>(context)
                                    .add(SortlisClicktEvent(clickIndex: 0));
                              },
                              child: Visibility(
                                visible: sortModel.sortIndex != 0,
                                child: Text(TextConstants.resettxt,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(sortList1.length, (index) {
                          return sortOptionsWidget(
                              sortList1[index], index, false, setState);
                        }),
                      ),
                    ],
                  )));
        });
      });
}
