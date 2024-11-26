import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth_imp.dart';
import 'package:spotify/data/repository/songimpl.dart';
import 'package:spotify/data/sources/auth_firebase.dart';
import 'package:spotify/data/sources/song_firebase.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/domain/usecases/get_user_usecase.dart';
//import 'package:spotify/domain/repository/song.dart';
import 'package:spotify/domain/usecases/signin_usecase.dart';
import 'package:spotify/domain/usecases/signup_usecase.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/domain/usecases/song/is_favorite.dart';

final s1 = GetIt.instance;

Future<void> initilizeDependencies() async{

  s1.registerSingleton<AuthFirebase>(
    AuthFirebaseImp()
  );
  s1.registerSingleton<SongFirebase>(
    SongFirebaseImp()
  );

  s1.registerSingleton<AuthRepository>(
    AuthImp()
  );
  //s1.registerSingleton<SongRepository>(
    //SongImpl()
  //);

  s1.registerSingleton<SignupUsecase>(
    SignupUsecase()
  );

  s1.registerSingleton<SigninUsecase>(
    SigninUsecase()
  );
  s1.registerSingleton<GetNewsSongsUsecase>(
    GetNewsSongsUsecase()
  );
  s1.registerSingleton<GetPlayListUsecase>(
    GetPlayListUsecase()
  );
  s1.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
    AddOrRemoveFavoriteSongUsecase()
  );
  
  s1.registerSingleton<IsFavoriteSongUsecase>(
    IsFavoriteSongUsecase()
  );
  s1.registerSingleton<GetUserUsecase>(
    GetUserUsecase()
  );
  s1.registerSingleton<GetFavoriteSongsUsecase>(
    GetFavoriteSongsUsecase()
  );
  
  s1.registerSingleton<SongImpl>(
    SongImpl()
  );
}