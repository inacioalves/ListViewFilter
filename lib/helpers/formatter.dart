import 'package:intl/intl.dart';

const String slocale = 'pt_BR';
final NumberFormat real = NumberFormat.currency(locale: slocale, name: 'R\$');
final NumberFormat percentual =
    NumberFormat.decimalPercentPattern(locale: slocale, decimalDigits: 2);
