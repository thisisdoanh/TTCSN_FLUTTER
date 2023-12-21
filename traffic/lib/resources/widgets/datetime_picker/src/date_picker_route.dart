part of '../datetime_picker.dart';

class DatePickerRoute<T> extends PopupRoute<T> {
  DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    CustomDatetimePicker? theme,
    this.barrierLabel,
    this.locale,
    super.settings,
    BasePickerModel? pickerModel,
  })  : pickerModel = pickerModel ?? DatePickerModel(),
        theme = theme ?? const CustomDatetimePicker();

  final bool? showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final CustomDatetimePicker theme;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: DatePickerComponent(
        onChanged: onChanged,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}
