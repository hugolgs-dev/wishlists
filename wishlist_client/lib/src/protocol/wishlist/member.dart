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

abstract class Member
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Member._({
    required this.userId,
    required this.name,
  });

  factory Member({
    required _isc.UuidValue userId,
    required String name,
  }) = _MemberImpl;

  factory Member.fromJson(Map<String, dynamic> jsonSerialization) {
    return Member(
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      name: jsonSerialization['name'] as String,
    );
  }

  _isc.UuidValue userId;

  String name;

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Member copyWith({
    _isc.UuidValue? userId,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Member',
      'userId': userId.toJson(),
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Member',
      'userId': userId.toJson(),
      'name': name,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MemberImpl extends Member {
  _MemberImpl({
    required _isc.UuidValue userId,
    required String name,
  }) : super._(
         userId: userId,
         name: name,
       );

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Member copyWith({
    _isc.UuidValue? userId,
    String? name,
  }) {
    return Member(
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}
