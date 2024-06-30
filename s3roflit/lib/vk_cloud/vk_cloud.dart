import 'package:s3roflit/interface/storage_interface.dart';
import 'package:s3roflit/src/config/s3/dto.dart';
import 'package:s3roflit/yandex_cloud/constants.dart';
import 'package:s3roflit/yandex_cloud/requests/buckets.dart';
import 'package:s3roflit/yandex_cloud/requests/objects.dart';

final class VKCloud implements StorageInterface {
  final YandexAccess _access;

  VKCloud({
    required String accessKey,
    required String secretKey,
    String host = YCConstant.host,
    String region = YCConstant.region,
  }) : _access = YandexAccess(
          accessKey: accessKey,
          secretKey: secretKey,
          host: host,
          region: region,
        );

  @override
  String get host => 'https://${_access.host}';

  @override
  StorageBucketRequestsInterface get buckets => YandexRequestsBucket(_access);

  @override
  StorageObjectRequestsInterface get objects => YandexRequestsObject(_access);
}
