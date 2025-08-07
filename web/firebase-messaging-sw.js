importScripts(
  "https://www.gstatic.com/firebasejs/10.0.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.0.0/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyCzUGpsW5TrHGebv3E_pGttsWy_kFCl6Ho",
  authDomain: "chulesi-fooddelivery.firebaseapp.com",
  projectId: "chulesi-fooddelivery",
  storageBucket: "chulesi-fooddelivery.appspot.com",
  messagingSenderId: "802878070287",
  appId: "1:802878070287:web:5ba82838319a4b88b74d7a",
  measurementId: "G-KGT7XRYQEK",
});

const messaging = firebase.messaging();
