const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.syncUserEcoScore = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("no access", "Unauthenticated user");
  }

  const userId = context.auth.uid;
  const newEcoScore = data.ecoScore;
  const usersCollection = admin.firestore().collection("users");
  const userDocRef = usersCollection.doc(userId);

  try {
    const doc = await userDocRef.get();
    if (!doc.exists) {
      await userDocRef.set({
        username: `user_${Math.floor(Math.random() * 9999)}`,
        ecoScore: newEcoScore,
      });
      return {ecoScore: newEcoScore};
    } else {
      const currentEcoScore = doc.data().ecoScore || 0;
      if (newEcoScore > currentEcoScore) {
        await userDocRef.update({ecoScore: newEcoScore});
        return {ecoScore: newEcoScore};
      } else {
        return {ecoScore: currentEcoScore};
      }
    }
  } catch (error) {
    console.error("Error syncing user ecoScore:", error);
    throw new functions.https.HttpsError("internal", "Failed to sync ecoScore");
  }
});
