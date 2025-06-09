import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supaki_core.dart';

/// Supabase 데이터베이스를 쉽게 사용할 수 있게 해주는 헬퍼 클래스
class SupakiDatabase {
  static SupabaseClient get _client => SupakiClient.instance.supabase;

  /// 테이블에서 모든 데이터 조회
  static Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    try {
      SupakiLogger.info('테이블 전체 조회: $tableName', name: 'SupakiDatabase');

      final response = await _client.from(tableName).select();

      SupakiLogger.info(
        '테이블 전체 조회 성공: $tableName (${response.length}개)',
        name: 'SupakiDatabase',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      SupakiLogger.error(
        '테이블 전체 조회 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// ID로 단일 데이터 조회
  static Future<Map<String, dynamic>?> getById(
    String tableName,
    dynamic id, {
    String idColumn = 'id',
  }) async {
    try {
      SupakiLogger.info('ID로 조회: $tableName/$id', name: 'SupakiDatabase');

      final response = await _client
          .from(tableName)
          .select()
          .eq(idColumn, id)
          .maybeSingle();

      SupakiLogger.info('ID로 조회 성공: $tableName/$id', name: 'SupakiDatabase');
      return response;
    } catch (e) {
      SupakiLogger.error(
        'ID로 조회 실패: $tableName/$id',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 조건으로 데이터 조회
  static Future<List<Map<String, dynamic>>> getWhere(
    String tableName, {
    required String column,
    required dynamic value,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    try {
      SupakiLogger.info(
        '조건 조회: $tableName where $column = $value',
        name: 'SupakiDatabase',
      );

      var query = _client.from(tableName).select().eq(column, value);

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;

      SupakiLogger.info(
        '조건 조회 성공: $tableName (${response.length}개)',
        name: 'SupakiDatabase',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      SupakiLogger.error(
        '조건 조회 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 페이지네이션을 사용한 데이터 조회
  static Future<List<Map<String, dynamic>>> getPaginated(
    String tableName, {
    int page = 1,
    int pageSize = 20,
    String? orderBy,
    bool ascending = true,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      SupakiLogger.info(
        '페이지네이션 조회: $tableName (page: $page, size: $pageSize)',
        name: 'SupakiDatabase',
      );

      var query = _client.from(tableName).select();

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      final response = await query.range(offset, offset + pageSize - 1);

      SupakiLogger.info(
        '페이지네이션 조회 성공: $tableName (${response.length}개)',
        name: 'SupakiDatabase',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      SupakiLogger.error(
        '페이지네이션 조회 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 데이터 삽입
  static Future<Map<String, dynamic>> insert(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    try {
      SupakiLogger.info('데이터 삽입: $tableName', name: 'SupakiDatabase');

      final response = await _client
          .from(tableName)
          .insert(data)
          .select()
          .single();

      SupakiLogger.info('데이터 삽입 성공: $tableName', name: 'SupakiDatabase');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '데이터 삽입 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 삽입에 실패했습니다: ${e.toString()}');
    }
  }

  /// 여러 데이터 삽입
  static Future<List<Map<String, dynamic>>> insertMany(
    String tableName,
    List<Map<String, dynamic>> dataList,
  ) async {
    try {
      SupakiLogger.info(
        '다중 데이터 삽입: $tableName (${dataList.length}개)',
        name: 'SupakiDatabase',
      );

      final response = await _client.from(tableName).insert(dataList).select();

      SupakiLogger.info('다중 데이터 삽입 성공: $tableName', name: 'SupakiDatabase');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      SupakiLogger.error(
        '다중 데이터 삽입 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 삽입에 실패했습니다: ${e.toString()}');
    }
  }

  /// 데이터 업데이트
  static Future<Map<String, dynamic>> update(
    String tableName,
    Map<String, dynamic> data, {
    required String idColumn,
    required dynamic idValue,
  }) async {
    try {
      SupakiLogger.info(
        '데이터 업데이트: $tableName/$idValue',
        name: 'SupakiDatabase',
      );

      final response = await _client
          .from(tableName)
          .update(data)
          .eq(idColumn, idValue)
          .select()
          .single();

      SupakiLogger.info(
        '데이터 업데이트 성공: $tableName/$idValue',
        name: 'SupakiDatabase',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '데이터 업데이트 실패: $tableName/$idValue',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 업데이트에 실패했습니다: ${e.toString()}');
    }
  }

  /// 조건으로 데이터 업데이트
  static Future<List<Map<String, dynamic>>> updateWhere(
    String tableName,
    Map<String, dynamic> data, {
    required String column,
    required dynamic value,
  }) async {
    try {
      SupakiLogger.info(
        '조건 업데이트: $tableName where $column = $value',
        name: 'SupakiDatabase',
      );

      final response = await _client
          .from(tableName)
          .update(data)
          .eq(column, value)
          .select();

      SupakiLogger.info(
        '조건 업데이트 성공: $tableName (${response.length}개)',
        name: 'SupakiDatabase',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      SupakiLogger.error(
        '조건 업데이트 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 업데이트에 실패했습니다: ${e.toString()}');
    }
  }

  /// 데이터 삭제
  static Future<void> delete(
    String tableName, {
    required String idColumn,
    required dynamic idValue,
  }) async {
    try {
      SupakiLogger.info('데이터 삭제: $tableName/$idValue', name: 'SupakiDatabase');

      await _client.from(tableName).delete().eq(idColumn, idValue);

      SupakiLogger.info(
        '데이터 삭제 성공: $tableName/$idValue',
        name: 'SupakiDatabase',
      );
    } catch (e) {
      SupakiLogger.error(
        '데이터 삭제 실패: $tableName/$idValue',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 삭제에 실패했습니다: ${e.toString()}');
    }
  }

  /// 조건으로 데이터 삭제
  static Future<void> deleteWhere(
    String tableName, {
    required String column,
    required dynamic value,
  }) async {
    try {
      SupakiLogger.info(
        '조건 삭제: $tableName where $column = $value',
        name: 'SupakiDatabase',
      );

      await _client.from(tableName).delete().eq(column, value);

      SupakiLogger.info('조건 삭제 성공: $tableName', name: 'SupakiDatabase');
    } catch (e) {
      SupakiLogger.error(
        '조건 삭제 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('데이터 삭제에 실패했습니다: ${e.toString()}');
    }
  }

  /// 개수 조회
  static Future<int> count(
    String tableName, {
    String? column,
    dynamic value,
  }) async {
    try {
      SupakiLogger.info('개수 조회: $tableName', name: 'SupakiDatabase');

      var query = _client
          .from(tableName)
          .select('*', const FetchOptions(count: CountOption.exact));

      if (column != null && value != null) {
        query = query.eq(column, value);
      }

      final response = await query;
      final count = response.count ?? 0;

      SupakiLogger.info(
        '개수 조회 성공: $tableName ($count개)',
        name: 'SupakiDatabase',
      );
      return count;
    } catch (e) {
      SupakiLogger.error(
        '개수 조회 실패: $tableName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('개수 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// RPC 함수 실행
  static Future<dynamic> rpc(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      SupakiLogger.info('RPC 함수 실행: $functionName', name: 'SupakiDatabase');

      final response = await _client.rpc(functionName, params: params);

      SupakiLogger.info('RPC 함수 실행 성공: $functionName', name: 'SupakiDatabase');
      return response;
    } catch (e) {
      SupakiLogger.error(
        'RPC 함수 실행 실패: $functionName',
        error: e,
        name: 'SupakiDatabase',
      );
      throw SupakiDataException('RPC 함수 실행에 실패했습니다: ${e.toString()}');
    }
  }

  /// 트랜잭션 실행
  static Future<T> transaction<T>(Future<T> Function() transaction) async {
    try {
      SupakiLogger.info('트랜잭션 시작', name: 'SupakiDatabase');

      // Supabase는 자동 트랜잭션을 지원하므로 함수를 바로 실행
      final result = await transaction();

      SupakiLogger.info('트랜잭션 성공', name: 'SupakiDatabase');
      return result;
    } catch (e) {
      SupakiLogger.error('트랜잭션 실패', error: e, name: 'SupakiDatabase');
      throw SupakiDataException('트랜잭션 실행에 실패했습니다: ${e.toString()}');
    }
  }
}
