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

abstract class WishlistException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  WishlistException._({required this.message});

  factory WishlistException({required String message}) = _WishlistExceptionImpl;

  factory WishlistException.fromJson(Map<String, dynamic> jsonSerialization) {
    return WishlistException(message: jsonSerialization['message'] as String);
  }

  String message;

  /// Returns a shallow copy of this [WishlistException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WishlistException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WishlistException',
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WishlistException',
      'message': message,
    };
  }

  @override
  String toString() {
    return 'WishlistException(message: $message)';
  }
}

class _WishlistExceptionImpl extends WishlistException {
  _WishlistExceptionImpl({required String message}) : super._(message: message);

  /// Returns a shallow copy of this [WishlistException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WishlistException copyWith({String? message}) {
    return WishlistException(message: message ?? this.message);
  }
}
