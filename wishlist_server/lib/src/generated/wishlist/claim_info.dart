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

abstract class ClaimInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ClaimInfo._({
    required this.claimerId,
    required this.claimerName,
    required this.quantity,
  });

  factory ClaimInfo({
    required _is.UuidValue claimerId,
    required String claimerName,
    required int quantity,
  }) = _ClaimInfoImpl;

  factory ClaimInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimInfo(
      claimerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['claimerId'],
      ),
      claimerName: jsonSerialization['claimerName'] as String,
      quantity: jsonSerialization['quantity'] as int,
    );
  }

  _is.UuidValue claimerId;

  String claimerName;

  int quantity;

  /// Returns a shallow copy of this [ClaimInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClaimInfo copyWith({
    _is.UuidValue? claimerId,
    String? claimerName,
    int? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimInfo',
      'claimerId': claimerId.toJson(),
      'claimerName': claimerName,
      'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimInfo',
      'claimerId': claimerId.toJson(),
      'claimerName': claimerName,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ClaimInfoImpl extends ClaimInfo {
  _ClaimInfoImpl({
    required _is.UuidValue claimerId,
    required String claimerName,
    required int quantity,
  }) : super._(
         claimerId: claimerId,
         claimerName: claimerName,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ClaimInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClaimInfo copyWith({
    _is.UuidValue? claimerId,
    String? claimerName,
    int? quantity,
  }) {
    return ClaimInfo(
      claimerId: claimerId ?? this.claimerId,
      claimerName: claimerName ?? this.claimerName,
      quantity: quantity ?? this.quantity,
    );
  }
}
