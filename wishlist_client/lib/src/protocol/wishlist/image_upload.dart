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

/// What the app needs to upload an item picture.
abstract class ImageUpload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ImageUpload._({
    required this.path,
    required this.description,
  });

  factory ImageUpload({
    required String path,
    required String description,
  }) = _ImageUploadImpl;

  factory ImageUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImageUpload(
      path: jsonSerialization['path'] as String,
      description: jsonSerialization['description'] as String,
    );
  }

  /// Where the file will be stored. Sent back to attachImage.
  String path;

  /// Opaque upload instructions, for the client's FileUploader.
  String description;

  /// Returns a shallow copy of this [ImageUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ImageUpload copyWith({
    String? path,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImageUpload',
      'path': path,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ImageUpload',
      'path': path,
      'description': description,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ImageUploadImpl extends ImageUpload {
  _ImageUploadImpl({
    required String path,
    required String description,
  }) : super._(
         path: path,
         description: description,
       );

  /// Returns a shallow copy of this [ImageUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ImageUpload copyWith({
    String? path,
    String? description,
  }) {
    return ImageUpload(
      path: path ?? this.path,
      description: description ?? this.description,
    );
  }
}
