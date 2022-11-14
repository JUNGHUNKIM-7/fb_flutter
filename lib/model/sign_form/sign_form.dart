import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_form.freezed.dart';

part 'sign_form.g.dart';

@freezed
class Sign with _$Sign {
  factory Sign({
    required String email,
    required String password,
  }) = _Sign;

  factory Sign.fromJson(Map<String, dynamic> json) => _$SignFromJson(json);
}
