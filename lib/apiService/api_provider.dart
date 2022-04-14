import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiServiceProvider = Provider<APIProvider>((ref) {
    return APIProvider();
  });
class APIProvider {

// Future<void> _getCompletedMatches() async {
//   try {
   
//     _matchCompleteeData = await APIServices.getMyCompletedMatches("completed");
//     _completedMatchLists.clear();
//     if (_matchCompleteeData != null &&
//         _matchCompleteeData.response.matchdata.length > 0) {
//       _completedMatchLists
//           .addAll(_matchCompleteeData?.response?.matchdata[0]?.completed);
//     }

   
//   } catch (error) {
//     log("$error", name: "error");
//     //  if (_matchCompleteeData != null)
//     //   showErrorDialog(context, "Server not reachable, Please Contact Admin");
//   } finally {
//     // if (completeTap) {
//     //   Navigator.pop(context);
//     // }
//     //  EasyLoading.dismiss();
//     if (mounted)
//       setState(() {
//         _isProgressRunning = false;
//       });
//   }
//   //  return 1;
// }
}

