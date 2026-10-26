import { useEffect, useState } from "react";
import { obtenerBaseDatos } from "./db";

// Pantalla de prueba del esqueleto: verifica que la base responde.
export default function App() {
  const [estado, setEstado] = useState("Conectando a la base...");

  useEffect(() => {
    obtenerBaseDatos()
      .then((bd) =>
        bd.select<{ cantidad: number }[]>(
          "SELECT COUNT(*) AS cantidad FROM sqlite_master WHERE type = 'table'",
        ),
      )
      .then((filas) => setEstado(`Base lista: ${filas[0].cantidad} tablas`))
      .catch((e) => setEstado(`Error: ${String(e)}`));
  }, []);

  return (
    <main style={{ fontFamily: "system-ui", padding: 24 }}>
      <h1>Gym Progress</h1>
      <p>{estado}</p>
    </main>
  );
}
