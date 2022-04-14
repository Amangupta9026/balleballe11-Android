// import 'package:balleballe11/constance/packages.dart';
// import 'package:balleballe11/model/my_completed_matches_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final completedMatchesResponseChangeNotify =
//     ChangeNotifierProvider<CompletedMatchesResponseProvider>((ref) {
//   return CompletedMatchesResponseProvider(ref: ref);
// });

// class CompletedMatchesResponseProvider extends ChangeNotifier {
//   Ref ref;
//   APIServices repo;
//   bool isLoading;
//   dynamic error;
//   MyCompletedMatchesModel completedMatchesResponse;

//   CompletedMatchesResponseProvider({this.ref, String actionType}) {
//     repo = ref.read(apiServiceProvider);
//     completedMatchesProvider(actionType);
//   }

//   Future completedMatchesProvider(String actionType) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//       completedMatchesResponse = await repo.getMyCompletedMatches(actionType);

//       error = null;
//     } catch (e) {
//       error = e;
//       // rethrow;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
