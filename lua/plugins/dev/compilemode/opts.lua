return {
  error_regexp_table = {
    rust = {
      regex = "->\\? \\([^:]\\+\\):\\(\\d\\+\\):\\(\\d\\+\\)",
      filename = 1,
      row = 2,
      col = 3,
    },
  },
}
