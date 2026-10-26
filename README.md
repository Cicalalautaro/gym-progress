# Gym Progress

App de escritorio (Tauri 2 + React + TypeScript + SQLite) para registrar rutinas de gimnasio y el histórico de pesos y repeticiones por ejercicio.

## Requisitos (Windows)

- Node.js 20 o superior
- Rust (instalar con rustup)
- Microsoft C++ Build Tools (componente "Desarrollo para escritorio con C++")
- WebView2 (viene instalado en Windows 10/11)

## Puesta en marcha

```bash
npm install
npx tauri icon ruta/a/un-logo-1024x1024.png   # una sola vez: genera src-tauri/icons
npm run tauri dev                              # desarrollo
npm run tauri build                            # instalador
```

## Datos

La base es `gym.db`, un archivo SQLite en la carpeta de datos de la app. Las migraciones están en `src-tauri/migrations/` y se aplican al iniciar.

Para respaldar, copiar `gym.db` con la app cerrada.
