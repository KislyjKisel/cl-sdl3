(uiop:define-package #:%sdl3 (:use))
(uiop:define-package #:sdl3
  (:use cl)
  (:import-from #:%sdl3 #:+false+ #:+true+)
  (:export #:+false+ #:+true+))
