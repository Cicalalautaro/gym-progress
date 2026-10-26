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


## Info extra
Tauri 2 (la app de escritorio)
Es el contenedor que convierte una app web en un programa instalable para Windows, Mac o Linux. La interfaz se muestra en una ventana con WebView2, el mismo motor que usa Edge, así que el instalador es chico (unos pocos MB, a diferencia de Electron que trae Chromium completo). La parte del backend está escrita en Rust. Para este proyecto solo se escribira la configuración y la inicialización de la base. El día a día es TypeScript. Es la tecnología más nueva del stack y la que más curva de aprendizaje tiene.

Rust (solo en el backend)
En el esqueleto, lib.rs registra las migraciones y tauri.conf.json define la ventana. Si más adelante se quiere lógica propia del lado nativo (por ejemplo, exportar a archivo), también se hace ahí.

React + TypeScript (la interfaz)
React arma la pantalla con componentes: cada parte (una rutina, una serie, un gráfico) es una función que recibe datos y devuelve lo que se ve. TypeScript es JavaScript con tipos, que detecta errores antes de ejecutar, como pasar un número donde se espera texto. Es una combinación muy usada, con mucha documentación.

Vite (el empaquetador y servidor de desarrollo)
Levanta la app en segundos durante el desarrollo y, al compilar, genera los archivos optimizados que Tauri empaqueta. Casi no hay que configurarlo; el vite.config.ts del esqueleto es prácticamente el mínimo.

SQLite + tauri-plugin-sql (la base de datos)
SQLite es una base relacional completa guardada en un único archivo, gym.db. No hay servidor que instalar ni que mantener. El plugin es el puente que deja al frontend ejecutar consultas SQL, y aplica las migraciones al arrancar. Para el histórico de un ejercicio vas a hacer consultas como “todas las series de este ejercicio, unidas con su fecha de entrenamiento, ordenadas por fecha”.

Zod (validación de datos)
Define el “formato esperado” de un dato, por ejemplo que el peso sea un número positivo, y lo verifica en tiempo de ejecución. TypeScript solo valida al compilar, así que Zod cubre lo que entra desde el formulario o desde la base. Todavía no lo usamos en el código del esqueleto.

Recharts (gráficos)
Librería de gráficos para React. Va a dibujar la evolución de peso máximo o volumen por ejercicio. Tampoco está en uso todavía; está instalada para cuando lleguemos al histórico.

Vitest (tests)
Corre tests unitarios para la lógica, por ejemplo cómo se calcula el volumen de una sesión. Es casi igual a Jest y se integra con Vite sin configuración extra. Por ahora solo está instalado y el script npm test existe, sin tests escritos.
