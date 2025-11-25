#!/usr/bin/env node

const { readFile } = require('fs/promises');
const path = require('path');
const admin = require('firebase-admin');

const SERVICE_ACCOUNT_PATH = path.join(__dirname, 'serviceAccount.json');
const QUESTIONS_PATH = path.join(__dirname, '../data/questions.json');
const COLLECTION_NAME = 'provisional_questions';
const DEFAULT_LOCALE = 'en';
const BATCH_LIMIT = 400; // Firestore allows up to 500 writes per batch.

async function chunkAndCommit(db, docs) {
  for (let start = 0; start < docs.length; start += BATCH_LIMIT) {
    const batch = db.batch();
    const slice = docs.slice(start, start + BATCH_LIMIT);

    slice.forEach(({ id, data }) => {
      const docRef = db.collection(COLLECTION_NAME).doc(id);
      batch.set(docRef, data, { merge: true });
    });

    await batch.commit();
    console.log(`Committed ${Math.min(slice.length, BATCH_LIMIT)} docs starting at index ${start}`);
  }
}

async function main() {
  console.log('Reading service account...');
  const serviceAccount = JSON.parse(await readFile(SERVICE_ACCOUNT_PATH, 'utf8'));

  console.log('Initializing Firebase Admin SDK...');
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  const db = admin.firestore();

  console.log('Loading questions JSON...');
  const rawQuestions = JSON.parse(await readFile(QUESTIONS_PATH, 'utf8'));

  if (!Array.isArray(rawQuestions) || rawQuestions.length === 0) {
    throw new Error('questions.json must be a non-empty array.');
  }

  const docs = rawQuestions.map((question, index) => {
    const docId = (question.id ?? `${index + 1}`).toString();
    const orderIndex = Number(question.order_index ?? question.id ?? index + 1);

    if (!question.question || !question.options || !question.correct_answer) {
      throw new Error(`Question at index ${index} is missing required fields.`);
    }

    return {
      id: docId,
      data: {
        question: question.question,
        options: question.options,
        correct_answer: question.correct_answer,
        locale: question.locale ?? DEFAULT_LOCALE,
        order_index: Number.isFinite(orderIndex) ? orderIndex : index + 1,
      },
    };
  });

  console.log(`Preparing to write ${docs.length} questions to Firestore...`);
  await chunkAndCommit(db, docs);
  console.log('All questions imported successfully.');
}

main().catch((error) => {
  console.error('Failed to import provisional questions:', error);
  process.exitCode = 1;
});
