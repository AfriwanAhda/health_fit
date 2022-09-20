part of health;

/// A numerical value from Apple HealthKit or Google Fit
/// such as integer or double.
/// E.g. 1, 2.9, -3
///
/// Parameters:
/// * [numericValue] - a [num] value for the [HealthDataPoint]
class NumericHealthValue extends HealthValue {
  num _numericValue;

  NumericHealthValue(this._numericValue);

  num get numericValue => _numericValue;

  @override
  String toString() {
    return numericValue.toString();
  }

  factory NumericHealthValue.fromJson(json) {
    return NumericHealthValue(num.parse(json['numericValue']));
  }

  Map<String, dynamic> toJson() => {
        'numericValue': numericValue.toString(),
      };

  @override
  bool operator ==(Object o) {
    return o is NumericHealthValue && this._numericValue == o.numericValue;
  }

  @override
  int get hashCode => numericValue.hashCode;
}

/// A [HealthValue] object for audiograms
///
/// Parameters:
/// * [frequencies] - array of frequencies of the test
/// * [leftEarSensitivities] threshold in decibel for the left ear
/// * [rightEarSensitivities] threshold in decibel for the left ear
class AudiogramHealthValue extends HealthValue {
  List<num> _frequencies;
  List<num> _leftEarSensitivities;
  List<num> _rightEarSensitivities;

  AudiogramHealthValue(this._frequencies, this._leftEarSensitivities,
      this._rightEarSensitivities);

  List<num> get frequencies => _frequencies;
  List<num> get leftEarSensitivities => _leftEarSensitivities;
  List<num> get rightEarSensitivities => _rightEarSensitivities;

  @override
  String toString() {
    return """frequencies: ${frequencies.toString()}, 
    left ear sensitivities: ${leftEarSensitivities.toString()}, 
    right ear sensitivities: ${rightEarSensitivities.toString()}""";
  }

  factory AudiogramHealthValue.fromJson(json) {
    return AudiogramHealthValue(
        List<num>.from(json['frequencies']),
        List<num>.from(json['leftEarSensitivities']),
        List<num>.from(json['rightEarSensitivities']));
  }

  Map<String, dynamic> toJson() => {
        'frequencies': frequencies.toString(),
        'leftEarSensitivities': leftEarSensitivities.toString(),
        'rightEarSensitivities': rightEarSensitivities.toString(),
      };

  @override
  bool operator ==(Object o) {
    return o is AudiogramHealthValue &&
        listEquals(this._frequencies, o.frequencies) &&
        listEquals(this._leftEarSensitivities, o.leftEarSensitivities) &&
        listEquals(this._rightEarSensitivities, o.rightEarSensitivities);
  }

  @override
  int get hashCode =>
      Object.hash(frequencies, leftEarSensitivities, rightEarSensitivities);
}

/// A [HealthValue] object for workouts
///
/// Parameters:
/// * [workoutActivityType] - the type of workout
/// * [totalEnergyBurned] - the total energy burned during the workout
/// * [totalEnergyBurnedUnit] - the unit of the total energy burned
/// * [totalDistance] - the total distance of the workout
/// * [totalDistanceUnit] - the unit of the total distance
class WorkoutHealthValue extends HealthValue {
  HealthWorkoutActivityType _workoutActivityType;
  int? _totalEnergyBurned;
  HealthDataUnit? _totalEnergyBurnedUnit;
  int? _totalDistance;
  HealthDataUnit? _totalDistanceUnit;

  WorkoutHealthValue(
      this._workoutActivityType,
      this._totalEnergyBurned,
      this._totalEnergyBurnedUnit,
      this._totalDistance,
      this._totalDistanceUnit);

  /// The type of the workout.
  HealthWorkoutActivityType get workoutActivityType => _workoutActivityType;

  /// The total energy burned during the workout.
  /// Might not be available for all workouts.
  int? get totalEnergyBurned => _totalEnergyBurned;

  /// The unit of the total energy burned during the workout.
  /// Might not be available for all workouts.
  HealthDataUnit? get totalEnergyBurnedUnit => _totalEnergyBurnedUnit;

  /// The total distance covered during the workout.
  /// Might not be available for all workouts.
  int? get totalDistance => _totalDistance;

  /// The unit of the total distance covered during the workout.
  /// Might not be available for all workouts.
  HealthDataUnit? get totalDistanceUnit => _totalDistanceUnit;

  factory WorkoutHealthValue.fromJson(json) {
    return WorkoutHealthValue(
        HealthWorkoutActivityType.values.firstWhere(
            (element) => element.typeToString() == json['workoutActivityType']),
        json['totalEnergyBurned'] != null
            ? (json['totalEnergyBurned'] as double).toInt()
            : null,
        json['totalEnergyBurnedUnit'] != null
            ? HealthDataUnit.values.firstWhere((element) =>
                element.typeToString() == json['totalEnergyBurnedUnit'])
            : null,
        json['totalDistance'] != null
            ? (json['totalDistance'] as double).toInt()
            : null,
        json['totalDistanceUnit'] != null
            ? HealthDataUnit.values.firstWhere((element) =>
                element.typeToString() == json['totalDistanceUnit'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() => {
        'workoutActivityType': _workoutActivityType.toString(),
        'totalEnergyBurned': _totalEnergyBurned,
        'totalEnergyBurnedUnit': _totalEnergyBurnedUnit?.toString(),
        'totalDistance': _totalDistance,
        'totalDistanceUnit': _totalDistanceUnit?.toString(),
      };

  @override
  String toString() {
    return """workoutActivityType: ${workoutActivityType.toString()},
    totalEnergyBurned: $totalEnergyBurned,
    totalEnergyBurnedUnit: ${totalEnergyBurnedUnit?.toString()},
    totalDistance: $totalDistance,
    totalDistanceUnit: ${totalDistanceUnit?.toString()}""";
  }

  @override
  bool operator ==(Object o) {
    return o is WorkoutHealthValue &&
        this.workoutActivityType == o.workoutActivityType &&
        this.totalEnergyBurned == o.totalEnergyBurned &&
        this.totalEnergyBurnedUnit == o.totalEnergyBurnedUnit &&
        this.totalDistance == o.totalDistance &&
        this.totalDistanceUnit == o.totalDistanceUnit;
  }

  @override
  int get hashCode => Object.hash(workoutActivityType, totalEnergyBurned,
      totalEnergyBurnedUnit, totalDistance, totalDistanceUnit);
}

abstract class HealthValue {
  Map<String, dynamic> toJson();
}
