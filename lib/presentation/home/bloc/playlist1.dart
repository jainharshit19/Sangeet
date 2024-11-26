import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/presentation/home/bloc/playlist2.dart';
import 'package:spotify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit():super(PlayListLoading());

  Future<void> getsPlayList() async {
    print("Harsh");
    var returnedSongs = await s1<GetPlayListUsecase>().call();
    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      
      (data) {
        
        emit(PlayListLoaded(songs: data));
      }
    );
  }

  
}
