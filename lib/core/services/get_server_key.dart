import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "chulesi-app",
        "private_key_id": "0ab55867bef395598da074f529097152c703f079",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCXLMMPWwhxUJat\nDfBG9p1DH9q3TeyR3SZdPcF2bsFa3Bamorf60HvW2sVT4NYzOy0yeb8H//lD+fs3\ni8t48rZzQKzTqRtCTUuyEkAy2nx7cbsPckheoKW6ITPD57Vbb+HfxNX9QAvTh2gu\nJaAWWRuF+Xz7XMrWFZDRTyxoP5L+stG8KnyHKK00gegrZXi56Wh5jrr9zNTWW7qk\nKT3Kf7Q0jc43c6jfu58DmrT6nyijq8ZJh1ktNPyONEvYYVcRe/CGMzDLTfDsxf3U\nCPTyGYVrHTp5JSYlMqmlzbi6oj1bBRXXjoI645MXGKUYnZI/TtI9p1meuFv9oXho\nFcaKeQWrAgMBAAECggEAEvFU79OkVy6V8tFQTlQQmJyhN17YSd7AM+bNGx39tHjn\njbHOA+uj2ORI3Z3KuVis7So8ObBld5MXW3p04I7pNb/g6BTEiaZN2d5XlQezmXRC\n0EitsM3Idm46ok2id/apAvUTK0yfLr5E26NzT9mSjVMZyhVyhSjmoJOfKODudmOY\negNkHIDpjm77f8ybf2UH+eoCm5BIlXyTIGXP7+g2CSMFFHrzhKJqlDgpmysRFz2F\nllB+E6vQeGHNjnni+58XkGPwr7Mi9XHxdVYxho+szfFgj//34+CNzmoap6f6wT/0\nOfS94berGA+acoNToPsgBJKjEtYlimB8Er94w91UYQKBgQDKbXry7bDAbA7AtvcZ\n8tzprss0BD3eGqnFgLSpwYR5r+h4PZCBKYj4lxiS6A28WtxlDMZWiy3vVG10zXs9\n2J/n6iudd+FFbbgksYtltx83BgH3xxUgzKXUrqB7AomRCIhRtylJhciLiVtlwgQa\nWAGgHAoywSvGjurvcPu2+GySRQKBgQC/LuR3hZwlqiHK2A8/2lwyAzBexhf/580f\nQVphuqr9IDumS6/H1W+ml1Fx5gfgLetJLRonyX9A993ZJ1jF4OJrIpdwy+LMZdZk\nkRs1zNWKcqFa1/QXrlOrOYR+oXHBW4F1YlREmf+SOTx7v+l0xst7NlrzEiH1DsJO\nAhbVe6mvLwKBgBSiBB4uzA1Q9k/+VkF2172Z62xp4kR5Q0S2UbPb3bzpiTB4VfpU\nWXm9LOwMaxn/yOcj3jOEDDKQ0HdPWnh7VBE3dSqfxX5mKJbU4fiEKdJZ8mlnCWhG\nc8Cx6/md0JfP3tU1bifoUwCmB4Lfu7tTrRa8xO1XczbR6nBte7qyp55hAoGAUk7m\n74onQpPvfnvsfMoOvT1gOr1AId1zEwy407Bg4x9YbuzQ3dDHA8rLtqSZKWu7i0KO\nqyh1z8umyFHHR1HdSNCYsGgm2WbSmXNbapsoKDXXv9uPbA6SWPonT7lD10IFBztx\nGiPOwu4/Wuuxn6PigMZS+6kH05AqGRmPKRPXZuMCgYEAuE+B1wcWrc3TKFIgG43c\nxjmhFJAomPFQ9nyxYimHOn1XV3KYQXu1VW2PR8VvlEZ9fMC7pMtwG6FKvCFQ8daB\nPhZuT161D9iH6IF6sYvzVNsEhq+3s+yJg4Hlm8vrPndpnF10bXE88dOTSZymOjuo\nimHElZqscL0zAYTcGcFVjZ8=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-t7kqh@chulesi-app.iam.gserviceaccount.com",
        "client_id": "112649751246925677330",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-t7kqh%40chulesi-app.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
