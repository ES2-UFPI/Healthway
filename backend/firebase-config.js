const admin = require("firebase-admin");
const serviceAccount = require("./healthway-a0e87.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
module.exports = db;
