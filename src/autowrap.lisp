(in-package #:%sdl3)

(cffi:define-foreign-library sdl3
  (:unix (:or "libSDL3.so.0")))
(cffi:use-foreign-library sdl3)

(autowrap:c-include
  '(cl-sdl3 c-src "SDL.h")
  :spec-path '(cl-sdl3 autowrap-spec)
  :sysincludes '("./SDL/include")
  :exclude-sources ("/usr/include/" "/usr/lib64/clang/[^/]*/include/.*")
  :include-sources ("stdint.h" "bits/types.h" "sys/types.h" "bits/stdint" "machine/_types.h" "stddef.h")
  :symbol-regex (("^SDL_(.+)" () "\\1"))
  :symbol-exceptions (("SDL_Log" . "LOGGER")
                      ("SDL_log" . "LOGN"))
  :include-definitions ()
  :exclude-definitions ("^_[A-Z]"
                        "max_align_t"
                        "XEvent"
                        "SDL_main"
                        "SDL_vsscanf"
                        "SDL_vsnprintf"
                        "SDL_vswprintf"
                        "SDL_vasprintf"
                        "SDL_IOvprintf"
                        "SDL_LogMessageV"
                        "SDL_PROP_")
  :release-p cl:t)
