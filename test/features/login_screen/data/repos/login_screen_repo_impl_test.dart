import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sieve_data_privacy_app/core/error/Faliure.dart';
import 'package:sieve_data_privacy_app/core/Platform/network_info.dart';
import 'package:sieve_data_privacy_app/core/Error/exceptions.dart';
import 'package:sieve_data_privacy_app/features/login_screen/data/datasources/login_screen_local_datasource.dart';
import 'package:sieve_data_privacy_app/features/login_screen/data/datasources/login_screen_remote_datasource.dart';
import 'package:sieve_data_privacy_app/features/login_screen/data/models/login_user_model.dart';
import 'package:sieve_data_privacy_app/features/login_screen/data/repos/login_screen_repo_impl.dart';
import 'package:sieve_data_privacy_app/features/login_signup_screen/domain/repos/login_signup_screen_repo.dart';

class MockLoginSignupScreenRepo extends Mock implements LoginSignuScreenRepo {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLoginScreenRemoteDataSource extends Mock
    implements LoginScreenRemoteDataSource {}

class MockLoginScreenLocalDataSource extends Mock
    implements LoginScreenLocalDataSource {}

void main() {
  MockLoginSignupScreenRepo mockLoginSignupScreenRepo;
  MockNetworkInfo mockNetworkInfo;
  MockLoginScreenRemoteDataSource mockLoginScreenRemoteDataSource;
  MockLoginScreenLocalDataSource mockLoginScreenLocalDataSource;
  LoginScreenRepoImpl loginScreenRepoImpl;

  setUp(() {
    mockLoginSignupScreenRepo = new MockLoginSignupScreenRepo();
    mockNetworkInfo = new MockNetworkInfo();
    mockLoginScreenRemoteDataSource = new MockLoginScreenRemoteDataSource();
    mockLoginScreenLocalDataSource = new MockLoginScreenLocalDataSource();
    loginScreenRepoImpl = new LoginScreenRepoImpl(
        loginScreenLocalDataSource: mockLoginScreenLocalDataSource,
        loginScreenRemoteDataSource: mockLoginScreenRemoteDataSource,
        loginSignuScreenRepo: mockLoginSignupScreenRepo,
        networkInfo: mockNetworkInfo);
  });

  final String id = '1';
  final String email = 'test1@gmail.com';
  final String password = 'Test@123';
  final String imageUrl = 'www.google.com';
  final String uid = '1';
  final LoginUserModel tLoginUserModel = new LoginUserModel(
      id: id, email: email, password: password, imageUrl: imageUrl, uid: uid);

  void groupTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('getFacebookLogin', () {
    test(
      'should return EmptyEntity when returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getFacebookLogin())
            .thenAnswer((_) async => Right(tLoginUserModel));
        //act
        final response = await loginScreenRepoImpl.getFacebookLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getFacebookLogin());
        expect(response, Right(tLoginUserModel));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return InternetConnectionFailure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getFacebookLogin())
            .thenAnswer((_) async => Left(InternetConnectionFaliure()));
        //act
        final response = await loginScreenRepoImpl.getFacebookLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getFacebookLogin());
        expect(response, Left(InternetConnectionFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return ServerFaliure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Left(ServerFaliure()));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Left(ServerFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return UserBlockedFaliure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Left(UserBlockedFaliure()));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Left(UserBlockedFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );
  });

  group('getGoogleLogin', () {
    test(
      'should return EmptyEntity when returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Right(tLoginUserModel));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Right(tLoginUserModel));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return InternetConnectionFailure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Left(InternetConnectionFaliure()));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Left(InternetConnectionFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return ServerFaliure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Left(ServerFaliure()));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Left(ServerFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );

    test(
      'should return UserBlockedFaliure when not returned properly',
      () async {
        //arrange
        when(mockLoginSignupScreenRepo.getGoogleLogin())
            .thenAnswer((_) async => Left(UserBlockedFaliure()));
        //act
        final response = await loginScreenRepoImpl.getGoogleLogin();

        //assert
        verify(mockLoginSignupScreenRepo.getGoogleLogin());
        expect(response, Left(UserBlockedFaliure()));
        verifyNoMoreInteractions(mockLoginSignupScreenRepo);
      },
    );
  });

  group('getLogin', () {
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //act
        await loginScreenRepoImpl.getLogin(email, password);
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    groupTestOnline(() {
      test(
        'should return LoginUser when sent the correct data',
        () async {
          //arrange
          when(mockLoginScreenRemoteDataSource.getLoginUser(any, any))
              .thenAnswer((_) async => tLoginUserModel);
          //act
          final resilt = await loginScreenRepoImpl.getLogin(email, password);
          await untilCalled(
              mockLoginScreenLocalDataSource.cacheLoginUser(tLoginUserModel));
          //assert
          expect(resilt, Right(tLoginUserModel));
        },
      );
      test(
        'should return InvalidInputFaliure when sent the incorrect data',
        () async {
          //arrange
          when(mockLoginScreenRemoteDataSource.getLoginUser(any, any))
              .thenThrow(InvalidInputException());
          //act
          final resilt = await loginScreenRepoImpl.getLogin(email, password);
          //assert
          expect(resilt, Left(InvalidInputFaliure()));
        },
      );
      test(
        'should return ServerFaliure when ServerException',
        () async {
          //arrange
          when(mockLoginScreenRemoteDataSource.getLoginUser(any, any))
              .thenThrow(ServerException());
          //act
          final resilt = await loginScreenRepoImpl.getLogin(email, password);
          //assert
          expect(resilt, Left(ServerFaliure()));
        },
      );
      test(
        'should return UserBlockedFaliure when sent the incorrect data',
        () async {
          //arrange
          when(mockLoginScreenRemoteDataSource.getLoginUser(any, any))
              .thenThrow(UserBlockedException());
          //act
          final resilt = await loginScreenRepoImpl.getLogin(email, password);
          //assert
          expect(resilt, Left(UserBlockedFaliure()));
        },
      );
    });

    test(
      'should return InternetConnectionFaliure when there is no internet',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final response = await loginScreenRepoImpl.getLogin(email, password);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(response, Left(InternetConnectionFaliure()));
        verifyNoMoreInteractions(mockNetworkInfo);
      },
    );
  });
}
