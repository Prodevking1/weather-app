import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TodayDate {
  var enDatesFuture = initializeDateFormatting('en', null);

  var date = DateTime.now();
  getTodayDate() {
    var todayDate = DateFormat('EEEE, d MMMM').format(date).toString();
    return todayDate;
  }
}
