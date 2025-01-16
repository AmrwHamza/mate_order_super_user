import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'package:mate_order_super_user/Features/archive/data/repository/archive_service.dart';

part 'get_archive_state.dart';

class GetArchiveCubit extends Cubit<GetArchiveState> {
  GetArchiveCubit() : super(GetArchiveInitial());

  Future<void> getArchive() async {
    emit(GetArchiveLoading());
    final result = await ArchiveService().getArchive();

    result.fold(
      (l) => emit(GetArchiveError(message: l.message)),
      (r) => emit(GetArchiveSuccess(products: r.data!)),
    );
  }
}
