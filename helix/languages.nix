{alejandra}: ''
  [language-server.nil.config.nil]
  formatting = { command = ["${alejandra}/bin/alejandra"] }

  [language-server.rust-analyzer]
  config = { completion = { callable = { snippets = "add_parentheses" } } }
''
