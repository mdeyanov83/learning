// import 'package:flutter/foundation.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;

  CloudNote(
    this.documentId,
    this.ownerUserId,
    this.text,
  );
}
