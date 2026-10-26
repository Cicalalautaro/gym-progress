import { useEffect, useState } from "react";
import { getDb } from "./db";

// Pantalla de prueba del esqueleto: verifica que la base responde.
export default function App() {
  const [status, setStatus] = useState("Conectando a la base...");

  useEffect(() => {
    getDb()
      .then((db) =>
        db.select<{ tablas: number }[]>(
          "SELECT COUNT(*) AS tablas FROM sqlite_master WHERE type = 'table'",
        ),
      )
      .then((rows) => setStatus(`Base lista: ${rows[0].tablas} tablas`))
      .catch((e) => setStatus(`Error: ${String(e)}`));
  }, []);

  return (
    <main style={{ fontFamily: "system-ui", padding: 24 }}>
      <h1>Gym Progress</h1>
      <p>{status}</p>
    </main>
  );
}
