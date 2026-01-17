; Only for comments that don't start with - or @ or |
; -- Example: `NOTE: Hello world`

; https://github.com/OXY2DEV/nvim/blob/main/queries/lua/injections.scm
(comment
  content: (_) @injection.content
  (#match? @injection.content "^[^%-@\|]")
  (#set! injection.language "comment"))
