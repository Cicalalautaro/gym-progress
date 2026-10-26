import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// Puerto fijo: Tauri espera el frontend en 1420 durante el desarrollo.
export default defineConfig({
  plugins: [react()],
  clearScreen: false,
  server: { port: 1420, strictPort: true },
  envPrefix: ["VITE_", "TAURI_"],
  build: { target: "es2021", minify: "esbuild", sourcemap: false },
});
