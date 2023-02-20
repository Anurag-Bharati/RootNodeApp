import 'package:flutter_test/flutter_test.dart';
import 'package:rootnode/data_source/remote_data_store/user_remote_data_source.dart';
import 'package:rootnode/model/user.dart';

void main() {
  test("User register test", () async {
    // Arrange
    int matcher = 0; // user already exists so 0 should be returned
    User user = User(
      fname: "anurag",
      lname: "bharati",
      email: "anurag@anurag.com",
      password: "anurag123",
    );

    //Act
    int actual = await UserRemoteDataSource().register(user);

    // Assert
    expect(actual, matcher);
  });

  test("User login test", () async {
    // Arrange
    bool matcher = true;
    String username = "anuragbharati";
    String password = "anurag";
    // Act
    bool actual = await UserRemoteDataSource()
        .login(identifier: username, password: password, isEmail: false);
    // Assert
    expect(actual, matcher);
  });

  test("User from id test", () async {
    // Arrange
    String myId = "63d2a32d69b2e6e141abd01e";
    String username = "anuragbharati";
    User? actual;
    // Act

    actual = await UserRemoteDataSource().getUserById(id: myId);
    // Assert
    expect(actual?.username, username);
  });

  test("User from token test", () async {
    // Arrange
    String username = "anuragbharati";
    String password = "anurag";
    // Act
    await UserRemoteDataSource()
        .login(identifier: username, password: password, isEmail: false);
    User? actual = await UserRemoteDataSource().getUserFromToken();
    // Assert
    expect(actual?.username, username);
  });
}
