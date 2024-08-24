import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  AppLocalizations get appLocalizations=> AppLocalizations.of(this)!;
}