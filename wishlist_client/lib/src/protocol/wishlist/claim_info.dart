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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ClaimInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClaimInfo._({
    required this.claimerId,
    required this.claimerName,
    required this.quantity,
  });

  factory ClaimInfo({
    required _isc.UuidValue claimerId,
    required String claimerName,
    required int quantity,
  }) = _ClaimInfoImpl;

  factory ClaimInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimInfo(
      claimerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['claimerId'],
      ),
      claimerName: jsonSerialization['claimerName'] as String,
      quantity: jsonSerialization['quantity'] as int,
    );
  }

  _isc.UuidValue claimerId;

  String claimerName;

  int quantity;

  /// Returns a shallow copy of this [ClaimInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClaimInfo copyWith({
    _isc.UuidValue? claimerId,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _ClaimInfoImpl extends ClaimInfo {
  _ClaimInfoImpl({
    required _isc.UuidValue claimerId,
    required String claimerName,
    required int quantity,
  }) : super._(
         claimerId: claimerId,
         claimerName: claimerName,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ClaimInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClaimInfo copyWith({
    _isc.UuidValue? claimerId,
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
