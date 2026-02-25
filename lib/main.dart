import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configura o foreground service para o cronômetro de descanso.
  // initCommunicationPort abre o ReceivePort antes de qualquer Provider.
  FlutterForegroundTask.initCommunicationPort();
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'fitjourney_rest_timer',
      channelName: 'Cronômetro de Descanso',
      channelDescription:
          'Contagem regressiva de descanso entre séries do FitJourney',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      // Dispara onRepeatEvent a cada 1 segundo para atualizar o countdown
      eventAction: ForegroundTaskEventAction.repeat(1000),
      autoRunOnBoot: false,
      allowWakeLock: true,
      allowWifiLock: false,
    ),
  );

  runApp(const ProviderScope(child: FitJourneyApp()));
}
