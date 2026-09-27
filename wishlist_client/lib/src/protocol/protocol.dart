/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wishlist_client/src/protocol/wishlist/family_item.dart'
    as _i4nr5t9w;
import 'package:wishlist_client/src/protocol/wishlist/member.dart' as _ifww57pp;
import 'package:wishlist_client/src/protocol/wishlist/wish_item.dart'
    as _im9ilsxq;
import 'wishlist/claim_info.dart' as _i5vb2x69;
import 'wishlist/event.dart' as _ixszj4no;
import 'wishlist/family_item.dart' as _ireitver;
import 'wishlist/image_upload.dart' as _ixmrjlij;
import 'wishlist/member.dart' as _if4kafv0;
import 'wishlist/wish_item.dart' as _ivqpbph4;
import 'wishlist/wishlist_exception.dart' as _izf7jqgv;
export 'wishlist/claim_info.dart';
export 'wishlist/event.dart';
export 'wishlist/family_item.dart';
export 'wishlist/image_upload.dart';
export 'wishlist/member.dart';
export 'wishlist/wish_item.dart';
export 'wishlist/wishlist_exception.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5vb2x69.ClaimInfo) {
      return _i5vb2x69.ClaimInfo.fromJson(data) as T;
    }
    if (t == _ixszj4no.Event) {
      return _ixszj4no.Event.fromJson(data) as T;
    }
    if (t == _ireitver.FamilyItem) {
      return _ireitver.FamilyItem.fromJson(data) as T;
    }
    if (t == _ixmrjlij.ImageUpload) {
      return _ixmrjlij.ImageUpload.fromJson(data) as T;
    }
    if (t == _if4kafv0.Member) {
      return _if4kafv0.Member.fromJson(data) as T;
    }
    if (t == _ivqpbph4.WishItem) {
      return _ivqpbph4.WishItem.fromJson(data) as T;
    }
    if (t == _izf7jqgv.WishlistException) {
      return _izf7jqgv.WishlistException.fromJson(data) as T;
    }
    if (t == _isc.getType<_i5vb2x69.ClaimInfo?>()) {
      return (data != null ? _i5vb2x69.ClaimInfo.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixszj4no.Event?>()) {
      return (data != null ? _ixszj4no.Event.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ireitver.FamilyItem?>()) {
      return (data != null ? _ireitver.FamilyItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixmrjlij.ImageUpload?>()) {
      return (data != null ? _ixmrjlij.ImageUpload.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_if4kafv0.Member?>()) {
      return (data != null ? _if4kafv0.Member.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivqpbph4.WishItem?>()) {
      return (data != null ? _ivqpbph4.WishItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izf7jqgv.WishlistException?>()) {
      return (data != null ? _izf7jqgv.WishlistException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i5vb2x69.ClaimInfo>) {
      return (data as List)
              .map((e) => deserialize<_i5vb2x69.ClaimInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_i4nr5t9w.FamilyItem>) {
      return (data as List)
              .map((e) => deserialize<_i4nr5t9w.FamilyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ifww57pp.Member>) {
      return (data as List)
              .map((e) => deserialize<_ifww57pp.Member>(e))
              .toList()
          as T;
    }
    if (t == List<_im9ilsxq.WishItem>) {
      return (data as List)
              .map((e) => deserialize<_im9ilsxq.WishItem>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5vb2x69.ClaimInfo => 'ClaimInfo',
      _ixszj4no.Event => 'Event',
      _ireitver.FamilyItem => 'FamilyItem',
      _ixmrjlij.ImageUpload => 'ImageUpload',
      _if4kafv0.Member => 'Member',
      _ivqpbph4.WishItem => 'WishItem',
      _izf7jqgv.WishlistException => 'WishlistException',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('wishlist.', '');
    }

    switch (data) {
      case _i5vb2x69.ClaimInfo():
        return 'ClaimInfo';
      case _ixszj4no.Event():
        return 'Event';
      case _ireitver.FamilyItem():
        return 'FamilyItem';
      case _ixmrjlij.ImageUpload():
        return 'ImageUpload';
      case _if4kafv0.Member():
        return 'Member';
      case _ivqpbph4.WishItem():
        return 'WishItem';
      case _izf7jqgv.WishlistException():
        return 'WishlistException';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ClaimInfo') {
      return deserialize<_i5vb2x69.ClaimInfo>(data['data']);
    }
    if (dataClassName == 'Event') {
      return deserialize<_ixszj4no.Event>(data['data']);
    }
    if (dataClassName == 'FamilyItem') {
      return deserialize<_ireitver.FamilyItem>(data['data']);
    }
    if (dataClassName == 'ImageUpload') {
      return deserialize<_ixmrjlij.ImageUpload>(data['data']);
    }
    if (dataClassName == 'Member') {
      return deserialize<_if4kafv0.Member>(data['data']);
    }
    if (dataClassName == 'WishItem') {
      return deserialize<_ivqpbph4.WishItem>(data['data']);
    }
    if (dataClassName == 'WishlistException') {
      return deserialize<_izf7jqgv.WishlistException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('wishlist', this);
    _iacc.Protocol().registerHostProtocol('wishlist', this);
  }

  @override
  String getModuleName() => 'wishlist';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
