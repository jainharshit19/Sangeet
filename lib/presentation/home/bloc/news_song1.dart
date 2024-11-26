import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/presentation/home/bloc/news_songs2.dart';
import 'package:spotify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit():super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    print("Hi");
    var returnedSongs = await s1<GetNewsSongsUsecase>().call();
    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      
      (data) {
        
        emit(NewsSongsLoaded(songs: data));
      }
    );
  }
}
