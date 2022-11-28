import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget defaultTextField({
  bool useHint = false,
  required double verticalContentPadding,
  required double horizontalContentPadding,
  required TextEditingController controller,
  required TextInputType keyboardType,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  isPassword = false,
  showKeyboard = true,
  required Function validate,
  String? labelName,
  double borderRadius = 0,
  IconData? prefix,
  IconData? suffix,
  IconButton? suffixIconButton,
  int? minLine,
  int? maxLine,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    onFieldSubmitted: (value) {
      if (onSubmit != null) {
        onSubmit!();
      }
    },
    onChanged: (value) {
      if (onChange != null) {
        onChange!();
      }
    },
    onTap: (){
      if (onTap != null) {
        onTap!();
      }
    },
    obscureText: isPassword,
    validator: (value) => validate(value),
    maxLines: maxLine,
    minLines: minLine,
    decoration: InputDecoration(
      hintText: useHint ? labelName : null,
      contentPadding: EdgeInsets.symmetric(
          vertical: verticalContentPadding,
          horizontal: horizontalContentPadding),
      labelText: useHint ? null : labelName,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      prefixIcon: prefix != null ? Icon(prefix) : null,
      suffixIcon: suffix != null
          ? (suffixIconButton ?? Icon(suffix))
          : (suffixIconButton),
    ),
    readOnly: !showKeyboard,
  );
}

Widget buildLoadingProgressWidget() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.orange,
    ),
  );
}
