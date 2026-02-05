;;; init.el --- emacs init
;;; Commentary:
;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(defun import (package)
  "Ensure PACKAGE is installed and import it."
  (unless (package-installed-p package)
    (message "Installing package: %s" package)
    (package-install package))
  (require package))

;; (add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;;; Frame configuration
(add-to-list 'default-frame-alist '(font . "Agave 11"))
(add-to-list 'default-frame-alist '(height . 42))
(add-to-list 'default-frame-alist '(width . 130))

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq
 initial-scratch-message nil
 inhibit-splash-screen t
 use-file-dialog nil
 create-lockfiles nil
 make-backup-files nil
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq-default
 fill-column 80
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; keymap
(defun rc/kill-word-or-region ()
  "Kill the region if the mark is active, otherwise kill the previous word."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'rc/kill-word-or-region)
(global-set-key "\C-d" 'backward-delete-char)
(global-set-key (kbd "C-,") (lambda ()
                              (interactive)
                              (duplicate-line)
                              (next-line)))

;; dired
(defun rc/dired-init ()
  "Dired mode init"
  (setq dired-dwim-target t)
  (setq dired-kill-when-opening-new-dired-buffer t))

(add-hook 'dired-mode-hook 'rc/dired-init)

;; theme
(load-theme 'wombat)
(custom-set-faces
 '(tab-line ((t (:inherit mode-line))))
 '(tab-line-tab ((t (:inherit default))))
 '(tab-bar ((t (:inherit mode-line))))
 '(tab-bar-tab ((t (:inherit default))))
 '(font-lock-keyword-face ((t (:foreground "#f6f3e8" :bold t))))
 '(highlight ((t (:background "#353535" :underline nil))))
 '(hl-line ((t (:background "#353535" :underline nil))))
 '(vertical-border ((t (:inherit highlight)))))

;; built-in global mode
(tab-bar-mode 1)
(setq tab-bar-auto-width nil
      tab-bar-close-button-show nil
      tab-bar-new-button-show nil
      tab-bar-new-tab-choice "*scratch*")



(global-hl-line-mode 1)
(delete-selection-mode 1)

(setq display-line-numbers 'relative)
(global-display-line-numbers-mode 1)

;; (setq-default display-fill-column-indicator-character ?┃)
(global-display-fill-column-indicator-mode 1)

(column-number-mode 1)
(fido-mode 1)


(editorconfig-mode 1)

;; treesitter
(customize-set-variable 'treesit-font-lock-level 4)

;; setup eglot -- LSP client
(import 'eglot)
;; (add-hook 'eglot-managed-mode-hook
;;           (lambda ()
;;             (define-key eglot-mode-map (kbd "C-c e f") 'eglot-format-buffer)
;;             (define-key eglot-mode-map (kbd "C-c e r") 'eglot-rename)))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Flymake
(setq flymake-diagnostic-format-alist
      '((t . (origin code message))))
;; (defvar my-flymake-mode-map
;;   (let ((map (make-sparse-keymap)))
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "C-c f d") 'flymake-show-diagnostic)


;; tabspaces
;; (import 'tabspaces)
;; (tabspaces-mode 1)

;; swiper
(import 'swiper)
(keymap-global-set "C-s" #'swiper)

;; (straight-use-package 'flycheck)
(import 'eldoc-box)
(add-hook 'eldoc-mode-hook 'eldoc-box-hover-at-point-mode)
;; (eldoc-box-hover-at-point-mode 1)

(import 'which-key)
(setq which-key-idle-delay 0.5)
(which-key-mode)

;; magit
(import 'magit)
(with-eval-after-load 'magit
  (setq transient-default-level 5))

;; diff-hl
(import 'diff-hl)
(global-diff-hl-mode)

;; company-mode
(import 'company)
(import 'company-quickhelp) ;; disable this cause didn't follow theme
(global-company-mode 1)
(add-hook 'company-mode-hook
          (lambda ()
            (company-quickhelp-mode 1)))

(import 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (import 'markdown-mode)

;; languages
(import 'web-mode)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; (import
;;  '(emmet-mode :type git :host github :repo "smihica/emmet-mode"))

;; (add-hook 'web-mode-hook #'emmet-mode)

(import 'go-mode)
(import 'zig-mode)
;; (import 'zig-ts-mode)
;; (require 'zig-ts-mode)

;; auto mode list
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zig.zon\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; js/ts
(add-hook 'typescript-ts-mode-hook #'eglot-ensure)

;; go specific
(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'gofmt)
            (add-hook 'before-save-hook 'gofmt-before-save)))

;; Ocaml
(import 'dune)
(import 'reason-mode)
(import 'tuareg)
(import 'ocaml-eglot)

(add-hook 'tuareg-mode-hook #'ocaml-eglot)
(add-hook 'ocaml-eglot-hook #'eglot-ensure)
(add-hook 'ocaml-eglot-hook (lambda ()
                              (add-hook 'before-save-hook #'eglot-format nil t)))

;; Lua
;; (import 'lua-mode)

;; php
(import 'php-mode)

;; (import
;;  '(php-ts-mode :type git :host github :repo "emacs-php/php-ts-mode"))
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . php-ts-mode))

(defun my-php-mode-init ()
  (subword-mode 1)
  (setq-local show-trailing-whitespace t)
  (setq-local ac-disable-faces '(font-lock-comment-face font-lock-string-face))
  (add-hook 'hack-local-variables-hook 'php-ide-turn-on nil t))

(with-eval-after-load 'php-mode
  (add-hook 'php-mode-hook #'my-php-mode-init)
  (custom-set-variables
   '(php-mode-coding-style 'psr2)
   '(php-mode-template-compatibility nil)
   '(php-imenu-generic-expression 'php-imenu-generic-expression-simple))

  ;; If you find phpcs to be bothersome, you can disable it.
  ;; (when (require 'flycheck nil)
  ;;   (add-to-list 'flycheck-disabled-checkers 'php-phpmd)
  ;;   (add-to-list 'flycheck-disabled-checkers 'php-phpcs))
  )

;; misc - non-related to programming
(import 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

(load custom-file :no-error-if-file-is-missing)
;;; init.el ends here

