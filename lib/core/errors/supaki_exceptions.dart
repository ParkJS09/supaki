/// Supaki 기본 예외 클래스
abstract class SupakiException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const SupakiException(this.message, {this.code, this.details});

  @override
  String toString() =>
      'SupakiException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// 설정 관련 예외
class SupakiConfigException extends SupakiException {
  const SupakiConfigException(super.message, {super.code, super.details});
}

/// 네트워크 관련 예외
class SupakiNetworkException extends SupakiException {
  const SupakiNetworkException(super.message, {super.code, super.details});
}

/// 인증 관련 예외
class SupakiAuthException extends SupakiException {
  const SupakiAuthException(super.message, {super.code, super.details});
}

/// 데이터 관련 예외
class SupakiDataException extends SupakiException {
  const SupakiDataException(super.message, {super.code, super.details});
}

/// 스토리지 관련 예외
class SupakiStorageException extends SupakiException {
  const SupakiStorageException(super.message, {super.code, super.details});
}

/// 서버 오류 예외
class SupakiServerException extends SupakiException {
  final int? statusCode;

  const SupakiServerException(
    super.message, {
    this.statusCode,
    super.code,
    super.details,
  });

  @override
  String toString() =>
      'SupakiServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}${code != null ? ' (Code: $code)' : ''}';
}

/// 클라이언트 오류 예외
class SupakiClientException extends SupakiException {
  const SupakiClientException(super.message, {super.code, super.details});
}
