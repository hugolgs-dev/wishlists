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

abstract class Claim implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Claim._({
    this.id,
    required this.itemId,
    required this.claimerId,
    int? quantity,
    this.contributionCents,
    bool? purchased,
    DateTime? createdAt,
  }) : quantity = quantity ?? 1,
       purchased = purchased ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Claim({
    int? id,
    required int itemId,
    required _is.UuidValue claimerId,
    int? quantity,
    int? contributionCents,
    bool? purchased,
    DateTime? createdAt,
  }) = _ClaimImpl;

  factory Claim.fromJson(Map<String, dynamic> jsonSerialization) {
    return Claim(
      id: jsonSerialization['id'] as int?,
      itemId: jsonSerialization['itemId'] as int,
      claimerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['claimerId'],
      ),
      quantity: jsonSerialization['quantity'] as int?,
      contributionCents: jsonSerialization['contributionCents'] as int?,
      purchased: jsonSerialization['purchased'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['purchased']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ClaimTable();

  static const db = ClaimRepository._();

  @override
  int? id;

  int itemId;

  _is.UuidValue claimerId;

  int quantity;

  int? contributionCents;

  bool purchased;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Claim copyWith({
    int? id,
    int? itemId,
    _is.UuidValue? claimerId,
    int? quantity,
    int? contributionCents,
    bool? purchased,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Claim',
      if (id != null) 'id': id,
      'itemId': itemId,
      'claimerId': claimerId.toJson(),
      'quantity': quantity,
      if (contributionCents != null) 'contributionCents': contributionCents,
      'purchased': purchased,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ClaimInclude include() {
    return ClaimInclude._();
  }

  static ClaimIncludeList includeList({
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    ClaimInclude? include,
  }) {
    return ClaimIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClaimImpl extends Claim {
  _ClaimImpl({
    int? id,
    required int itemId,
    required _is.UuidValue claimerId,
    int? quantity,
    int? contributionCents,
    bool? purchased,
    DateTime? createdAt,
  }) : super._(
         id: id,
         itemId: itemId,
         claimerId: claimerId,
         quantity: quantity,
         contributionCents: contributionCents,
         purchased: purchased,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Claim copyWith({
    Object? id = _Undefined,
    int? itemId,
    _is.UuidValue? claimerId,
    int? quantity,
    Object? contributionCents = _Undefined,
    bool? purchased,
    DateTime? createdAt,
  }) {
    return Claim(
      id: id is int? ? id : this.id,
      itemId: itemId ?? this.itemId,
      claimerId: claimerId ?? this.claimerId,
      quantity: quantity ?? this.quantity,
      contributionCents: contributionCents is int?
          ? contributionCents
          : this.contributionCents,
      purchased: purchased ?? this.purchased,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ClaimUpdateTable extends _is.UpdateTable<ClaimTable> {
  ClaimUpdateTable(super.table);

  _is.ColumnValue<int, int> itemId(int value) => _is.ColumnValue(
    table.itemId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> claimerId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.claimerId,
    value,
  );

  _is.ColumnValue<int, int> quantity(int value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<int, int> contributionCents(int? value) => _is.ColumnValue(
    table.contributionCents,
    value,
  );

  _is.ColumnValue<bool, bool> purchased(bool value) => _is.ColumnValue(
    table.purchased,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ClaimTable extends _is.Table<int?> {
  ClaimTable({super.tableRelation}) : super(tableName: 'claim') {
    updateTable = ClaimUpdateTable(this);
    itemId = _is.ColumnInt(
      'itemId',
      this,
    );
    claimerId = _is.ColumnUuid(
      'claimerId',
      this,
    );
    quantity = _is.ColumnInt(
      'quantity',
      this,
      hasDefault: true,
    );
    contributionCents = _is.ColumnInt(
      'contributionCents',
      this,
    );
    purchased = _is.ColumnBool(
      'purchased',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ClaimUpdateTable updateTable;

  late final _is.ColumnInt itemId;

  late final _is.ColumnUuid claimerId;

  late final _is.ColumnInt quantity;

  late final _is.ColumnInt contributionCents;

  late final _is.ColumnBool purchased;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    itemId,
    claimerId,
    quantity,
    contributionCents,
    purchased,
    createdAt,
  ];
}

class ClaimInclude extends _is.IncludeObject {
  ClaimInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Claim.t;
}

class ClaimIncludeList extends _is.IncludeList {
  ClaimIncludeList._({
    _is.WhereExpressionBuilder<ClaimTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Claim.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Claim.t;
}

class ClaimRepository {
  const ClaimRepository._();

  /// Returns a list of [Claim]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Claim>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Claim>(
      where: where?.call(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Claim] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Claim?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Claim>(
      where: where?.call(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Claim] by its [id] or null if no such row exists.
  Future<Claim?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Claim>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Claim]s in the list and returns the inserted rows.
  ///
  /// The returned [Claim]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> insert(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Claim>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Claim] and returns the inserted row.
  ///
  /// The returned [Claim] will have its `id` field set.
  Future<Claim> insertRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Claim>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Claim]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Claim]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> upsert(
    _is.DatabaseSession session,
    List<Claim> rows, {
    required _is.ColumnSelections<ClaimTable> conflictColumns,
    _is.ColumnSelections<ClaimTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Claim>(
      rows,
      conflictColumns: conflictColumns(Claim.t),
      updateColumns: updateColumns?.call(Claim.t),
      updateWhere: updateWhere?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Claim] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Claim] will have its `id` field set.
  Future<Claim?> upsertRow(
    _is.DatabaseSession session,
    Claim row, {
    required _is.ColumnSelections<ClaimTable> conflictColumns,
    _is.ColumnSelections<ClaimTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Claim>(
      row,
      conflictColumns: conflictColumns(Claim.t),
      updateColumns: updateColumns?.call(Claim.t),
      updateWhere: updateWhere?.call(Claim.t),
      transaction: transaction,
    );
  }

  /// Updates all [Claim]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> update(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.ColumnSelections<ClaimTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Claim>(
      rows,
      columns: columns?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Claim]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Claim> updateRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.ColumnSelections<ClaimTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Claim>(
      row,
      columns: columns?.call(Claim.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Claim] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Claim?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClaimUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Claim>(
      id,
      columnValues: columnValues(Claim.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Claim]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClaimUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ClaimTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Claim>(
      columnValues: columnValues(Claim.t.updateTable),
      where: where(Claim.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Claim]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> delete(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Claim>(
      rows,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Claim].
  Future<Claim> deleteRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Claim>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimTable> where,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Claim>(
      where: where(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Claim>(
      where: where?.call(Claim.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Claim] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Claim>(
      where: where(Claim.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
