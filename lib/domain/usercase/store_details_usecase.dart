
import 'package:dartz/dartz.dart';

import '../../data/network/falier.dart';
import '../entitiy/entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUseCaseUseCase implements BaseUseCase<void,StoreDetails>{
  final BaseRepository _baseRepository;
  StoreDetailsUseCaseUseCase(this._baseRepository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async{
    return await _baseRepository.getStoreDetails();

  }

}
