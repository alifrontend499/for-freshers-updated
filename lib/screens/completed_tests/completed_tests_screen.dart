import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/components/navigation_drawer/navigation_drawer.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/widgets/no_data_found_widget.dart';

// -- screens
import 'package:forfreshers_app/screens/completed_tests/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/completed_tests/loading/completed_tests_screen_loading.dart';
import 'package:forfreshers_app/screens/completed_tests/widgets/completed_test_card_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';

class CompletedTestsScreen extends StatefulWidget {
  const CompletedTestsScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTestsScreen> createState() => _CompletedTestsScreenState();
}

class _CompletedTestsScreenState extends State<CompletedTestsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<CompletedTestModel>> testsData;
  final String tempCardImg =
      'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg';

  @override
  void initState() {
    super.initState();

    // data assignment
    testsData = getTestsData();
  }

  // getting tests data
  Future<List<CompletedTestModel>> getTestsData() async {
    final List<CompletedTestModel> completedTests =
        await getCompletedTestsHelper();
    print('completedTests $completedTests');
    return completedTests;
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
              ((context, AsyncSnapshot<List<CompletedTestModel>> snapshot) {
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
                final List<CompletedTestModel> testsData = snapshot.data!;
                if (testsData.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: appSettingsPagePadding,
                      itemCount: testsData.length,
                      itemBuilder: ((context, index) {
                        final CompletedTestModel completedTestItem =
                            testsData[index];
                        return Column(
                          children: [
                            completeTestsScreenCardWidget(
                              context,
                              completedTestItem,
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
