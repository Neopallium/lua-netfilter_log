-- Copyright (c) 2012 by Christian Wiese <chris@opensde.org>
-- --
-- -- Permission is hereby granted, free of charge, to any person obtaining a copy
-- -- of this software and associated documentation files (the "Software"), to deal
-- -- in the Software without restriction, including without limitation the rights
-- -- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- -- copies of the Software, and to permit persons to whom the Software is
-- -- furnished to do so, subject to the following conditions:
-- --
-- -- The above copyright notice and this permission notice shall be included in
-- -- all copies or substantial portions of the Software.
-- --
-- -- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- -- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- -- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- -- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- -- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- -- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- -- THE SOFTWARE.

--
-- nflog handle
--
object "nflog" {
	-- map the real nflog_handle type
	c_source [[
	typedef struct nflog_handle nflog;
]],
	-- Use `ffi_cdef` records to pass extra C type info to FFI.
	ffi_cdef [[
	typedef struct nflog_handle nflog;
]],
	-- The first constructor can be called as: netfilter_log.nflog() or netfilter_log.nflog.new()
	-- The default name for a constructor is 'new'
  constructor {
    c_call "nflog *" "nflog_open" {}
  },
	-- "close" destructor allows freeing of the object before it gets GC'ed
  destructor "close" {
    c_method_call "int" "nflog_close" {}
  },

  method "bind_pf" {
    c_method_call "int" "nflog_bind_pf" { "uint16_t", "pf" }
  },

  method "unbind_pf" {
    c_method_call "int" "nflog_unbind_pf" { "uint16_t", "pf" }
  },
}

--
-- nflog group handle
--
object "nflog_group" {
	-- map the real nflog_g_handle type
	c_source [[
	typedef struct nflog_g_handle nflog_group;
]],
	-- Use `ffi_cdef` records to pass extra C type info to FFI.
	ffi_cdef [[
	typedef struct nflog_g_handle nflog_group;
]],
	-- The first constructor can be called as: netfilter_log.nflog_group() or netfilter_log.nflog_group.new()
	-- The default name for a constructor is 'new'
  constructor {
    c_call "nflog_group *" "nflog_bind_group" { "nflog *", "nflog_handle", "uint16_t", "num"}
  },
	-- "unbind" destructor allows freeing of the object before it gets GC'ed
  destructor "unbind" {
    c_method_call "int" "nflog_unbind_group" {}
  },

  method "set_mode" {
    c_method_call "int" "nflog_set_mode" { "uint8_t", "mode", "uint32_t", "range" }
  },

  method "set_timeout" {
    c_method_call "int" "nflog_set_timeout" { "uint32_t", "timeout" }
  },

  method "set_qtresh" {
    c_method_call "int" "nflog_set_qthresh" { "uint32_t", "qthresh" }
  },

  method "set_nlbufsiz" {
    c_method_call "int" "nflog_set_nlbufsiz" { "uint32_t", "nlbufsiz" }
  },

  method "set_flags" {
    c_method_call "int" "nflog_set_flags" { "uint16_t", "flags" }
  },
}