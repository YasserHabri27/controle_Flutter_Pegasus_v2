import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_widget.dart';
import 'core/service_locator.dart' as di;

/// Point d'entrée principal de l'application Pegasus.
/// Nous initialisons ici les binding Flutter, les services externes (Firebase, Hive)
/// et notre injection de dépendances avant de lancer l'interface utilisateur.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Nous initialisons Hive pour le stockage local avant tout le reste
  // afin de garantir que les données hors-ligne soient accessibles immédiatement.
  await Hive.initFlutter();
  
  // Nous tentons l'initialisation de Firebase.
  // Note : Cela peut échouer si le fichier google-services.json est manquant,
  // mais nous attrapons l'erreur pour ne pas bloquer l'application (Graceful Degradation).
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Erreur d'initialisation Firebase (attendue si config manquante): $e");
  }

  // Nous initions notre Service Locator pour l'injection de dépendances.
  await di.init();

  runApp(const MyApp());
}
