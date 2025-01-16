import 'package:dartz/dartz.dart';
import 'package:mate_order_super_user/Features/archive/data/models/archive_model.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class ArchiveService {
  Future<Either<Failure, ArchiveModul>> getArchive() async {
    final result = await Api().get(endPoint: 'archive');

    return result.fold(
      (l) => Left(l),
      (r) => Right(ArchiveModul.fromJson(r)),
    );
  }
}
