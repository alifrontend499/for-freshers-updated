// stop back press
Future<bool> onWillPopHelper() async {
  return false;
}

// text helpers
// get uppercase text
String getUppercaseTextHelper(String test) => test.toUpperCase();

// get lowercase text
String getLowercaseTextHelper(String test) => test.toLowerCase();

// get capitalize text
String getCapitalizeTextHelper(String test) =>
    test[0].toUpperCase() + test.substring(1).toLowerCase();

// get percentage
double getPercentageHelper(int total, int value) => value / total * 100;

// get Date
String getDateHelper(DateTime data) {
  final List<String> monthsNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Nov",
    "Dec",
  ];
  final int month = data.month;
  final String year = data.year.toString();
  final String day = data.day.toString();
  return "${monthsNames[month]} $day $year";
}