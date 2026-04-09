import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts between Firestore [Timestamp] and Dart [DateTime] for
/// `@JsonSerializable` models.
///
/// Apply via field annotation:
/// ```dart
/// @TimestampConverter()
/// final DateTime? createdAt;
/// ```
///
/// Why nullable: newly-created docs may not yet have the server timestamp
/// resolved by the time the cache reads them back, so the field can be null
/// for a brief moment after a write.
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

/// Non-nullable variant — use only when the field is guaranteed populated
/// (e.g., entities derived after the doc has been written and re-read).
class RequiredTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const RequiredTimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}
