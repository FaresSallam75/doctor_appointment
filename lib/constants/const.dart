class MyConst {
  // add your appId and appSign from console
  static const int appId = 1897113384; // 524654559;
  static const String appSign =
      "06ecf7cb5a1d486a7b6c430452f0b76a45d8c36181203cc7cad2b40e0bf8384c";
  //"ec4beeebb2cac326ed7bc9c01d65843f36e540333ab86257f38cfe93d635352f";

  static const String apiKeyPaymob =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME5qRXpNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5VcThrOFRZWnNVTF8xT2pud3ltLXJIcXZvUV84MzBWUHlIUWhxSVpFQXhVZ1JMTlRvdDYwVFNncmRXQTJmeGZuVXdqN212M2JKRHVpN3BzN3BiNWpHdw==";
  static const int iframeId = 923378;
  static const int integrationCardId = 5095409;
  static const int integrationMobileWalletId = 5096401;
}


  // payment
  // PaymobPayment.instance.initialize(
  //   apiKey:
  //       "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME5qRXpNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5VcThrOFRZWnNVTF8xT2pud3ltLXJIcXZvUV84MzBWUHlIUWhxSVpFQXhVZ1JMTlRvdDYwVFNncmRXQTJmeGZuVXdqN212M2JKRHVpN3BzN3BiNWpHdw==", // from dashboard Select Settings -> Account Info -> API Key
  //   integrationID:
  //       5095409, // from dashboard Select Developers -> Payment Integrations -> Online Card ID
  //   iFrameID: 923378, // from paymob Select Developers -> iframes
  // );

  // pay
  // PaymentData.initialize(
  //   apiKey:
  //       "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME5qRXpNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5VcThrOFRZWnNVTF8xT2pud3ltLXJIcXZvUV84MzBWUHlIUWhxSVpFQXhVZ1JMTlRvdDYwVFNncmRXQTJmeGZuVXdqN212M2JKRHVpN3BzN3BiNWpHdw==", // Required: Found under Dashboard -> Settings -> Account Info -> API Key
  //   iframeId: "923378", // Required: Found under Developers -> iframes
  //   integrationCardId:
  //       "5095409", // Required: Found under Developers -> Payment Integrations -> Online Card ID
  //   integrationMobileWalletId:
  //       "5096401", // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
  // );