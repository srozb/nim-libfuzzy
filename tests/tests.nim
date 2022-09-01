# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest


import libfuzzy/ssdeep

test "fuzzy_hash_buf":
  var buf: cstring = "Nim is awesome!"
  var outp = newString(1024)
  check fuzzy_hash_buf(cast[ptr uint8](buf), buf.len.uint32, outp.cstring) == 0
  outp.setLen(outp.find('\0'))
  check outp == "3:tE6Th:2s"

test "fuzzy_hash_filename":
  var outp = newString(FUZZY_MAX_RESULT)
  let fn = "src/libfuzzy/src/fuzzy.c"
  check fuzzy_hash_filename(fn.cstring, outp.cstring) == 0
  outp.setLen(outp.find('\0'))
  check outp == "768:EJsfd1myHFIreIPhSO33vJsaVUuYJ4tmrROOaqh:Vd48K33Bp44wrkqh"

test "fuzzy_hash_file":
  var outp = newString(FUZZY_MAX_RESULT)
  var fHandle = open("src/libfuzzy/src/fuzzy.c", fmRead)
  check fuzzy_hash_file(fHandle, outp.cstring) == 0
  outp.setLen(outp.find('\0'))
  check outp == "768:EJsfd1myHFIreIPhSO33vJsaVUuYJ4tmrROOaqh:Vd48K33Bp44wrkqh"

test "fuzzy_compare files":
  var sig1 = newString(FUZZY_MAX_RESULT)
  var sig2 = newString(FUZZY_MAX_RESULT)
  let sig1fn = "tests/files/f1.txt"
  let sig2fn = "tests/files/f2.txt"
  check fuzzy_hash_filename(sig1fn.cstring, sig1.cstring) == 0
  check fuzzy_hash_filename(sig2fn.cstring, sig2.cstring) == 0
  check fuzzy_compare(sig1.cstring, sig2.cstring) == 85



