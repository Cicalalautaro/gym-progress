import Database from "@tauri-apps/plugin-sql";

// Las migraciones se aplican en Rust al iniciar el plugin (src-tauri/src/lib.rs),
// así que cuando esto resuelve, el esquema ya está al día.
let dbPromise: Promise<Database> | null = null;

export function getDb(): Promise<Database> {
  if (!dbPromise) {
    dbPromise = Database.load("sqlite:gym.db").then(async (db) => {
      await db.execute("PRAGMA foreign_keys = ON");
      return db;
    });
  }
  return dbPromise;
}
