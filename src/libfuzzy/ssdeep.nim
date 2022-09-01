{.compile: "src/fuzzy.c".}

const
  SPAMSUM_LENGTH* = 64
  FUZZY_MAX_RESULT* = (2 * SPAMSUM_LENGTH + 20)

proc fuzzy_hash_buf*(buf: ptr uint8, buf_len: uint32, res: cstring): cint {.importc, cdecl.}
proc fuzzy_hash_file*(hFile: File, res: cstring): cint {.importc, cdecl.}
proc fuzzy_hash_filename*(filename: cstring, res: cstring): cint {.importc, cdecl.}
proc fuzzy_hash_stream*(hFile: File, res: cstring): cint {.importc, cdecl.}
proc fuzzy_compare*(sig1: cstring, sig2: cstring): cint {.importc, cdecl.}
