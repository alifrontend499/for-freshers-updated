// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

final ongoingTestProvider = StateProvider<TestModel?>((ref) => null); // to store the test user is on currently
final isAnswerSelectedProvider = StateProvider<bool>((ref) => false); // when a single answer is selected
final selectedAnswersProvider = StateProvider<List<SelectedAnswerModel>>((ref) => []); // all the answers selected byt the user will be in this.


// for active route
// final activeRouteNameProvider = StateProvider<String?>((ref) => GLOBAL_ROUTE_ID_HOME);