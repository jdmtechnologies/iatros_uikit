import 'package:iatros_uikit/models/user_model.dart';

/// Modelo que representa un registro de actualización de usuario.
/// Contiene el id del usuario que realizó la actualización y el estado anterior del usuario.
class UserRecordModel {
  final String userUpdater;
  final UserModel oldUser;

  UserRecordModel({
    required this.userUpdater,
    required this.oldUser,
  });

  UserRecordModel copyWith({
    String? userUpdater,
    UserModel? oldUser,
  }) =>
      UserRecordModel(
        userUpdater: userUpdater ?? this.userUpdater,
        oldUser: oldUser ?? this.oldUser,
      );

  factory UserRecordModel.fromJson(Map<String, dynamic> json) =>
      UserRecordModel(
        userUpdater: json["user_updater"]?.toString() ?? "",
        oldUser: UserModel.fromJson(json["old_user"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "user_updater": userUpdater,
        "old_user": oldUser.toJson(),
      };
}
