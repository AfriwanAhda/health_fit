import 'dart:collection';

class SleepStage {
  final String? sleepStage;
  final String? durationMinutes;

  SleepStage({
    this.sleepStage,
    this.durationMinutes,
  });

  Map<String, dynamic> toJson() {
    return {
      'sleep_stage': sleepStage,
      'duration_minutes': durationMinutes,
    };
  }

  factory SleepStage.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null JSON provided');
    }

    return SleepStage(
      sleepStage: json['sleep_stage'],
      durationMinutes: json['duration_minutes'],
    );
  }
}
