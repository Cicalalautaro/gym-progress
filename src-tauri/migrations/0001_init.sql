-- Catálogos: agregar un valor nuevo es un INSERT, sin cambiar el esquema.
CREATE TABLE equipamientos (
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);

INSERT INTO equipamientos (nombre) VALUES
    ('mancuerna'),
    ('barra'),
    ('peso corporal'),
    ('máquina');

CREATE TABLE grupos_musculares (
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);

INSERT INTO grupos_musculares (nombre) VALUES
    ('pecho'),
    ('espalda'),
    ('hombros'),
    ('bíceps'),
    ('tríceps'),
    ('piernas'),
    ('glúteos'),
    ('abdomen');

CREATE TABLE ejercicios (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre            TEXT NOT NULL,
    equipamiento_id   INTEGER NOT NULL REFERENCES equipamientos(id) ON DELETE RESTRICT,
    creado_en         TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Porcentajes por ejercicio. Que sumen 100 se valida en la aplicación.
CREATE TABLE ejercicio_grupos_musculares (
    ejercicio_id       INTEGER NOT NULL REFERENCES ejercicios(id) ON DELETE CASCADE,
    grupo_muscular_id  INTEGER NOT NULL REFERENCES grupos_musculares(id) ON DELETE RESTRICT,
    porcentaje         INTEGER NOT NULL CHECK (porcentaje BETWEEN 1 AND 100),
    PRIMARY KEY (ejercicio_id, grupo_muscular_id)
);

CREATE TABLE rutinas (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL,
    creado_en  TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Cada día de la rutina es una columna de la tabla.
CREATE TABLE rutina_dias (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    rutina_id   INTEGER NOT NULL REFERENCES rutinas(id) ON DELETE CASCADE,
    dia_semana  TEXT NOT NULL CHECK (dia_semana IN
                ('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo')),
    UNIQUE (rutina_id, dia_semana)
);

-- Cada celda de la tabla: un ejercicio dentro de un día.
CREATE TABLE rutina_ejercicios (
    id                     INTEGER PRIMARY KEY AUTOINCREMENT,
    rutina_dia_id          INTEGER NOT NULL REFERENCES rutina_dias(id) ON DELETE CASCADE,
    ejercicio_id           INTEGER NOT NULL REFERENCES ejercicios(id) ON DELETE RESTRICT,
    posicion               INTEGER NOT NULL,
    series_objetivo        INTEGER,
    repeticiones_objetivo  INTEGER,
    peso_objetivo_kg       REAL,
    UNIQUE (rutina_dia_id, posicion)
);

CREATE TABLE entrenamientos (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    rutina_id  INTEGER REFERENCES rutinas(id) ON DELETE SET NULL,
    fecha      TEXT NOT NULL
);

-- peso_kg es la carga total (una mancuerna de 5 kg que se usa en par = 10 kg).
CREATE TABLE series (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    entrenamiento_id  INTEGER NOT NULL REFERENCES entrenamientos(id) ON DELETE CASCADE,
    ejercicio_id      INTEGER NOT NULL REFERENCES ejercicios(id) ON DELETE RESTRICT,
    numero_serie      INTEGER NOT NULL,
    peso_kg           REAL CHECK (peso_kg IS NULL OR peso_kg >= 0),
    repeticiones      INTEGER NOT NULL CHECK (repeticiones >= 0),
    creado_en         TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_series_ejercicio ON series(ejercicio_id);
CREATE INDEX idx_entrenamientos_fecha ON entrenamientos(fecha);
