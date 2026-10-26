use tauri_plugin_sql::{Builder, Migration, MigrationKind};

pub fn run() {
    // Cada cambio de esquema es una migración nueva; nunca editar una ya publicada.
    let migrations = vec![Migration {
        version: 1,
        description: "esquema inicial",
        sql: include_str!("../migrations/0001_init.sql"),
        kind: MigrationKind::Up,
    }];

    tauri::Builder::default()
        .plugin(
            Builder::default()
                .add_migrations("sqlite:gym.db", migrations)
                .build(),
        )
        .run(tauri::generate_context!())
        .expect("error al iniciar la aplicación");
}
