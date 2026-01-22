const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

// 🔔 NEW CHAT MESSAGE NOTIFICATION
exports.newChatNotification = onDocumentCreated(
  "chats/{chatId}/messages/{msgId}",
  async (event) => {
    const msg = event.data.data();
    const chatId = event.params.chatId;

    const chatDoc = await admin.firestore()
      .collection("chats")
      .doc(chatId)
      .get();

    if (!chatDoc.exists) return;

    const users = chatDoc.data().users;

    for (const uid of users) {
      if (uid === msg.senderId) continue;

      const userDoc = await admin.firestore()
        .collection("user")
        .doc(uid)
        .get();

      if (!userDoc.exists) continue;

      const token = userDoc.data().fcmToken;
      if (!token) continue;

      await admin.messaging().send({
        token,
        notification: {
          title: "💬 New Message",
          body: msg.text,
        },
      });
    }
  }
);
exports.newPostNotification = onDocumentCreated(
  "posts/{postId}",
  async (event) => {
    const post = event.data.data();

    const users = await admin.firestore().collection("user").get();
    const tokens = [];

    users.forEach(doc => {
      const token = doc.data().fcmToken;
      if (token) tokens.push(token);
    });

    if (tokens.length === 0) return;

    await admin.messaging().sendEachForMulticast({
      tokens,
      notification: {
        title: "📢 New Post",
        body: post.text || "New post added",
      },
    });
  }
);
