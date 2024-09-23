import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class DropDown<T> extends StatefulWidget {
  final bool enabled;
  final Color fillColor;
  final List<DropdownMenuItem<T>>? items;
  final String? label;
  final FormFieldValidator<T>? validator;
  final String? errorText;
  final double maxMenuHeight;
  final double height;
  final T? value;
  final GestureTapCallback? onTap;
  final ValueChanged<T?> onChanged;
  final Widget? prefixIcon;
  final DropdownButtonBuilder? selectedItemBuilder;

  const DropDown(
      {super.key,
      this.enabled = true,
      this.fillColor = ColorName.white,
      this.label,
      required this.items,
      this.height = 64,
      this.maxMenuHeight = 300,
      this.errorText,
      this.value,
      this.onTap,
      required this.onChanged,
      this.prefixIcon,
      this.selectedItemBuilder,
      this.validator});

  @override
  State<DropDown<T>> createState() => DropDownState<T>();
}

class DropDownState<T> extends State<DropDown<T>> {
  bool showError = false;
  String? validatorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            height: widget.height,
            margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
            padding: EdgeInsets.fromLTRB(widget.prefixIcon == null ? 16 : 12, 0, 12, 0),
            decoration: BoxDecoration(
              color: widget.fillColor,
              border:
                  Border.all(color: widget.errorText != null || showError ? Colors.red : ColorName.gray11, width: 1.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Theme(
              data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: ColorName.blue3,
                  selectionColor: ColorName.blue3,
                  selectionHandleColor: ColorName.blue3,
                ),
                colorScheme: const ColorScheme.light(primary: ColorName.blue3),
              ),
              child: DropdownButtonFormField<T>(
                  selectedItemBuilder: widget.selectedItemBuilder,
                  borderRadius: BorderRadius.circular(16),
                  value: widget.value,
                  menuMaxHeight: widget.maxMenuHeight,
                  validator: validatorLocal,
                  itemHeight: null,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: widget.height),
                    prefixIcon: widget.prefixIcon != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: widget.prefixIcon,
                          )
                        : null,
                    prefixIconConstraints: const BoxConstraints(maxWidth: 28),
                    suffixIconConstraints: const BoxConstraints(maxWidth: 28),
                    errorText: '',
                    errorStyle: const TextStyle(fontSize: 0),
                    floatingLabelStyle: const TextStyle(color: ColorName.gray6),
                    counterText: '',
                    suffixIcon: const Icon(
                      TablerIcons.selector,
                      color: ColorName.gray8,
                      size: 20,
                    ),
                    fillColor: widget.fillColor,
                    labelText: widget.label,
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: widget.errorText != null || showError ? Colors.red : ColorName.gray8),
                    contentPadding: const EdgeInsets.only(top: 8, bottom: 4),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  iconSize: 0,
                  onChanged: widget.onChanged,
                  items: widget.items),
            )),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
            ),
          )
      ],
    );
  }

  String? validatorLocal(T? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }
    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }
}

class DatePicker extends StatefulWidget {
  final bool enabled;
  final Color fillColor;
  final bool includeTime;
  final String portal;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final double height;
  final String label;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? value;
  final Function(String val)? onChanged;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String dateFormat;
  final String timeFormat;

  const DatePicker({
    super.key,
    this.enabled = true,
    this.fillColor = ColorName.white,
    this.label = 'Date',
    this.errorText,
    this.height = 64,
    this.includeTime = false,
    this.portal = 'Agency',
    this.value,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.firstDate,
    this.initialDate,
    this.lastDate,
    this.dateFormat = 'yyyy-MM-dd',
    this.timeFormat = 'HH:mm',
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool showError = false;
  String? validatorString;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          decoration: BoxDecoration(
            color: widget.enabled ? widget.fillColor : ColorName.gray11.withOpacity(0.5),
            border:
                Border.all(color: widget.errorText != null || showError ? Colors.red : ColorName.gray11, width: 1.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Theme(
            data: ThemeData(
                textSelectionTheme: widget.portal == 'Agency'
                    ? const TextSelectionThemeData(
                        cursorColor: ColorName.blue3,
                        selectionColor: ColorName.blue3,
                        selectionHandleColor: ColorName.blue3,
                      )
                    : const TextSelectionThemeData(
                        cursorColor: ColorName.pink3,
                        selectionColor: ColorName.pink3,
                        selectionHandleColor: ColorName.pink3,
                      ),
                colorScheme: widget.portal == 'Agency'
                    ? const ColorScheme.light(primary: ColorName.blue3)
                    : const ColorScheme.light(primary: ColorName.pink3)),
            child: TextFormField(
              controller: controller,
              enableInteractiveSelection: false,
              enabled: widget.enabled,
              onTap: widget.enabled ? onTap : null,
              keyboardType: TextInputType.none,
              showCursor: true,
              readOnly: true,
              validator: validatorLocal,
              style: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray2),
              decoration: InputDecoration(
                prefix: widget.prefix,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: widget.prefixIcon ??
                      const Icon(
                        TablerIcons.calendar,
                        color: ColorName.gray5,
                      ),
                ),
                prefixIconConstraints: const BoxConstraints(),
                suffixIconConstraints: const BoxConstraints(),
                errorText: '',
                errorStyle: const TextStyle(fontSize: 0),
                floatingLabelStyle: const TextStyle(color: ColorName.gray6),
                counterText: '',
                fillColor: widget.fillColor,
                label: Text(
                  widget.label,
                ),
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: widget.errorText != null || showError ? Colors.red : ColorName.gray8),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
            ),
          )
      ],
    );
  }

  void onTap() async {
    var date = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            datePickerTheme: widget.portal == 'Agency'
                ? DatePickerThemeData(
                    cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.blue5)),
                    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.blue3)),
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    todayForegroundColor: WidgetStateProperty.all(ColorName.blue3),
                    todayBackgroundColor: WidgetStateProperty.all(ColorName.blue12),
                    headerForegroundColor: ColorName.white,
                    headerBackgroundColor: ColorName.blue3,
                    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return ColorName.blue3;
                      }
                      return null;
                    }),
                  )
                : DatePickerThemeData(
                    cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.pink5)),
                    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.pink3)),
                    backgroundColor: Colors.white,
                    todayForegroundColor: WidgetStateProperty.all(ColorName.pink3),
                    todayBackgroundColor: WidgetStateProperty.all(ColorName.pink12),
                    surfaceTintColor: Colors.transparent,
                    headerForegroundColor: ColorName.white,
                    headerBackgroundColor: ColorName.pink3,
                    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return ColorName.pink3;
                      }
                      return null;
                    }),
                  ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.parse('1900-01-01'),
      lastDate: widget.lastDate ?? DateTime.parse('2100-12-31'),
    );
    TimeOfDay? time;
    if (date != null && widget.includeTime) {
      time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.fromDateTime(widget.initialDate ?? DateTime.now()),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
              data: ThemeData(
                timePickerTheme: widget.portal == 'Agency'
                    ? TimePickerThemeData(
                        dayPeriodColor: ColorName.blue12,
                        hourMinuteColor: ColorName.blue12,
                        dayPeriodBorderSide: const BorderSide(color: ColorName.blue10),
                        cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.blue5)),
                        confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.blue3)),
                        backgroundColor: Colors.white,
                        dialHandColor: ColorName.blue3,
                        dialBackgroundColor: ColorName.blue12,
                        hourMinuteTextColor: ColorName.blue3,
                        dayPeriodTextColor: ColorName.blue3,
                      )
                    : TimePickerThemeData(
                        dayPeriodColor: ColorName.pink12,
                        hourMinuteColor: ColorName.pink12,
                        dayPeriodBorderSide: const BorderSide(color: ColorName.pink10),
                        cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.pink5)),
                        confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(ColorName.pink3)),
                        backgroundColor: Colors.white,
                        dialHandColor: ColorName.pink3,
                        dialBackgroundColor: ColorName.pink12,
                        hourMinuteTextColor: ColorName.pink3,
                        dayPeriodTextColor: ColorName.pink3,
                      ),
              ),
              child: child!,
            ),
          );
        },
      );
    }

    if (date != null) {
      date =
          widget.includeTime && time != null ? DateTime(date.year, date.month, date.day, time.hour, time.minute) : date;
      final selectedDate = DateFormat(
              widget.includeTime && time != null ? '${widget.dateFormat} ${widget.timeFormat}' : widget.dateFormat)
          .format(date);
      Logger().d(selectedDate);
      widget.onChanged?.call(selectedDate);
      controller.text = selectedDate;
    }
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }

    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }
}

class TextInputField extends StatefulWidget {
  final bool enableCopyPaste;
  final bool enabled;
  final bool obscureText;
  final int? maxLength;
  final TextEditingController? controller;
  final bool hasLabel;
  final String? label;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? value;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final GestureTapCallback? onTap;
  final List<String>? autofillHints;
  final VoidCallback? onClear;
  final Function(String val)? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefix;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final double? height;
  final TextInputType textInputType;
  final bool? showCursor;
  final TextInputAction? textInputAction;
  final int? maxLines;

  const TextInputField(
      {super.key,
      this.enableCopyPaste = true,
      this.enabled = true,
      this.autofillHints,
      this.maxLength,
      this.controller,
      this.borderColor,
      this.fillColor,
      this.obscureText = false,
      this.height,
      this.inputFormatters,
      this.hasLabel = true,
      this.label,
      this.textStyle,
      this.errorText,
      this.value,
      this.focusNode,
      this.onTap,
      this.onClear,
      this.contentPadding,
      this.onChanged,
      this.onEditingComplete,
      this.prefix,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.validator,
      this.showCursor});

  @override
  State<TextInputField> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: ColorName.blue3,
                selectionColor: ColorName.blue3,
                selectionHandleColor: ColorName.blue3,
              ),
              colorScheme: const ColorScheme.light(primary: ColorName.blue3)),
          child: SizedBox(
            height: widget.height,
            child: TextFormField(
              autofillHints: widget.autofillHints,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged,
              enableInteractiveSelection: widget.enableCopyPaste,
              enabled: widget.enabled,
              initialValue: widget.value,
              showCursor: widget.showCursor,
              onTap: widget.onTap,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLength: widget.maxLength,
              validator: widget.validator,
              onEditingComplete: widget.onEditingComplete,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              controller: widget.controller,
              maxLines: widget.maxLines,
              keyboardType: widget.textInputType,
              style: widget.textStyle ?? Get.textTheme.bodyMedium!.copyWith(color: ColorName.gray2),
              decoration: InputDecoration(
                filled: true,
                prefix: widget.prefix,
                hintText: widget.label,
                hintStyle: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray9),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.onClear == null
                    ? widget.suffixIcon
                    : InkWell(
                        radius: 0,
                        highlightColor: Colors.transparent,
                        child: const Icon(TablerIcons.x, color: ColorName.gray7,),
                        onTap: () {
                          widget.onChanged?.call('');
                          widget.onClear?.call();
                        },
                      ),
                counterText: '',
                contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: widget.enabled ? widget.fillColor ?? ColorName.blue12.withOpacity(0.5) : ColorName.gray11,
                labelText: widget.label,
                labelStyle: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray8),
                errorBorder: getBorder(borderColor: ColorName.red3),
                border: getBorder(borderColor: widget.borderColor),
                enabledBorder: getBorder(borderColor: widget.borderColor),
                focusedBorder: getBorder(borderColor: ColorName.blue3),
                disabledBorder: getBorder(),
                focusedErrorBorder: getBorder(borderColor: ColorName.red3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder getBorder({Color? borderColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: borderColor == null
            ? const BorderSide(
                style: BorderStyle.none,
              )
            : BorderSide(color: borderColor, width: 1.5));
  }
}

class CheckBox extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool? value;

  final bool b2b;

  const CheckBox({super.key, this.onChanged, this.value = false, this.b2b = false});

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value ?? false; // Initialize state with the initial value
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged?.call(_isChecked); // Notify about the state change
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isChecked
              ? widget.b2b
                  ? ColorName.pink3
                  : ColorName.blue3
              : Colors.transparent,
          border: Border.all(
              color: _isChecked
                  ? widget.b2b
                      ? ColorName.pink3
                      : ColorName.blue3
                  : ColorName.gray11,
              width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 24,
        height: 24,
        child: Center(
          child: Icon(
            Icons.check_rounded,
            color: _isChecked ? ColorName.white : ColorName.gray9,
            size: 16,
          ),
        ),
      ),
    );
  }
}

Widget sortButton({double? height = 64, required String? value, required ValueChanged<String> onChanged}) {
  return Container(
    width: height,
    height: height,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: ColorName.gray11, width: 1.5)),
    child: IconButton(
        onPressed: () {
          if (value == 'asc') {
            value = 'desc';
          } else {
            value = 'asc';
          }
          onChanged.call(value!);
        },
        icon: Icon(value == 'asc' ? TablerIcons.sort_ascending : TablerIcons.sort_descending)),
  );
}

class DocumentPicker extends StatefulWidget {
  final String label;
  final Color fillColor;

  final String? value;

  final double height;
  final FormFieldValidator<String?>? validator;
  final String? errorText;

  final ValueChanged<XFile?> onChanged;

  const DocumentPicker({
    super.key,
    required this.label,
    this.height = 64,
    this.validator,
    this.value,
    this.errorText,
    required this.onChanged,
    this.fillColor = Colors.white,
  });

  @override
  DocumentPickerState createState() => DocumentPickerState();
}

class DocumentPickerState extends State<DocumentPicker> {
  bool showError = false;
  String? validatorString;
  String? textFieldText;
  late final ValueNotifier<String?> errorTextNotifier;
  XFile? selectedFile;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.value != null) {
      _controller.text = widget.value!;
    }
    super.initState();
    errorTextNotifier = ValueNotifier(widget.errorText)
      ..addListener(() {
        if (widget.errorText != null) {
          validatorLocal(widget.errorText);
        }
      });
  }

  void _formatFileName(String fileName) {
    const maxLength = 20; // Adjust based on your UI constraints
    if (fileName.length > maxLength) {
      _controller.text = '${fileName.substring(0, maxLength - 5)}...${fileName.substring(fileName.length - 4)}';
    }
    _controller.text = fileName;
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }

    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          constraints: BoxConstraints(minHeight: widget.height ?? 64),
          margin: EdgeInsets.only(bottom: widget.errorText != null || showError ? 0 : 16),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
            color: widget.fillColor,
            border:
                Border.all(color: widget.errorText != null || showError ? Colors.red : ColorName.gray11, width: 1.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Theme(
            data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: ColorName.blue3,
                  selectionColor: ColorName.blue3,
                  selectionHandleColor: ColorName.blue3,
                ),
                colorScheme: const ColorScheme.light(primary: ColorName.blue3)),
            child: TextFormField(
              controller: _controller,
              onTap: () async {
                /*selectedFile = await CommonModals.pickFileOrImage();
                if (selectedFile is XFile) {
                  setState(() {
                    _formatFileName(selectedFile!.name);
                  });
                  widget.onChanged.call(selectedFile);
                }*/
              },
              readOnly: true,
              validator: validatorLocal,
              onChanged: (String? s) {
                widget.onChanged.call(selectedFile);
              },
              style: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray2),
              decoration: InputDecoration(
                labelText: widget.label,
                fillColor: widget.fillColor,
                prefixIconConstraints: const BoxConstraints(),
                suffixIconConstraints: const BoxConstraints(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    getIconFromExtension(_controller.text.isNotEmpty ? _controller.text : ''),
                    color: ColorName.gray6,
                  ),
                ),
                filled: true,
                errorText: '',
                counterText: '',
                errorStyle: const TextStyle(fontSize: 0, height: 0.1),
                floatingLabelStyle: const TextStyle(color: ColorName.gray6),
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: widget.errorText != null || showError ? Colors.red : ColorName.gray8),
                contentPadding: const EdgeInsets.only(top: 6),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        widget.errorText != null || showError
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
                child: Text(
                  validatorString ?? widget.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
                ),
              )
            : Container(),
      ],
    );
  }
}
