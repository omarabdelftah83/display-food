
//$$$//

import 'package:dartz/dartz.dart';
import '../../data/network/falier.dart';
import '../../data/network/requests.dart';
import '../entitiy/entity.dart';


abstract class BaseRepository{

  Future<Either<Failure,Authentication>>  login(LoginRequest loginRequest );

}