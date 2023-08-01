import 'package:dartz/dartz.dart';
import 'package:mina/data/network/falier.dart';
import 'package:mina/data/network/requests.dart';
import 'package:mina/domain/entitiy/entity.dart';
import 'package:mina/domain/repository/repository.dart';
import 'package:mina/domain/usercase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
 final BaseRepository _baseRepository;
  LoginUseCase(this._baseRepository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
return await _baseRepository.login(LoginRequest(input.email,input.password));
  }
  
  }
  

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}