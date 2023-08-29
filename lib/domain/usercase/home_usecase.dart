
import 'package:dartz/dartz.dart';

import '../../data/network/falier.dart';
import '../entitiy/entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final BaseRepository _baseRepository;
  HomeUseCase(this._baseRepository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _baseRepository.getHomeData();

  }

}

