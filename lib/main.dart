import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/app_export.dart';
import 'core/service_locator.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/app_widget.dart'; // Import AppWidget

/// Point d'entrée de l'application Pegasus.
/// Nous initialisons ici les services critiques et lançons l'interface utilisateur.
void main() async {
  // Nous nous assurons que les liaisons Flutter sont initialisées avant toute autre opération.
  WidgetsFlutterBinding.ensureInitialized();
  }

  // Nous initions notre Service Locator pour l'injection de dépendances.
  await di.init();

  runApp(const MyApp());
}
