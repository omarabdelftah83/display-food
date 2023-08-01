import 'package:dartz/dartz.dart';
import 'package:mina/data/network/falier.dart';

abstract class BaseUseCase<In,out>{
  Future<Either<Failure,out>>execute(In input);
}