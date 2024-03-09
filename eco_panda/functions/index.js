const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.syncUserState = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("no access", "Unauthenticated user");
  }

  const userId = context.auth.uid;
  const {ecoScore, username, routes} = data;

  const userDocRef = admin.firestore().collection("users").doc(userId);

  try {
    const doc = await userDocRef.get();
    if (!doc.exists) {
      await userDocRef.set({
        username: username,
        ecoScore: ecoScore,
        routes: routes,
      });
      return {ecoScore: ecoScore, username: username, routes: routes};
    } else {
      return {
        ecoScore: doc.data().ecoScore,
        username: doc.data().username,
        routes: doc.data().routes};
    }
  } catch (error) {
    console.error("Error syncing user ecoScore:", error);
    throw new functions.https.HttpsError("internal", "Failed to sync ecoScore");
  }
});

exports.updateUserEcoScore = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("no access", "Unauthenticated user");
  }

  const userId = context.auth.uid;
  const ecoScoreUpdate = data.ecoScoreUpdate;
  const userRef = admin.firestore().collection("users").doc(userId);
  const userDoc = await userRef.get();

  if (!userDoc.exists) {
    console.error("User document not found");
    throw new functions.https.HttpsError("not-found", "User doc not found.");
  }

  await userRef.update({
    ecoScore: admin.firestore.FieldValue.increment(ecoScoreUpdate),
  });

  return {success: true, message: "Eco score updated successfully"};
});

exports.updateUsername = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Invalid cred");
  }

  const uid = context.auth.uid;
  const newUsername = data.username;

  try {
    await admin.firestore().collection("users").doc(uid).update({
      username: newUsername,
    });
    return {success: true, message: "Username updated successfully."};
  } catch (error) {
    console.error("Error updating username:", error);
    throw new functions.https.HttpsError("internal", "Fail to update username");
  }
});

exports.incrementUserRoute = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("no access", "Unauthenticated user");
  }

  const userId = context.auth.uid;
  const userRef = admin.firestore().collection("users").doc(userId);
  const userDoc = await userRef.get();

  if (!userDoc.exists) {
    console.error("User document not found");
    throw new functions.https.HttpsError("not-found", "User doc not found.");
  }

  await userRef.update({
    routes: admin.firestore.FieldValue.increment(1),
  });

  return {success: true, message: "Routes number updated successfully"};
});

exports.getUserRank = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("no access", "Unauthenticated user");
  }

  const uid = context.auth.uid;

  try {
    const usersRef = admin.firestore().collection("users");
    const snapshot = await usersRef.orderBy("ecoScore", "desc").get();

    let rank = 1;

    for (const doc of snapshot.docs) {
      if (doc.id === uid) {
        return {rank: rank};
      }
      rank++;
    }
    return {rank: -1};
  } catch (error) {
    console.error("Error getting user rank:", error);
    throw new functions.https.HttpsError("internal", "Failed to get user rank");
  }
});
