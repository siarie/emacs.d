;;; early-init.el -*- lexical-binding: t; -*-

(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default frame-title-format '("emacs@" system-name))

(setq default-frame-alist '((fullscreen . maximized)
			    (vertical-scroll-bars . nil)
			    (horizontal-scroll-bars . nil)
			    (background-color . "#000000")
			    (foreground-color . "#ffffff")
			    (ns-appearance . dark)
			    (ns-transparent-titlebar . t)))

;; Disable package.el
;; (setq package-enable-at-startup nil)
