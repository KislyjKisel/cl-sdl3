(asdf:defsystem #:cl-sdl3
    :depends-on (#:trivial-features #:cl-autowrap/libffi)
    :serial t
    :components ((:module c-src
                  :pathname "SDL/include/SDL3"
                  :components ((:static-file "SDL.h")))
                 (:module autowrap-spec
                  :pathname "spec"
                  :components ((:static-file "SDL.x86_64-pc-linux-gnu.spec")))
                 (:module src
                  :pathname "src"
                  :components ((:file "package")
                               (:file "autowrap")
                               (:file "wrapped")))))

