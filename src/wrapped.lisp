(in-package #:sdl3)

;;; Properties - Window

(export 'alloc-prop-window-x11-display-pointer)
(declaim
  (inline alloc-prop-window-x11-display-pointer)
  (ftype (function () (values cffi:foreign-pointer &optional)) alloc-prop-window-x11-display-pointer))
(defun alloc-prop-window-x11-display-pointer ()
    (cffi:foreign-string-alloc "SDL.window.x11.display"))

(export 'alloc-prop-window-x11-window-number)
(declaim
  (inline alloc-prop-window-x11-window-number)
  (ftype (function () (values cffi:foreign-pointer &optional)) alloc-prop-window-x11-window-number))
(defun alloc-prop-window-x11-window-number ()
    (cffi:foreign-string-alloc "SDL.window.x11.window"))

