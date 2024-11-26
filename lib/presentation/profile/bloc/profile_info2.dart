import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/get_user_usecase.dart';
import 'package:spotify/presentation/profile/bloc/profile_info1.dart';
import 'package:spotify/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit () :super(ProfileInfoLoading());
  Future<void> getUser() async {
    var user = await s1<GetUserUsecase>().call();
    user.fold(
      (l){
        emit(
          ProfileInfoFailure()
        );
      }, 
      (userEntity) {
        emit(
          ProfileInfoLoaded(userEntity: userEntity)
        );
      }
    );
  }
}