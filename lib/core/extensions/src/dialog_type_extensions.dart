part of '../../services/src/dialog_service.dart';

extension DialogMessageTypeX on DialogMessageType {
  bool get isSuccess => this == DialogMessageType.SUCCESS;

  bool get isError => this == DialogMessageType.ERROR;

  bool get isWarning => this == DialogMessageType.WARNING;

  Widget get icon {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return Icon(Icons.check_circle, color: successStatusColor);
      case DialogMessageType.ERROR:
        return Icon(Icons.cancel, color: errorStatusColor);
      default:
        return Icon(Icons.warning_outlined, color: warningStatusColor);
    }
  }

  String get titleMsg {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return "Success";
      case DialogMessageType.ERROR:
        return "Failed";
      case DialogMessageType.WARNING:
        return "Warning";
    }
  }

  String get describe {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return "Successfully.";
      case DialogMessageType.ERROR:
        return "Something went wrong. Please try again.";
      case DialogMessageType.WARNING:
        return "Changes will not be saved. Do you want to proceed ?";
    }
  }

  Color get textColor {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return successStatusColor;
      case DialogMessageType.ERROR:
        return errorStatusColor;
      case DialogMessageType.WARNING:
        return warningStatusColor;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return Colors.green.shade50;
      case DialogMessageType.ERROR:
        return const Color(0xffFFF1F0);
      case DialogMessageType.WARNING:
        return Colors.green.shade50;
      default:
        return Colors.green.shade50;
    }
  }

  Color get borderColor {
    switch (this) {
      case DialogMessageType.SUCCESS:
        return successStatusColor;
      case DialogMessageType.ERROR:
        return errorStatusColor;
      case DialogMessageType.WARNING:
        return warningStatusColor;
    }
  }

  /// StatusColor
  Color get errorStatusColor => const Color(0xffff4d4f);

  Color get successStatusColor => const Color(0xff52C41A);

  Color get warningStatusColor => const Color(0xffFEF0C7);
}
