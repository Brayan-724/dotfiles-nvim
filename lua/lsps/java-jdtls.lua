return {
  "jdtls",
  opts = {
    init_options = {
      bundles = {
        vim.fn.stdpath "config" .. "/vendor/org.javacs.kt.jdt.ls.extension-1.0.0-SNAPSHOT-sources.jar",
        vim.fn.stdpath "config" .. "/vendor/org.javacs.kt.jdt.ls.extension-1.0.0-SNAPSHOT.jar",
      },
      settings = {
        java = {
          home = "/usr/local/jdk-9.0.1",
        }
      }
    }
  }
}
