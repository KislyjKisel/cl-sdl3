(in-package #:sdl3)

(defun get-window-size (window)
  (let ((window-size (cffi:foreign-alloc :int :count 2)))
    (%sdl3:get-window-size window
                           (cffi:mem-aptr window-size :int 0)
                           (cffi:mem-aptr window-size :int 1))
    (let ((window-width (cffi:mem-aref window-size :int 0))
          (window-height (cffi:mem-aref window-size :int 1)))
      (cffi:foreign-free window-size)
      (values window-width window-height))))

(defun get-window-size-in-pixels (window)
  (let ((window-size (cffi:foreign-alloc :int :count 2)))
    (%sdl3:get-window-size-in-pixels window
                           (cffi:mem-aptr window-size :int 0)
                           (cffi:mem-aptr window-size :int 1))
    (let ((window-width (cffi:mem-aref window-size :int 0))
          (window-height (cffi:mem-aref window-size :int 1)))
      (cffi:foreign-free window-size)
      (values window-width window-height))))

;;; Properties - Window

(export 'alloc-prop-window-wayland-display-pointer)
(declaim
  (inline alloc-prop-window-wayland-display-pointer)
  (ftype (function () (values cffi:foreign-pointer &optional)) alloc-prop-window-wayland-display-pointer))
(defun alloc-prop-window-wayland-display-pointer ()
  (cffi:foreign-string-alloc "SDL.window.wayland.display"))

(export 'alloc-prop-window-wayland-surface-pointer)
(declaim
  (inline alloc-prop-window-wayland-surface-pointer)
  (ftype (function () (values cffi:foreign-pointer &optional)) alloc-prop-window-wayland-surface-pointer))
(defun alloc-prop-window-wayland-surface-pointer ()
  (cffi:foreign-string-alloc "SDL.window.wayland.surface"))

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
