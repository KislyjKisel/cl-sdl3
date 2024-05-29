(in-package #:sdl3)

(export 'get-window-size)
(defun get-window-size (window)
  (let ((window-size (cffi:foreign-alloc :int :count 2)))
    (%sdl3:get-window-size window
                           (cffi:mem-aptr window-size :int 0)
                           (cffi:mem-aptr window-size :int 1))
    (let ((window-width (cffi:mem-aref window-size :int 0))
          (window-height (cffi:mem-aref window-size :int 1)))
      (cffi:foreign-free window-size)
      (values window-width window-height))))

(export 'get-window-size-in-pixels)
(defun get-window-size-in-pixels (window)
  (let ((window-size (cffi:foreign-alloc :int :count 2)))
    (%sdl3:get-window-size-in-pixels window
                                     (cffi:mem-aptr window-size :int 0)
                                     (cffi:mem-aptr window-size :int 1))
    (let ((window-width (cffi:mem-aref window-size :int 0))
          (window-height (cffi:mem-aref window-size :int 1)))
      (cffi:foreign-free window-size)
      (values window-width window-height))))


;;; Keys

(export 'keymod)
(deftype keymod ()
  '(unsigned-byte 16))

(export '(+kmod-none+
          +kmod-lshift+ +kmod-rshift+ +kmod-lctrl+ +kmod-rctrl+
          +kmod-lalt+ +kmod-ralt+ +kmod-lgui+ +kmod-rgui+
          +kmod-num+ +kmod-caps+ +kmod-mode+ +kmod-scroll+
          +kmod-ctrl+ +kmod-shift+ +kmod-alt+ +kmod-gui+))
(defconstant +kmod-none+ #x0000 "No modifier is applicable")
(defconstant +kmod-lshift+ #x0001)
(defconstant +kmod-rshift+ #x0002)
(defconstant +kmod-lctrl+ #x0040)
(defconstant +kmod-rctrl+ #x0080)
(defconstant +kmod-lalt+ #x0100)
(defconstant +kmod-ralt+ #x0200)
(defconstant +kmod-lgui+ #x0400 "Left GUI key (often Windows key)")
(defconstant +kmod-rgui+ #x0800 "Right GUI key (often Windows key)")
(defconstant +kmod-num+ #x1000 "Num Lock key (may be located on an extended keypad)")
(defconstant +kmod-caps+ #x2000 "Caps Lock key")
(defconstant +kmod-mode+ #x4000 "AltGr key")
(defconstant +kmod-scroll+ #x8000 "Scroll Lock key")
(defconstant +kmod-ctrl+ (logior +kmod-lctrl+ +kmod-rctrl+) "Any Ctrl key")
(defconstant +kmod-shift+ (logior +kmod-lshift+ +kmod-rshift+) "Any Shift key")
(defconstant +kmod-alt+ (logior +kmod-lalt+ +kmod-ralt+) "Any Alt key (excluding AltGr)")
(defconstant +kmod-gui+ (logior +kmod-lgui+ +kmod-rgui+) "Any GUI key")


;;; Properties

(defmacro define-property-name-allocs (symbol-name-pairs)
  `(progn
    ,@(mapcan (lambda (sn)
                (let ((symbol (first sn))
                      (name (second sn)))
                  (list
                   `(export ',symbol)
                   `(declaim
                      (inline ,symbol)
                      (ftype (function () (values cffi:foreign-pointer &optional)) ,symbol))
                   `(defun ,symbol ()
                      (cffi:foreign-string-alloc ,name))))) symbol-name-pairs)))

(define-property-name-allocs (;; Window
                              (alloc-prop-window-wayland-display-pointer "SDL.window.wayland.display")
                              (alloc-prop-window-wayland-surface-pointer "SDL.window.wayland.surface")
                              (alloc-prop-window-x11-display-pointer "SDL.window.x11.display")
                              (alloc-prop-window-x11-window-number "SDL.window.x11.window")
                              ;; Renderer - Create
                              (alloc-prop-renderer-create-name-string "name")
                              (alloc-prop-renderer-create-window-pointer "window")
                              (alloc-prop-renderer-create-surface-pointer "surface")
                              (alloc-prop-renderer-create-output-colorspace-number "output_colorspace")
                              (alloc-prop-renderer-create-present-vsync-boolean "present_vsync")
                              (alloc-prop-renderer-create-vulkan-instance-pointer "vulkan.instance")
                              (alloc-prop-renderer-create-vulkan-surface-number "vulkan.surface")
                              (alloc-prop-renderer-create-vulkan-physical-device-pointer "vulkan.physical_device")
                              (alloc-prop-renderer-create-vulkan-device-pointer "vulkan.device")
                              (alloc-prop-renderer-create-vulkan-graphics-queue-family-index-number "vulkan.graphics_queue_family_index")
                              (alloc-prop-renderer-create-vulkan-present-queue-family-index-number "vulkan.present_queue_family_index")
                              ;; Renderer
                              (alloc-prop-renderer-name-string "SDL.renderer.name")
                              (alloc-prop-renderer-window-pointer "SDL.renderer.window")
                              (alloc-prop-renderer-surface-pointer "SDL.renderer.surface")
                              (alloc-prop-renderer-output-colorspace-number "SDL.renderer.output_colorspace")
                              (alloc-prop-renderer-hdr-enabled-boolean "SDL.renderer.HDR_enabled")
                              (alloc-prop-renderer-sdr-white-point-float "SDL.renderer.SDR_white_point")
                              (alloc-prop-renderer-hdr-headroom-float "SDL.renderer.HDR_headroom")
                              (alloc-prop-renderer-d3d9-device-pointer "SDL.renderer.d3d9.device")
                              (alloc-prop-renderer-d3d11-device-pointer "SDL.renderer.d3d11.device")
                              (alloc-prop-renderer-d3d12-device-pointer "SDL.renderer.d3d12.device")
                              (alloc-prop-renderer-d3d12-command-queue-pointer "SDL.renderer.d3d12.command_queue")
                              (alloc-prop-renderer-vulkan-instance-pointer "SDL.renderer.vulkan.instance")
                              (alloc-prop-renderer-vulkan-surface-number "SDL.renderer.vulkan.surface")
                              (alloc-prop-renderer-vulkan-physical-device-pointer "SDL.renderer.vulkan.physical_device")
                              (alloc-prop-renderer-vulkan-device-pointer "SDL.renderer.vulkan.device")
                              (alloc-prop-renderer-vulkan-graphics-queue-family-index-number "SDL.renderer.vulkan.graphics_queue_family_index")
                              (alloc-prop-renderer-vulkan-present-queue-family-index-number "SDL.renderer.vulkan.present_queue_family_index")
                              (alloc-prop-renderer-vulkan-swapchain-image-count-number "SDL.renderer.vulkan.swapchain_image_count")
                              ;; Texture - Create
                              (alloc-prop-texture-create-colorspace-number "colorspace")
                              (alloc-prop-texture-create-format-number "format")
                              (alloc-prop-texture-create-access-number "access")
                              (alloc-prop-texture-create-width-number "width")
                              (alloc-prop-texture-create-height-number "height")
                              (alloc-prop-texture-create-sdr-white-point-float "SDR_white_point")
                              (alloc-prop-texture-create-hdr-headroom-float "HDR_headroom")
                              (alloc-prop-texture-create-d3d11-texture-pointer "d3d11.texture")
                              (alloc-prop-texture-create-d3d11-texture-u-pointer "d3d11.texture_u")
                              (alloc-prop-texture-create-d3d11-texture-v-pointer "d3d11.texture_v")
                              (alloc-prop-texture-create-d3d12-texture-pointer "d3d12.texture")
                              (alloc-prop-texture-create-d3d12-texture-u-pointer "d3d12.texture_u")
                              (alloc-prop-texture-create-d3d12-texture-v-pointer "d3d12.texture_v")
                              (alloc-prop-texture-create-metal-pixelbuffer-pointer "metal.pixelbuffer")
                              (alloc-prop-texture-create-opengl-texture-number "opengl.texture")
                              (alloc-prop-texture-create-opengl-texture-uv-number "opengl.texture_uv")
                              (alloc-prop-texture-create-opengl-texture-u-number "opengl.texture_u")
                              (alloc-prop-texture-create-opengl-texture-v-number "opengl.texture_v")
                              (alloc-prop-texture-create-opengles2-texture-number "opengles2.texture")
                              (alloc-prop-texture-create-opengles2-texture-uv-number "opengles2.texture_uv")
                              (alloc-prop-texture-create-opengles2-texture-u-number "opengles2.texture_u")
                              (alloc-prop-texture-create-opengles2-texture-v-number "opengles2.texture_v")
                              (alloc-prop-texture-create-vulkan-texture-number "vulkan.texture")
                              ;; Texture
                              (alloc-prop-texture-colorspace-number "SDL.texture.colorspace")
                              (alloc-prop-texture-sdr-white-point-float "SDL.texture.SDR_white_point")
                              (alloc-prop-texture-hdr-headroom-float "SDL.texture.HDR_headroom")
                              (alloc-prop-texture-d3d11-texture-pointer "SDL.texture.d3d11.texture")
                              (alloc-prop-texture-d3d11-texture-u-pointer "SDL.texture.d3d11.texture_u")
                              (alloc-prop-texture-d3d11-texture-v-pointer "SDL.texture.d3d11.texture_v")
                              (alloc-prop-texture-d3d12-texture-pointer "SDL.texture.d3d12.texture")
                              (alloc-prop-texture-d3d12-texture-u-pointer "SDL.texture.d3d12.texture_u")
                              (alloc-prop-texture-d3d12-texture-v-pointer "SDL.texture.d3d12.texture_v")
                              (alloc-prop-texture-opengl-texture-number "SDL.texture.opengl.texture")
                              (alloc-prop-texture-opengl-texture-uv-number "SDL.texture.opengl.texture_uv")
                              (alloc-prop-texture-opengl-texture-u-number "SDL.texture.opengl.texture_u")
                              (alloc-prop-texture-opengl-texture-v-number "SDL.texture.opengl.texture_v")
                              (alloc-prop-texture-opengl-texture-target-number "SDL.texture.opengl.target")
                              (alloc-prop-texture-opengl-tex-w-float "SDL.texture.opengl.tex_w")
                              (alloc-prop-texture-opengl-tex-h-float "SDL.texture.opengl.tex_h")
                              (alloc-prop-texture-opengles2-texture-number "SDL.texture.opengles2.texture")
                              (alloc-prop-texture-opengles2-texture-uv-number "SDL.texture.opengles2.texture_uv")
                              (alloc-prop-texture-opengles2-texture-u-number "SDL.texture.opengles2.texture_u")
                              (alloc-prop-texture-opengles2-texture-v-number "SDL.texture.opengles2.texture_v")
                              (alloc-prop-texture-opengles2-texture-target-number "SDL.texture.opengles2.target")
                              (alloc-prop-texture-vulkan-texture-number "SDL.texture.vulkan.texture")))
