import 'package:dartz/dartz.dart';
import 'package:mina/data/network/requests.dart';

import '../../data/network/falier.dart';
import '../entitiy/entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final BaseRepository _baseRepository;

  RegisterUseCase(this._baseRepository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    ///take data in RegisterRequest to RegisterUseCaseInput//
    return await _baseRepository.register(RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.profilePicture));
  }
}

// class LoginUseCaseInput {
//   String email;
//   String password;
//
//   LoginUseCaseInput(this.email, this.password);
// }

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;

  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);
}
