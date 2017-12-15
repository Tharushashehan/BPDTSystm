

//main connection link
var mainServer = "Test";
var server = "http://localhost:21626/" + "api/";
var server3 = mainServer + "api/BPDTSystemApi/";
//var ReturnUrl;

//sub links

//For NLP url
var GetNLPAnswer = server + "NLPFront/GetNLPAnswerData";

//login
var userLoginLink = server + "User/UserLogin";

//user
var userSaveLink = server + "User/RegisterAdmin";
var ResetLogin = server + "User/ResetLogin";
var sendNewPasswordDetailsLink = server + "ResetPassword";
var resetPasswordLink = server + "UserAccess/User_Forgot_Password";
var checkVerificationLink = server + "UserAccess/Verify_Password_Reset_Code";
var tokengenerationLink = mainServer + "Token";
var checkUsernameExist = server + "User/CheckUserNameUnique";

//Admin links
var SaveRegularRegistrationData = server + "Admin/SaveRegularRegistrationData";
var SaveProRataRegistrationData = server + "ProRataRegistration/SaveProRataRegistrationData";
var SaveRepeatRegistrationData = server + "RepeatRegistration/SaveRepeatRegistrationData";
var LoginAuthorization = server + "Login/LoginAuthorization";
var GetAllUserData = server + "UsersList/GetAllUserData";
var DeleteAllData = server + "NewsFeed/DeleteAllData";
var SaveUserData = server + "SaveUser/SaveUserData";

var AutocompleteProrataRegistrationData = server + "ProRataRegistrationAutocomplete/AutocompleteProrataRegistrationData";
var LoadProrataRegistrationData = server + "ProrataRegistrationLoadData/LoadProrataRegistrationData";

var AutocompleteRegularRegistrationData = server + "RegularRegistrationAutocomplete/AutocompleteRegularRegistrationData";
var LoadRegularRegistrationData = server + "RegularRegistrationLoadData/LoadRegularRegistrationData";

var AutocompleteRepeatRegistrationData = server + "RepeatRegistrationAutocomplete/AutocompleteRepeatRegistrationData";
var LoadRepeatRegistrationData = server + "RepeatRegistrationLoadData/LoadRepeatRegistrationData";

var token = server + "Authorized";