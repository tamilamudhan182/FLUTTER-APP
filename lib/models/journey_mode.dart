enum JourneyMode { direct, combined }

extension JourneyModeLabel on JourneyMode {
  String get label => this == JourneyMode.direct ? 'Direct Mode' : 'Combined Mode';
}
