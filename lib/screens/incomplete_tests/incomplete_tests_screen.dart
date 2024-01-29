import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/components/navigation_drawer/navigation_drawer.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/widgets/no_data_found_widget.dart';

// -- screens
import 'package:forfreshers_app/screens/incomplete_tests/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/incomplete_tests/loading/incomplete_tests_screen_loading.dart';
import 'package:forfreshers_app/screens/incomplete_tests/widgets/incomplete_test_card_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/saving_tests_progress_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';

class InCompleteTestsScreen extends ConsumerStatefulWidget {
  const InCompleteTestsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InCompleteTestsScreen> createState() => _InCompleteTestsScreenState();
}

class _InCompleteTestsScreenState extends ConsumerState<InCompleteTestsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<InCompleteTestsDataModel>> testsData;

  @override
  void initState() {
    super.initState();

    // data assignment
    testsData = getTestsData();
  }

  // getting tests data
  Future<List<InCompleteTestsDataModel>> getTestsData() async {
    final List<InCompleteTestsDataModel> incompleteTestsList =
        await getInCompleteTestsHelper();
    return incompleteTestsList;
  }

  // on pull to refresh
  Future<void> onRefresh() async {
    // resetting data
    setState(() {
      testsData = Future(() => []);
    });

    // assigning data
    testsData = getTestsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppNavigationDrawer(),
      appBar: getPageAppBar(context, scaffoldKey),
      body: WillPopScope(
        onWillPop: onWillPopHelper,
        child: FutureBuilder(
          future: testsData,
          builder:
              ((context, AsyncSnapshot<List<InCompleteTestsDataModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // loading
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ScreenLoading();
                },
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // if has data
                final List<InCompleteTestsDataModel> testsData = snapshot.data!;
                if (testsData.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: appSettingsPagePadding,
                      itemCount: testsData.length,
                      itemBuilder: ((context, index) {
                        final InCompleteTestsDataModel incompleteTestItem =
                            testsData[index];
                        return Column(
                          children: [
                            incompleteTestsScreenCardWidget(
                              context,
                              incompleteTestItem,
                              ref,
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      }),
                    ),
                  );
                }
                // no data
                return noDataFoundWidget();
              }
            }
            // show nothing while loading
            return const Text('');
          }),
        ),
      ),
    );
  }
}
