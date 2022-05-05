import 'base.dart';

/// A source has been renamed
class SourceRenamedEvent extends BaseEvent {
  SourceRenamedEvent(Map<String, dynamic> json) : super(json);

  /// Previous source name
  String get previousName => this.json['previousName'];

  /// New source name
  String get newName => this.json['newName'];

  /// Type of source (input, scene, filter, transition)
  String get sourceType => this.json['sourceType'];
}
