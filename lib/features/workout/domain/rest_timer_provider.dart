import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import 'rest_timer_state.dart';

// ─────────────── TaskHandler (background isolate) ───────────────

/// Entry point para o background isolate do foreground service.
/// Precisa ser top-level com @pragma para que o VM consiga encontrá-la.
@pragma('vm:entry-point')
void restTimerCallback() {
  FlutterForegroundTask.setTaskHandler(RestTimerTaskHandler());
}

/// Lida com o cronômetro no background isolate.
/// A cada segundo (conforme ForegroundTaskOptions), recalcula o tempo
/// restante e atualiza a notificação persistente.
class RestTimerTaskHandler extends TaskHandler {
  int _startTimestamp = 0;
  int _durationSeconds = 0;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {
    if (_durationSeconds <= 0) return;

    final elapsedSecs =
        (DateTime.now().millisecondsSinceEpoch - _startTimestamp) ~/ 1000;
    final remaining = (_durationSeconds - elapsedSecs).clamp(
      0,
      _durationSeconds,
    );

    final m = (remaining ~/ 60).toString().padLeft(2, '0');
    final s = (remaining % 60).toString().padLeft(2, '0');

    FlutterForegroundTask.updateService(
      notificationText: remaining == 0 ? AppStrings.restFinished : '$m:$s',
    );

    // Envia o valor restante para o main isolate (atualiza UI)
    FlutterForegroundTask.sendDataToMain(remaining);

    if (remaining == 0) {
      // Para de emitir eventos após atingir zero
      _durationSeconds = 0;
    }
  }

  @override
  void onReceiveData(Object data) {
    if (data is Map<Object?, Object?>) {
      _startTimestamp = (data['ts'] as num? ?? 0).toInt();
      _durationSeconds = (data['dur'] as num? ?? 0).toInt();
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _durationSeconds = 0;
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'cancel') {
      FlutterForegroundTask.stopService();
    }
  }
}

// ─────────────── Notifier (main isolate) ───────────────

/// Gerencia o estado do cronômetro de descanso no main isolate.
/// Recebe ticks do background isolate via callback e atualiza o estado.
class RestTimerNotifier extends StateNotifier<RestTimerState> {
  RestTimerNotifier() : super(const RestTimerState()) {
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);
  }

  @override
  void dispose() {
    FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
    super.dispose();
  }

  // ─── Callbacks do background isolate ───

  void _onTaskData(Object data) {
    if (!mounted) return;
    final remaining = data is int ? data : (data as num).toInt();
    if (remaining <= 0) {
      // Vibração pesada sinaliza fim do descanso
      HapticFeedback.heavyImpact();
      state = state.copyWith(remainingSeconds: 0, isRunning: false);
    } else {
      state = state.copyWith(remainingSeconds: remaining);
    }
  }

  // ─── APIs públicas ───

  /// Inicia o cronômetro com [durationSeconds] segundos.
  /// Para automaticamente qualquer timer em andamento antes de iniciar.
  Future<void> start(int durationSeconds, {String exerciseName = ''}) async {
    if (durationSeconds <= 0) return;

    // Encerra serviço anterior se houver
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }

    state = RestTimerState(
      totalSeconds: durationSeconds,
      remainingSeconds: durationSeconds,
      isRunning: true,
      exerciseName: exerciseName,
    );

    final result = await FlutterForegroundTask.startService(
      serviceId: 42,
      notificationTitle: AppStrings.restTimerNotification,
      notificationText: _fmt(durationSeconds),
      callback: restTimerCallback,
      notificationButtons: [
        const NotificationButton(id: 'cancel', text: 'Cancelar'),
      ],
    );

    if (result is ServiceRequestSuccess) {
      // Envia metadados para o TaskHandler calcular o tempo restante
      FlutterForegroundTask.sendDataToTask({
        'ts': DateTime.now().millisecondsSinceEpoch,
        'dur': durationSeconds,
      });
    }
  }

  /// Cancela o cronômetro imediatamente.
  Future<void> cancel() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
    state = const RestTimerState();
  }

  /// Reinicia o contador com a mesma duração original.
  Future<void> restart() async {
    if (state.totalSeconds > 0) {
      await start(state.totalSeconds, exerciseName: state.exerciseName);
    }
  }

  // ─── helpers ───

  String _fmt(int secs) {
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

// ─────────────── Provider ───────────────

/// StateNotifierProvider do cronômetro de descanso.
/// keepAlive implícito (sem autoDispose) para persistir durante a sessão.
final restTimerProvider =
    StateNotifierProvider<RestTimerNotifier, RestTimerState>(
      (ref) => RestTimerNotifier(),
    );
