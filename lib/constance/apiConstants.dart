class APIConstants {
  static const String BASE_URL = "http://developer.fan11.in/";

  static const String API_BASE_URL = BASE_URL + "api/";

  static const String API_VERSION = "sf/";
  static const String API_CALL_URL = API_BASE_URL + API_VERSION;
  static const CONNECTION_TIMEOUT = 300000;
  static const RECEIVE_TIMEOUT = 300000;

  /// API Requests
  static const String API_LOGIN = "login";
  static const String API_GET_UPCOMING_MATCHES_DASHBOARD = "getMatch";
  static const String API_GET_DEFAULT_CONTEST_BY_TYPE = "getContestByMatch";
  static const String API_GET_SQUAD_TEAM = "getPlayer";
  static const String API_CREATE_TEAM = "createTeam";
  static const String API_GET_TEAM_BY_USER_ID = "getMyTeam";
  static const String API_GET_WALLET = "getWallet";
  static const String API_GET_MY_TEAM_DETAIL_LIST = "getPoints";
  static const String API_GET_SELECT_TEAM_JOIN_CONTEST = "joinContest";
  static const String API_GET_JOIN_CONTEST_STATUS = "joinNewContestStatus";
  static const String API_GET_LEADERBOARD = "leaderBoard";
  static const String API_GET_PRIZEBREAKUP = "getPrizeBreakup";
  static const String API_GET_MYCONTEST = "getMyContest";
  static const String API_GET_JOINEDUPCOMINGMATCHES =
      "getMatchHistory"; // Live //Upcoming // Completed
  static const String API_GET_PLAYINGHISTORY = "getPlayingMatchHistory";
  static const String API_GET_TRANSACTIONHISTORY = "transactionHistory";
  static const String API_GENERATE_CHECKSUM = "generateChecksum.php";
  static const String API_ADD_MONEY = "addMoney";
  static const String CREATE_RAZORPAY_ORDER = "createRazorPayOrder";
  static const String UPDATE_PROFILE = "updateProfile";
  static const String GETUPDATE_PROFILE = "getProfile";
  static const String API_UPDATE_PROFILE_PIC = "uploadbase64Image";
  static const String GET_WITHDRAWAL = "withdrawAmount";
}

class PrefConstants {
  /// header data
  static const String ACCESS_TOKEN = "access-token";

  static const String REFRESH_TOKEN = "refresh-token";
  static const String IS_LOGIN = "isLogin";
  static const String LOGIN_DATA = "loginData";
  static const String USER_ID = "userId";
  static const String USER_NAME = "name";
  static const String USER_EMAIL = "email";
  static const String USER_PROFILE_PIC = "profilePic";
  static const String USER_MOB_NO = "mobileNumber";
  static const String MATCH_ID = "matchId";

  static const String CONTEST_ID = "contestId";
  static const String ENTRY_FEE = "entryFees";
  static const String FIREBASE_TOKEN = "firebaseToken";
  static const String TEAM_NAME = "TeamName";
  static const String CITY = "city";
   static const String USER_DOB = "Dob";
   static const String USER_GENDER = "gender";
  static const String CALL_URL = "callURL";
  static const String USER_REFERAL = "referal";
  static const String APK_URL = "apkURL";
  static const String USER_IMAGE = "profileImage";
  static const String GPAY = "gpay";
  static const String DEPOSIT_AMOUNT = "deposit";
  static const String EXTRA_AMOUNT = "extra";
  static const String WINNING_AMOUNT = "winning";
  static const String BONUS_AMOUNT = "bonus";
  static const String WALLET_AMOUNT = "walletAmount";
  static const String PRIZE_AMOUNT = "prize";
  static const String TOTAL_AMOUNT = "total";
  static const String AFFILIATE_COMMISSION = "affiliateCommission";
  static const String REFFERAL_COUNT = "refferalCount";

  static const String IS_GMAIL_DONE = "isGmailDone";
  static const String IS_FACEBOOK_DONE = "isFacebookDone";
  static const String CONTEST_COUNT = "contestCount";
  static const String MY_TEAM_COUNT = "myTeamCount";
  static const String VERIFY_EMAIL_ADDRESS = "verifyEmailAddress";
  static const String VERIFY_MOBILE_NUMBER = "verifyMobileNumber";
  static const String VERIFY_PAN_CARD = "verifyPanCard";
  static const String PAN_CARD_DOCUMENT_REVIEW_STATUS =
      "panCardDocumentReviewStatus";
  static const String PAN_CARD_DOCUMENT = "panCardDocument";
  static const String VERIFY_BANK_ACCOUNT = "verifyBankAccount";
  static const String BANK_ACCOUNT_DOCUMENT_REVIEW_STATUS =
      "bankAccountDocumentReviewStatus";
  // static const String BANK_ACCOUNT_DOCUMENT = "bankAccountDocument";
  static const String BUILD_NUMBER = "BUILD_NUMBER";
  static const String IMAGE_PATH = "IMAGE_PATH";
  static const String BankName = "BankName";
  static const String BankAccontNumber = "BankAccontNumber";
}

class StringConstant {
  static const String LIVE_MATCHES = "Live";
  static const String UPCOMING_MATCHES = "Upcoming";
  static const String COMPLETED_MATCHES = "Completed";
}
