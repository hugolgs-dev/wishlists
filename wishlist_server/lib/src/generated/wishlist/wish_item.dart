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

abstract class WishItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WishItem._({
    this.id,
    required this.title,
    this.notes,
    this.url,
    this.priceCents,
    int? priority,
    int? quantity,
    this.imageUrl,
  }) : priority = priority ?? 2,
       quantity = quantity ?? 1;

  factory WishItem({
    int? id,
    required String title,
    String? notes,
    String? url,
    int? priceCents,
    int? priority,
    int? quantity,
    String? imageUrl,
  }) = _WishItemImpl;

  factory WishItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return WishItem(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      notes: jsonSerialization['notes'] as String?,
      url: jsonSerialization['url'] as String?,
      priceCents: jsonSerialization['priceCents'] as int?,
      priority: jsonSerialization['priority'] as int?,
      quantity: jsonSerialization['quantity'] as int?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
    );
  }

  int? id;

  String title;

  String? notes;

  String? url;

  int? priceCents;

  int priority;

  int quantity;

  /// Set by the server. Ignored when the app sends it back.
  String? imageUrl;

  /// Returns a shallow copy of this [WishItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WishItem copyWith({
    int? id,
    String? title,
    String? notes,
    String? url,
    int? priceCents,
    int? priority,
    int? quantity,
    String? imageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WishItem',
      if (id != null) 'id': id,
      'title': title,
      if (notes != null) 'notes': notes,
      if (url != null) 'url': url,
      if (priceCents != null) 'priceCents': priceCents,
      'priority': priority,
      'quantity': quantity,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WishItem',
      if (id != null) 'id': id,
      'title': title,
      if (notes != null) 'notes': notes,
      if (url != null) 'url': url,
      if (priceCents != null) 'priceCents': priceCents,
      'priority': priority,
      'quantity': quantity,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WishItemImpl extends WishItem {
  _WishItemImpl({
    int? id,
    required String title,
    String? notes,
    String? url,
    int? priceCents,
    int? priority,
    int? quantity,
    String? imageUrl,
  }) : super._(
         id: id,
         title: title,
         notes: notes,
         url: url,
         priceCents: priceCents,
         priority: priority,
         quantity: quantity,
         imageUrl: imageUrl,
       );

  /// Returns a shallow copy of this [WishItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WishItem copyWith({
    Object? id = _Undefined,
    String? title,
    Object? notes = _Undefined,
    Object? url = _Undefined,
    Object? priceCents = _Undefined,
    int? priority,
    int? quantity,
    Object? imageUrl = _Undefined,
  }) {
    return WishItem(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      notes: notes is String? ? notes : this.notes,
      url: url is String? ? url : this.url,
      priceCents: priceCents is int? ? priceCents : this.priceCents,
      priority: priority ?? this.priority,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
    );
  }
}
