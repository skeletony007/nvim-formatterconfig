return {
    default_config = {
        filetypes = {
            "angular",
            "css",
            "flow",
            "graphql",
            "html",
            "javascript",
            "json",
            "jsx",
            "less",
            "markdown",
            "scss",
            "typescript",
            "vue",
            "yaml",
        },
        root_markers = {
            -- in order of precidence
            -- <https://prettier.io/docs/en/configuration.html>
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            "prettierrc.config.js",
            ".prettierrc.mjs",
            "prettier.config.mjs",
            ".prettierrc.cjs",
            "prettier.config.cjs",
            ".prettierrc.toml",
        },
    },
}
