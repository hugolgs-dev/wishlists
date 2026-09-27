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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:wishlist_server/src/generated/wishlist/family_item.dart'
    as _inf99iy1;
import 'package:wishlist_server/src/generated/wishlist/member.dart'
    as _io2wo9jc;
import 'package:wishlist_server/src/generated/wishlist/wish_item.dart'
    as _iqkmgcxp;
import 'wishlist/claim.dart' as _i72ohhd2;
import 'wishlist/claim_info.dart' as _i5vb2x69;
import 'wishlist/event.dart' as _ixszj4no;
import 'wishlist/family_item.dart' as _ireitver;
import 'wishlist/item.dart' as _i2vbrl2l;
import 'wishlist/member.dart' as _if4kafv0;
import 'wishlist/wish_item.dart' as _ivqpbph4;
import 'wishlist/wishlist_exception.dart' as _izf7jqgv;
export 'wishlist/claim.dart';
export 'wishlist/claim_info.dart';
export 'wishlist/event.dart';
export 'wishlist/family_item.dart';
export 'wishlist/item.dart';
export 'wishlist/member.dart';
export 'wishlist/wish_item.dart';
export 'wishlist/wishlist_exception.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'claim',
      dartName: 'Claim',
      schema: 'public',
      module: 'wishlist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'itemId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'claimerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'contributionCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'purchased',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'seenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'claim_fk_0',
          columns: ['itemId'],
          referenceTable: 'item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'claim_fk_1',
          columns: ['claimerId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'claim_item_claimer_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'itemId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'claimerId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event',
      dartName: 'Event',
      schema: 'public',
      module: 'wishlist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'date',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'archived',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'item',
      dartName: 'Item',
      schema: 'public',
      module: 'wishlist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdById',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'url',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'priceCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'priority',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'isGroupGift',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'organizerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'previewTitle',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'previewFetchedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'receivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'deletedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'item_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'item_fk_1',
          columns: ['ownerId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'item_fk_2',
          columns: ['createdById'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'item_fk_3',
          columns: ['organizerId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'item_event_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i72ohhd2.Claim) {
      return _i72ohhd2.Claim.fromJson(data) as T;
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
    if (t == _i2vbrl2l.Item) {
      return _i2vbrl2l.Item.fromJson(data) as T;
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
    if (t == _is.getType<_i72ohhd2.Claim?>()) {
      return (data != null ? _i72ohhd2.Claim.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5vb2x69.ClaimInfo?>()) {
      return (data != null ? _i5vb2x69.ClaimInfo.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixszj4no.Event?>()) {
      return (data != null ? _ixszj4no.Event.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ireitver.FamilyItem?>()) {
      return (data != null ? _ireitver.FamilyItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2vbrl2l.Item?>()) {
      return (data != null ? _i2vbrl2l.Item.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_if4kafv0.Member?>()) {
      return (data != null ? _if4kafv0.Member.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ivqpbph4.WishItem?>()) {
      return (data != null ? _ivqpbph4.WishItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izf7jqgv.WishlistException?>()) {
      return (data != null ? _izf7jqgv.WishlistException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i5vb2x69.ClaimInfo>) {
      return (data as List)
              .map((e) => deserialize<_i5vb2x69.ClaimInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_inf99iy1.FamilyItem>) {
      return (data as List)
              .map((e) => deserialize<_inf99iy1.FamilyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_io2wo9jc.Member>) {
      return (data as List)
              .map((e) => deserialize<_io2wo9jc.Member>(e))
              .toList()
          as T;
    }
    if (t == List<_iqkmgcxp.WishItem>) {
      return (data as List)
              .map((e) => deserialize<_iqkmgcxp.WishItem>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i72ohhd2.Claim => 'Claim',
      _i5vb2x69.ClaimInfo => 'ClaimInfo',
      _ixszj4no.Event => 'Event',
      _ireitver.FamilyItem => 'FamilyItem',
      _i2vbrl2l.Item => 'Item',
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
      case _i72ohhd2.Claim():
        return 'Claim';
      case _i5vb2x69.ClaimInfo():
        return 'ClaimInfo';
      case _ixszj4no.Event():
        return 'Event';
      case _ireitver.FamilyItem():
        return 'FamilyItem';
      case _i2vbrl2l.Item():
        return 'Item';
      case _if4kafv0.Member():
        return 'Member';
      case _ivqpbph4.WishItem():
        return 'WishItem';
      case _izf7jqgv.WishlistException():
        return 'WishlistException';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Claim') {
      return deserialize<_i72ohhd2.Claim>(data['data']);
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
    if (dataClassName == 'Item') {
      return deserialize<_i2vbrl2l.Item>(data['data']);
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('wishlist', this);
    _iacs.Protocol().registerHostProtocol('wishlist', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i72ohhd2.Claim:
        return _i72ohhd2.Claim.t;
      case _ixszj4no.Event:
        return _ixszj4no.Event.t;
      case _i2vbrl2l.Item:
        return _i2vbrl2l.Item.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
