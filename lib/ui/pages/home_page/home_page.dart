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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 150) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

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
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool inSiderCorddd) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    toolbarHeight: 110,
                    backgroundColor: Color(0xff161b22),
                    centerTitle: true,
                    floating: false,
                    snap: false,
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            if (DefaultTabController.of(context) != null) {
                              openEditDialog(
                                  DefaultTabController.of(context)!.index);
                            }
                          },
                        ),
                      ),
                    ],
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: _isScrolled ? 1.0 : 0,
                        child: Column(
                          children: [
                            Consumer<DateTimeProvider>(
                              builder: (_, dateTimeProvider, __) =>
                                  AutoSizeText(
                                dateTimeProvider.time,
                                maxLines: 1,
                                style: TextStyles.headerTime,
                              ),
                            ),
                            TabBar(tabs: [
                              Tab(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                        child: Icon(Icons.apps),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          S.of(context).Apps,
                                          group: _appBarTextSizeGroup,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 20),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                        child: Icon(Icons.contacts),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          S.of(context).Contacts,
                                          group: _appBarTextSizeGroup,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        )),
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        centerTitle: true,
                        title: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _isScrolled ? 0.0 : 1.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Consumer<DateTimeProvider>(
                                builder: (_, dateTimeProvider, __) =>
                                    AutoSizeText(
                                  dateTimeProvider.time,
                                  maxLines: 1,
                                  style: TextStyles.headerTime,
                                ),
                              ),
                              Consumer<DateTimeProvider>(
                                builder: (_, dateTimeProvider, __) =>
                                    AutoSizeText(
                                  dateTimeProvider.date,
                                  maxLines: 1,
                                  style: TextStyles.headerDate,
                                ),
                              ),
                              TabBar(tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                        child: Icon(Icons.apps),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          S.of(context).Apps,
                                          group: _appBarTextSizeGroup,
                                          // maxLines: 1,
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                        child: Icon(Icons.contacts),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          S.of(context).Contacts,
                                          group: _appBarTextSizeGroup,
                                          // maxLines: 1,
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        )),
                  )
                ];
              },
              body: TabBarView(children: <Widget>[AppsTab(), ContactsTab()]),
            )),
      ),
    );
  }
}
