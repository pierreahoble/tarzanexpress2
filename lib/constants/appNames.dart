abstract class AppNames {
  ///
  ///API URL Tarzan express
  static const String hostUrl = "https://app.tarzan-express.com/"; //"http://192.168.1.68:8002/";
  static const String getCountries = "api/pays";
  static const String checkExistence = "api/users/check_phone_number";
  static const String recoverPassword = "api/users/change_password_forget";
  static const String signIn = "api/login";
  static const String signUp = "api/register";
  static const String updateProfile = "api/users/update/";
  static const String getMessages = "api/messages/commandes/";
  static const String postMessage = "api/messages/send/";
  static const String postMessageImage = "api/messages/send/picture/";
  static const String payOrderByWallet = "api/commande/checkout/wallet";
  static const String rechargeWallet = "api/portefeuilles/charger";
  static const String checkWalletAmount = "api/portefeuilles";
  static const String modesLivraison = "api/pays?query=agences";
  static const String createOrder = "api/commande/store";
  static const String getOrders = "api/commande";
  static const String getLinkForAide = "api/aide";
  static const String getOrderPerId = "api/commande/show/";
  static const String serviceClientPost = "api/service_client/chat/send/";
  static const String serviceClientPostImg = "api/service_client/chat/picture/";
  static const String serviceClientGet = "api/service_client/chat";
  static const String countFilleuls = "api/users/affilies/count";
  static const String getNotifications = "api/notifications_view";
  static const String notificationUnreadCounter = "api/notifications";
  static const String notificationUnreadIds = "api/notifications/not-read";
  static const String notificationIsRead = "api/notifications/update/read_state/";
  static const String changePassword = "api/users/change_password";
  static const String getArticles = "api/articles";
  static const String unreadMessages = "api/messages/messages-non-lus";
  static const String getTransacts = "api/transactions/historique";
  static const String triggerMissed = "api/notifications/trigger_missed";
  static const String checkState = "api/transaction/";
  static const String debts = "api/commande/checkout/left-to-pay";
  static const String debtsDetails = "api/commande/checkout/left-to-pay/details";

//WHATSAPP NUMBER
  ///API URL Tarzan Opportunité
  static const String HostUrlTarzanOpp ="apitest-opportunite.tarzan-express.com";
  static const String AllCategotieTO = "api/v1/categorie/all";
  static const String AllBoutiquesTO = "api/v1/boutique/all";
  static const String AllMarquesTO = "api/v1/marque/all";

  ///
  ///BRANDS
  static const String aliExpressFr = "https://fr.aliexpress.com/?gatewayAdapt=glo2fra";
  static const String alibabaFr = "https://m.french.alibaba.com/";
  static const String amazonFr = "https://www.amazon.fr/";
  static const String sheinFr = "https://m.shein.com/fr/";
  static const String geeksHouse = "https://www.geeks-house.com/";

  ///
  /// Store `Panier` in db
  static const String PANIER_DATABASE = 'panier_database.db';

  ///
  /// Database name
  static const String LOCAL_DATABASE = 'local_database';

  ///
  ///Methodes
  static const String methodePaiementFLOOZ = "FLOOZ";
  static const String methodePaiementTMONEY = "T-MONEY";
  static const String methodePaiementPortefeuille = "PORTEFEUILLE";

  ///Event-sources
  static const String eventNewChat = "MESSAGERIE";
  static const String eventNewChatClient = "MESSAGERIE_CLIENT";
  static const String eventChangementEtat = "ETAT_COMMANDE";
  static const String eventNewCmd = "NOUVELLE_COMMANDE";
  static const String eventPositionColis = "POSITION_COLIS";
  static const String eventPaiementCmd = "CONFIRMATION_PAIEMENT";
  static const String eventRecharge = "PORTEFEUILLE_RECHARGE";
}
