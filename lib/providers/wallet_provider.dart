import 'dart:convert';
import 'package:crew_app/models/wallet_job_model.dart';
import 'package:crew_app/providers/base_provider.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:intl/intl.dart';

class WalletProvider extends BaseProvider {
  Future<WalletModel?> getWallet({
    int page = 1,
    int limit = 10,
    String sortField = 'MoveDate',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final query = {
      'page': page.toString(),
      'limit': limit.toString(),
      'sortField': sortField,
    };

    final employeeId = Constants.user?.employeeId;
    if (employeeId != null) {
      query['employeeId'] = employeeId;
    }

    if (startDate != null) {
      query['creationStart'] = DateFormat('yyyy-MM-dd').format(startDate);
    }

    if (endDate != null) {
      query['creationEnd'] = DateFormat('yyyy-MM-dd').format(endDate);
    }

    try {
      final response = await get('/app-wallet/wallet', query: query);
      if (response.status.isOk) {
        final decodedJson = json.decode(response.bodyString!);
        final walletModel = WalletModel.fromJson(decodedJson);
        return walletModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}