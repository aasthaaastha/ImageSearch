import 'dart:async';


/// TimerUtil.
class TimerUtil {
  TimerUtil(
      {this.mInterval = Duration.millisecondsPerSecond, this.mTotalTime = 0});

  /// Timer.
  Timer? _mTimer;

  /// Is Timer active.

  bool _isActive = false;

  /// Timer interval (unit millisecond，def: 1000 millisecond).

  int mInterval;


  int mTotalTime; //单位毫秒

  OnTimerTickCallback? _onTimerTickCallback;

  /// set Timer interval. (unit millisecond).

  void setInterval(int interval) {
    if (interval <= 0) interval = Duration.millisecondsPerSecond;
    mInterval = interval;
  }

  /// set countdown totalTime. (unit millisecond).

  void setTotalTime(int totalTime) {
    if (totalTime <= 0) return;
    mTotalTime = totalTime;
  }

  /// start Timer.

  void startTimer() {
    if (_isActive || mInterval <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(0);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      _doCallback(timer.tick);
    });
  }

  /// start countdown Timer.

  void startCountDown() {
    if (_isActive || mInterval <= 0 || mTotalTime <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(mTotalTime);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      int time = mTotalTime - mInterval;
      mTotalTime = time;
      if (time >= mInterval) {
        _doCallback(time);
      } else if (time == 0) {
        _doCallback(time);
        cancel();
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          mTotalTime = 0;
          _doCallback(0);
          cancel();
        });
      }
    });
  }

  void _doCallback(int time) {
    if (_onTimerTickCallback != null) {
      _onTimerTickCallback!(time);
    }
  }

  /// update countdown totalTime.

  void updateTotalTime(int totalTime) {
    cancel();
    mTotalTime = totalTime;
    startCountDown();
  }

  /// timer is Active.

  bool isActive() {
    return _isActive;
  }

  /// Cancels the timer.

  void cancel() {
    _mTimer?.cancel();
    _mTimer = null;
    _isActive = false;
  }

  /// set timer callback.
  void setOnTimerTickCallback(OnTimerTickCallback callback) {
    _onTimerTickCallback = callback;
  }
}