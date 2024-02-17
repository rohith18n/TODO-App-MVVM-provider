abstract class AuthenticationDatasource {
  Future<String?> register(
    String email,
    String password,
    String passwordConfirm,
  );
  Future<String?> login(String email, String password);
}
