;;; early-init.el

(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq default-frame-alist '((fullscreen . maximized)
			    (vertical-scroll-bars . nil)
                            (horizontal-scroll-bars . nil)
			    (background-color . "#000000")
                            (foreground-color . "#ffffff")
                            (ns-appearance . dark)
                            (ns-transparent-titlebar . t)))

;; (push '(menu-bar-lines . 0) default-frame-alist)
;; (push '(tool-bar-lines . 0) default-frame-alist)
;; (push '(vertical-scroll-bars) default-frame-alist)

;; Disable package.el
;; (setq package-enable-at-startup nil)
