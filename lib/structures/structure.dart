// Define enums for door states
enum DoorState { OPEN, CLOSED }

// Nested class for environment data
class Environment {
  final int temperature;
  final int humidity;
  final bool fanRunning;

  Environment({
    required this.temperature,
    required this.humidity,
    required this.fanRunning,
  });

  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      temperature: json['temperature'] as int,
      humidity: json['humidity'] as int,
      fanRunning: json['fan_running'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'temperature': temperature,
    'humidity': humidity,
    'fan_running': fanRunning,
  };
}

// Nested class for doors data
class Doors {
  final DoorState garage;
  final DoorState front;

  Doors({
    required this.garage,
    required this.front,
  });

  factory Doors.fromJson(Map<String, dynamic> json) {
    return Doors(
      garage: _parseDoorState(json['garage'] as String),
      front: _parseDoorState(json['front'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'garage': garage.toString().split('.').last,
    'front': front.toString().split('.').last,
  };

  static DoorState _parseDoorState(String state) {
    return state == 'OPEN' ? DoorState.OPEN : DoorState.CLOSED;
  }
}

// Nested class for motion data
class Motion {
  final bool toiletLight;
  final bool roomLight;

  Motion({
    required this.toiletLight,
    required this.roomLight,
  });

  factory Motion.fromJson(Map<String, dynamic> json) {
    return Motion(
      toiletLight: json['toilet_light'] as bool,
      roomLight: json['room_light'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'toilet_light': toiletLight,
    'room_light': roomLight,
  };
}

// Nested class for pause state
class PauseState {
  final bool active;
  final int remainingMs;
  final int durationMs;

  PauseState({
    required this.active,
    required this.remainingMs,
    required this.durationMs,
  });

  factory PauseState.fromJson(Map<String, dynamic> json) {
    return PauseState(
      active: json['active'] as bool,
      remainingMs: json['remaining_ms'] as int,
      durationMs: json['duration_ms'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'active': active,
    'remaining_ms': remainingMs,
    'duration_ms': durationMs,
  };
}

// Nested class for pause data
class Pause {
  final PauseState room;
  final PauseState toilet;

  Pause({
    required this.room,
    required this.toilet,
  });

  factory Pause.fromJson(Map<String, dynamic> json) {
    return Pause(
      room: PauseState.fromJson(json['room'] as Map<String, dynamic>),
      toilet: PauseState.fromJson(json['toilet'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'room': room.toJson(),
    'toilet': toilet.toJson(),
  };
}

// Nested class for alarm data
class Alarm {
  final bool fireDetected;
  final bool buzzerActive;

  Alarm({
    required this.fireDetected,
    required this.buzzerActive,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      fireDetected: json['fire_detected'] as bool,
      buzzerActive: json['buzzer_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'fire_detected': fireDetected,
    'buzzer_active': buzzerActive,
  };
}

// Main class for the entire data structure
class HomeData {
  final String timestamp;
  final Environment environment;
  final Doors doors;
  final Motion motion;
  final Pause pause;
  final Alarm alarm;

  HomeData({
    required this.timestamp,
    required this.environment,
    required this.doors,
    required this.motion,
    required this.pause,
    required this.alarm,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return HomeData(
      timestamp: data['timestamp'].toString(),
      environment: Environment.fromJson(data['environment'] as Map<String, dynamic>),
      doors: Doors.fromJson(data['doors'] as Map<String, dynamic>),
      motion: Motion.fromJson(data['motion'] as Map<String, dynamic>),
      pause: Pause.fromJson(data['pause'] as Map<String, dynamic>),
      alarm: Alarm.fromJson(data['alarm'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': {
      'timestamp': timestamp,
      'environment': environment.toJson(),
      'doors': doors.toJson(),
      'motion': motion.toJson(),
      'pause': pause.toJson(),
      'alarm': alarm.toJson(),
    }
  };
}