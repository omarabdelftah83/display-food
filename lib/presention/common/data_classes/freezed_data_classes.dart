
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';
@freezed
///storage name __pass///
class LoginObject with _$LoginObject{
  factory LoginObject(String userName,String password)= _LoginObject;

}
