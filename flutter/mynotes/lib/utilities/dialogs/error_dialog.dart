import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContxt context, String text) {
  return showGenericDialog(
    context: context,
    title: title,
    content: content,
    optionsBuilder: optionsBuilder,
  );
}
