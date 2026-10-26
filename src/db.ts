import Database from "@tauri-apps/plugin-sql";

// Las migraciones se aplican en Rust al iniciar el plugin (src-tauri/src/lib.rs),
// así que cuando esta promesa resuelve, el esquema ya está al día.
let promesaBaseDatos: Promise<Database> | null = null;

export function obtenerBaseDatos(): Promise<Database> {
  if (!promesaBaseDatos) {
    promesaBaseDatos = Database.load("sqlite:gym.db").then(async (bd) => {
      await bd.execute("PRAGMA foreign_keys = ON");
      return bd;
    });
  }
  return promesaBaseDatos;
}
