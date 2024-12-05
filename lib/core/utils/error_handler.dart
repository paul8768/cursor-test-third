class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is Exception) {
      return '오류가 발생했습니다. 다시 시도해주세요.';
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했습니다.';
  }
} 