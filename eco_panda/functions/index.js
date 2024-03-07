const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.syncUserScores = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("permission-denied", "Unauthenticated user");
  }

  const userId = context.auth.uid;
  const newEcoScore = data.ecoScore;
  const newCarbonScore = data.carbonScore;
  const usersCollection = admin.firestore().collection("users");
  const userDocRef = usersCollection.doc(userId);

  try {
    const doc = await userDocRef.get();
    if (!doc.exists) {
      const newUser = {
        username: `user_${Math.floor(Math.random() * 99999)}`,
        ecoScore: newEcoScore,
        carbonScore: newCarbonScore,
      };

      await userDocRef.set(newUser);
      return newUser;
    } else {
      const updates = {};
      const currentEcoScore = doc.data().ecoScore || 0;

      if (newEcoScore > currentEcoScore) {
        updates.ecoScore = newEcoScore;
      }

      if (newCarbonScore !== undefined) {
        const currentCarbonScore = doc.data().carbonScore || 0;
        if (newCarbonScore > currentCarbonScore) {
          updates.carbonScore = newCarbonScore;
        }
      }

      if (Object.keys(updates).length > 0) {
        await userDocRef.update(updates);
      }

      return { ...doc.data(), ...updates };
    }
  } catch (error) {
    console.error("Error syncing user scores:", error);
    throw new functions.https.HttpsError("internal", "Failed to sync scores.");
  }
});
