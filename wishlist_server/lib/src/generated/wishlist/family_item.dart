/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wishlist_server/src/generated/protocol.dart' as _im30wwmx;
import '../wishlist/claim_info.dart' as _inw3ncuz;

/// An item on SOMEONE ELSE's list, with its claims.
/// Never built for the item's owner (see visibility.dart).
abstract class FamilyItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FamilyItem._({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.title,
    this.notes,
    this.url,
    this.priceCents,
    required this.priority,
    required this.quantity,
    required this.claims,
    required this.removed,
    required this.changedSinceMyClaim,
    required this.myQuantity,
    required this.myPurchased,
  });

  factory FamilyItem({
    required int id,
    required _is.UuidValue ownerId,
    required String ownerName,
    required String title,
    String? notes,
    String? url,
    int? priceCents,
    required int priority,
    required int quantity,
    required List<_inw3ncuz.ClaimInfo> claims,
    required bool removed,
    required bool changedSinceMyClaim,
    required int myQuantity,
    required bool myPurchased,
  }) = _FamilyItemImpl;

  factory FamilyItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyItem(
      id: jsonSerialization['id'] as int,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      ownerName: jsonSerialization['ownerName'] as String,
      title: jsonSerialization['title'] as String,
      notes: jsonSerialization['notes'] as String?,
      url: jsonSerialization['url'] as String?,
      priceCents: jsonSerialization['priceCents'] as int?,
      priority: jsonSerialization['priority'] as int,
      quantity: jsonSerialization['quantity'] as int,
      claims: _im30wwmx.Protocol().deserialize<List<_inw3ncuz.ClaimInfo>>(
        jsonSerialization['claims'],
      ),
      removed: _is.BoolJsonExtension.fromJson(jsonSerialization['removed']),
      changedSinceMyClaim: _is.BoolJsonExtension.fromJson(
        jsonSerialization['changedSinceMyClaim'],
      ),
      myQuantity: jsonSerialization['myQuantity'] as int,
      myPurchased: _is.BoolJsonExtension.fromJson(
        jsonSerialization['myPurchased'],
      ),
    );
  }

  int id;

  _is.UuidValue ownerId;

  String ownerName;

  String title;

  String? notes;

  String? url;

  int? priceCents;

  int priority;

  int quantity;

  List<_inw3ncuz.ClaimInfo> claims;

  /// The owner deleted it after the caller claimed it.
  bool removed;

  /// The owner edited it after the caller claimed it.
  bool changedSinceMyClaim;

  /// The caller's own claim (0 = not claimed).
  int myQuantity;

  bool myPurchased;

  /// Returns a shallow copy of this [FamilyItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FamilyItem copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? ownerName,
    String? title,
    String? notes,
    String? url,
    int? priceCents,
    int? priority,
    int? quantity,
    List<_inw3ncuz.ClaimInfo>? claims,
    bool? removed,
    bool? changedSinceMyClaim,
    int? myQuantity,
    bool? myPurchased,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FamilyItem',
      'id': id,
      'ownerId': ownerId.toJson(),
      'ownerName': ownerName,
      'title': title,
      if (notes != null) 'notes': notes,
      if (url != null) 'url': url,
      if (priceCents != null) 'priceCents': priceCents,
      'priority': priority,
      'quantity': quantity,
      'claims': claims.toJson(valueToJson: (v) => v.toJson()),
      'removed': removed,
      'changedSinceMyClaim': changedSinceMyClaim,
      'myQuantity': myQuantity,
      'myPurchased': myPurchased,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FamilyItem',
      'id': id,
      'ownerId': ownerId.toJson(),
      'ownerName': ownerName,
      'title': title,
      if (notes != null) 'notes': notes,
      if (url != null) 'url': url,
      if (priceCents != null) 'priceCents': priceCents,
      'priority': priority,
      'quantity': quantity,
      'claims': claims.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'removed': removed,
      'changedSinceMyClaim': changedSinceMyClaim,
      'myQuantity': myQuantity,
      'myPurchased': myPurchased,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyItemImpl extends FamilyItem {
  _FamilyItemImpl({
    required int id,
    required _is.UuidValue ownerId,
    required String ownerName,
    required String title,
    String? notes,
    String? url,
    int? priceCents,
    required int priority,
    required int quantity,
    required List<_inw3ncuz.ClaimInfo> claims,
    required bool removed,
    required bool changedSinceMyClaim,
    required int myQuantity,
    required bool myPurchased,
  }) : super._(
         id: id,
         ownerId: ownerId,
         ownerName: ownerName,
         title: title,
         notes: notes,
         url: url,
         priceCents: priceCents,
         priority: priority,
         quantity: quantity,
         claims: claims,
         removed: removed,
         changedSinceMyClaim: changedSinceMyClaim,
         myQuantity: myQuantity,
         myPurchased: myPurchased,
       );

  /// Returns a shallow copy of this [FamilyItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FamilyItem copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? ownerName,
    String? title,
    Object? notes = _Undefined,
    Object? url = _Undefined,
    Object? priceCents = _Undefined,
    int? priority,
    int? quantity,
    List<_inw3ncuz.ClaimInfo>? claims,
    bool? removed,
    bool? changedSinceMyClaim,
    int? myQuantity,
    bool? myPurchased,
  }) {
    return FamilyItem(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      title: title ?? this.title,
      notes: notes is String? ? notes : this.notes,
      url: url is String? ? url : this.url,
      priceCents: priceCents is int? ? priceCents : this.priceCents,
      priority: priority ?? this.priority,
      quantity: quantity ?? this.quantity,
      claims: claims ?? this.claims.map((e0) => e0.copyWith()).toList(),
      removed: removed ?? this.removed,
      changedSinceMyClaim: changedSinceMyClaim ?? this.changedSinceMyClaim,
      myQuantity: myQuantity ?? this.myQuantity,
      myPurchased: myPurchased ?? this.myPurchased,
    );
  }
}
