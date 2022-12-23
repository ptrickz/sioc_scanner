import 'package:gsheets/gsheets.dart';
import 'package:sioc_scanner/Model/assets.dart';

class AssetsSheetsApi {
  static const credentials = r'''
{
  "type": "service_account",
  "project_id": "siocscanner-a3839",
  "private_key_id": "12d320862c410702f258ca48edf053ee22c403c3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDjcWqFdFTzB4wj\nocIqdlYv+My+SSsqDcbTXDIAHBgAdmRcIvuwryxp55h0TfB1HgtauLsHM1Q3Veui\ntse2h3U6gM6JoeIxMhoL5ItHiL5KHp/dxQvQwwuCDpMc4x0EFzBXcrCI+8PAwNFR\nzfwg98TkeOc/5kL4JuUfBvc54gb1/brwxCT3zcVTJk3CWfQtXwk7O4C8ibRR92r9\n7SPlgesR80hnp2q/hKEfzrU1pv5jo03Rs32vNeATCAP8o/plNtkDhCp6qzDFCXqK\n9VRz3dGOvWHbMSp7tE3JsKMxj65soNNez91pex0I2NpXDuxFN3U7TUsfwV+R4Zsi\nU2Z4wtWVAgMBAAECggEACMH3u47IrJj4TPDwFIl89Rjr7VHM7zAbnUzaAgYS6IWm\nhKO2NE3ydFt+E9Bid2gCQOqHDRZtYjoVOi02kHEz0t5d1Y/dsU5AEYAp2sXJqfn2\n5ues9ktkWIwuHvkhx2QLMPrSEFw9Y+EozjETycMwmimLofrATmTVArZWc6yf3v3l\nClVYUYEpQ+viiCG0qRjzdtSjUpZgg6YBynrxizuGRTCIj/hcqCdR1RorjswoLOqn\nCMGqFBk67FW3cHNGspYOiZ1DkYAiGHP4929QIeYPBIogwiNO1TE1z3pPQAkLqknK\nmgtAAlz1XeLkufJN5gXtjDHrFjY1anbws3VM9EXGOwKBgQD5yV7gulcS6564xBCU\nFK8alnLSHfPP2qZ39TWKcrCAQbdcMJWtE0LZsn8kKwM7n/14DSYcRcOz70SRjaMP\nKrZyrbyeFFzEVC7jp79i2q7Chv1TViaPF2zbWEphJ/l6XjOB7tOqib2egGu9G0X/\nZ1UoYmuof5NxrfUfmZxRnvLdawKBgQDpGcM9w0YGpbN2WtUWkViumjkeseQL7Rfk\nU1uiw4L/twtn4L7/nIj+7RURBPzVX0i2VCEnaJpkynn41UpZ3qqwuokw6zs9kFiY\nEEZ5AgJhSxiJ2f7+jjkKl+/YzXMiHgDiEOTpUFlX5cf/rZrIagy/khNDwpcqvZd0\nI4WvmZLY/wKBgDNEVFfVhweYGpSbkTeDY0kWtexQP3lazC30ww9uaLF6S3L9ecrz\nGBZsX1ICDgDP3oskT70fyIIGytEA/AWh45538C2VylB1YsZQ6KQWdCXy5M2U8gcO\nbMY8Qc/dD4RBD1tMtF7dNHDytKo0jdJU2BKY2LXVsWJ0rMnWklHiSMCPAoGAA/n6\niK0yHp7pBtXZ2L62ApSC8PEb8NAknjKF16r6Kx6WRTliSL4E4ERvHZE2NvWfKe0Z\ne7CfIaUKm6IX2Jyh0M391SXOJui1ejKc4SeVns9HJeLgJLuMYY/h+ZLXqfdVEIY1\nQX2raIJ0/PmbMFwOx53YUkmZhpMhaEvK1goKpUUCgYEAp9V49l4iyXbQW4SGC+/5\nKRctSXof7qXs7bay5deaxmxtyiv0B4uZnAQ8rI25cUZPQgJAXA0jAxNvcqit3iUU\n+XvxNKiYsX/EibvJZjHPtj8I0O/9NIInH8C5A5OfVbs5205k8DIpY3afG73r5SGk\n6FGS8vAgxgiyeX7vMcSIp8A=\n-----END PRIVATE KEY-----\n",
  "client_email": "siocsheets@siocscanner-a3839.iam.gserviceaccount.com",
  "client_id": "114497131389374513140",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/siocsheets%40siocscanner-a3839.iam.gserviceaccount.com"
}

''';
  static const spreadsheetID = '1BGtAf-McqXD4RPmfR9EgbSnfjH1EydqXVr9h2_-WTgU';
  static final gsheets = GSheets(credentials);
  static Worksheet? assetSheet;

  static Future init() async {
    try {
      final spreadsheet = await gsheets.spreadsheet(spreadsheetID);
      assetSheet = await getAssestSheet(spreadsheet, title: "Asset List");

      final headerRow = AssetFields.getFields();
      assetSheet!.values.insertRow(1, headerRow);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<Worksheet> getAssestSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<Assets?> getById(String id) async {
    if (assetSheet == null) return null;
    final json = await assetSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Assets.fromJson(json);
  }

  static Future<int> getRowCount() async {
    if (assetSheet == null) return 0;
    final lastRow = await assetSheet!.values.lastRow();
    return lastRow == null
        ? 0
        : int.tryParse(lastRow.first
                .replaceAll("SIOC", "")
                .replaceAll("-", "")
                .replaceAll("Asset", "")) ??
            0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (assetSheet == null) return;
    assetSheet!.values.map.appendRows(rowList);
  }
}
