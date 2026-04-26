import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection.
  await initServiceLocator();

  // Firebase will be initialized in Phase 9.
  // await Firebase.initializeApp();

  runApp(const FindYourClinicApp());
}
