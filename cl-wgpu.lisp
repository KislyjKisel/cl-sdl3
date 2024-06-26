(defpackage #:sdl3.wgpu
  (:use cl)
  (:export get-wgpu-surface))

(in-package #:sdl3.wgpu)

(defun get-wgpu-surface (window wgpu-instance &optional (wgpu-surface-label (cffi:null-pointer)))
  #+linux
  (if (string= (%sdl3:get-current-video-driver)
               "x11")
      (let ((surf-desc (autowrap:calloc '%wgpu:surface-descriptor))
            (surf-desc-x11 (autowrap:calloc '%wgpu:surface-descriptor-from-xlib-window))
            (prop-win-x11-display (sdl3:alloc-prop-window-x11-display-pointer))
            (prop-win-x11-window (sdl3:alloc-prop-window-x11-window-number)))
        (setf (%wgpu:surface-descriptor.label surf-desc) wgpu-surface-label)
        (setf (%wgpu:surface-descriptor.next-in-chain surf-desc) (autowrap:ptr surf-desc-x11))
        (setf (%wgpu:surface-descriptor-from-xlib-window.chain.s-type surf-desc-x11)
          %wgpu:+s-type-surface-descriptor-from-xlib-window+)
        (setf (%wgpu:surface-descriptor-from-xlib-window.display surf-desc-x11)
          (%sdl3:get-property (%sdl3:get-window-properties window) prop-win-x11-display (cffi:null-pointer)))
        (setf (%wgpu:surface-descriptor-from-xlib-window.window surf-desc-x11)
          (%sdl3:get-number-property (%sdl3:get-window-properties window) prop-win-x11-window 0))
        (prog1
            (%wgpu:instance-create-surface wgpu-instance surf-desc)
          (cffi:foreign-string-free prop-win-x11-window)
          (cffi:foreign-string-free prop-win-x11-display)
          (autowrap:free surf-desc-x11)
          (autowrap:free surf-desc)))
      (let ((surf-desc (autowrap:calloc '%wgpu:surface-descriptor))
            (surf-desc-wayland (autowrap:calloc '%wgpu:surface-descriptor-from-wayland-surface))
            (prop-win-wayland-display (sdl3:alloc-prop-window-wayland-display-pointer))
            (prop-win-wayland-surface (sdl3:alloc-prop-window-wayland-surface-pointer)))
        (setf (%wgpu:surface-descriptor.label surf-desc) wgpu-surface-label)
        (setf (%wgpu:surface-descriptor.next-in-chain surf-desc) (autowrap:ptr surf-desc-wayland))
        (setf (%wgpu:surface-descriptor-from-wayland-surface.chain.s-type surf-desc-wayland)
          %wgpu:+s-type-surface-descriptor-from-wayland-surface+)
        (setf (%wgpu:surface-descriptor-from-wayland-surface.display surf-desc-wayland)
          (%sdl3:get-property (%sdl3:get-window-properties window) prop-win-wayland-display (cffi:null-pointer)))
        (setf (%wgpu:surface-descriptor-from-wayland-surface.surface surf-desc-wayland)
          (%sdl3:get-property (%sdl3:get-window-properties window) prop-win-wayland-surface (cffi:null-pointer)))
        (prog1
            (%wgpu:instance-create-surface wgpu-instance surf-desc)
          (cffi:foreign-string-free prop-win-wayland-display)
          (cffi:foreign-string-free prop-win-wayland-surface)
          (autowrap:free surf-desc)
          (autowrap:free surf-desc-wayland))))
  #-linux
  (error "Unsupported platform"))
