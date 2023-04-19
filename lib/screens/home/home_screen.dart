import 'package:flutter/material.dart';
import 'dart:convert';

// -- packages
import 'package:http/http.dart' as http;

// -- global
import 'package:forfreshers_app/global/components/navigation_drawer/navigation_drawer.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/widgets/no_data_found_widget.dart';

// -- screen
import 'package:forfreshers_app/screens/home/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/home/loading/home_screen_loading.dart';
import 'package:forfreshers_app/screens/home/widgets/test_view_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/helpers/json_helpers.dart';

// -- utilities
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<TestViewModel>> testsData;

  @override
  void initState() {
    super.initState();

    // data assignment
    testsData = getTestsData();
  }

  // to get screen data
  Future<List<TestViewModel>> getTestsData() async {
    final List<TestViewModel> finalTestsData = [];

    try {
      print('appApiListAllTests $appApiListAllTests');
      // getting data from network
      final response = await http.get(Uri.parse(appApiListAllTests));
      final responseStatusCode = response.statusCode;
      final responseBody = response.body;
      final responseBodyData = jsonDecode(responseBody);
      final responseData = responseBodyData['data']['quiz'];

      if (responseStatusCode == 200) {
        // if api success
        if (responseData.isNotEmpty) {
          for (final testItem in responseData) {
            final List<TestModel> testsDataRaw = [];

            for (final singleTestItem in testItem['test']) {
              testsDataRaw
                  .add(TestModel.fromJson(convertTestsJson(singleTestItem)));
            }
            // pushing data to main list
            final TestViewModel testViewDataRaw =
                TestViewModel(type: testItem['type'], allTests: testsDataRaw);
            finalTestsData
                .add(TestViewModel.fromJson(testViewDataRaw.toJson()));
          }
        }
      } else {
        // showing error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
        }
      }
    } catch (err) {
      // ignore: avoid_print
      print('err occurred on HomeScreen $err');
      // showing error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
      }
    }

    // final data return
    return finalTestsData;
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
          builder: ((context, AsyncSnapshot<List<TestViewModel>> snapshot) {
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
                final List<TestViewModel> testsData = snapshot.data!;
                if (testsData.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: appSettingsPagePadding,
                      itemCount: testsData.length,
                      itemBuilder: ((context, index) {
                        final TestViewModel testItemData = testsData[index];
                        final List<TestModel> firstTwoTestItems = testItemData.allTests.take(2).toList();
                        return homeScreenTestCardViewWidget(
                          testItemData,
                          firstTwoTestItems,
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
