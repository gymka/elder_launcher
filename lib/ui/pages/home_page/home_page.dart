import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/edit_mode.dart';
import '../../../generated/l10n.dart';
import '../../../providers/date_time_provider.dart';
import '../../../ui/pages/home_page/apps_tab.dart';
import '../../../ui/pages/home_page/contacts_tab.dart';
import '../../../ui/pages/home_page/edit_dialog.dart';
import '../../../ui/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _appBarTextSizeGroup = AutoSizeGroup();

    void openEditDialog(int tabIndex) {
      EditMode editMode;

      if (tabIndex == 0) {
        editMode = EditMode.apps;
      } else {
        editMode = EditMode.contacts;
      }

      EditDialog(context, editMode);
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: ChangeNotifierProvider(
        create: (_) => DateTimeProvider(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (DefaultTabController.of(context) != null) {
                      openEditDialog(DefaultTabController.of(context)!.index);
                    }
                  },
                ),
              ),
            ],
            centerTitle: true,
            title: Consumer<DateTimeProvider>(
              builder: (_, dateTimeProvider, __) => AutoSizeText(
                dateTimeProvider.time,
                maxLines: 1,
                style: TextStyles.headerTime,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(0, 80),
              child: Column(
                children: <Widget>[
                  Consumer<DateTimeProvider>(
                    builder: (_, dateTimeProvider, __) => AutoSizeText(
                      dateTimeProvider.date,
                      group: _appBarTextSizeGroup,
                      maxLines: 1,
                      style: TextStyles.headerDate,
                    ),
                  ),
                  TabBar(tabs: [
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                              child: Icon(Icons.apps),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                S.of(context).Apps,
                                group: _appBarTextSizeGroup,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                              child: Icon(Icons.contacts),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                S.of(context).Contacts,
                                group: _appBarTextSizeGroup,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 50),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          body: const TabBarView(children: <Widget>[AppsTab(), ContactsTab()]),
        ),
      ),
    );
  }
}
