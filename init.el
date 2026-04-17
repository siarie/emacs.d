;; -*- lexical-binding: t; -*-

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

;; theme
(add-to-list 'custom-theme-load-path
	     (expand-file-name "themes/" user-emacs-directory))
(load-theme 'kombat t)

;;; Frame configuration
(add-to-list 'default-frame-alist '(font . "Iosevka 11"))
(add-to-list 'default-frame-alist '(height . 42))
(add-to-list 'default-frame-alist '(width . 130))

(setq-default mode-line-buffer-identification
	      '(:eval
		(let ((file (buffer-file-name)))
		  (if file
		      (let ((project (project-current)))
			(if project
			    (file-relative-name file (project-root project))
			  (abbreviate-file-name file)))
		    (buffer-name)))))

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
 show-trailing-whitespace t)

;; keymap
(defun rc/kill-word-or-region ()
  "Kill the region if the mark is active, otherwise kill the previous word."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'rc/kill-word-or-region)
(global-set-key "\C-d" 'backward-delete-char)
(global-set-key (kbd "C-,")
		(lambda ()
                  (interactive)
                  (duplicate-line)
                  (next-line)))

;; dired
(with-eval-after-load 'dired
  (put 'dired-find-alternate-file 'disabled nil)
  (setq dired-dwim-target t))


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
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '(zig-ts-mode . ("zls"))
               '((typescript-ts-mode) . ("typescript-language-server" "--stdio"
                                         :initializationOptions
                                         (:typescript (:format (:indentSize 2 :tabSize 2))))))
  (add-hook 'before-save-hook
            (lambda ()
              (when (bound-and-true-p eglot--managed-mode)
                (eglot-format-buffer)))))

;; Flymake
(setq flymake-diagnostic-format-alist
      '((t . (origin code message))))

(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "C-c f d") 'flymake-show-diagnostic)

;; Eldoc
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

;; languages
(import 'web-mode)
(import 'emmet-mode)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-hook 'web-mode-hook #'emmet-mode)

;; (import 'zig-mode)
(import 'zig-ts-mode)

;; auto mode list
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; js/ts
(add-hook 'typescript-ts-mode-hook
          (lambda ()
            (setq-local typescript-ts-mode-indent-offset 2)
            (setq-local tab-width 2)
            (setq-local indent-tabs-mode nil)
            (eglot-ensure)))

;; go mode
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
(add-hook 'go-ts-mode-hook
          (lambda ()
            (setq-local tab-width 4)
            (setq-local indent-tabs-mode t)
            (setq-local go-ts-mode-indent-offset 4)
            (eglot-ensure)))

;; Ocaml
(import 'dune)
(import 'neocaml)
;; (import 'reason-mode)
;; (import 'ocaml-eglot)

(defun rc/ocaml-mode-init ()
  (eglot-ensure))

(with-eval-after-load 'neocaml
  (add-hook 'neocaml-mode-hook #'rc/ocaml-mode-init)
  (add-hook 'neocaml-mode-hook #'eglot-format-buffer nil t))

;; php
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-ts-mode))

(defun my-php-mode-init ()
  (subword-mode 1)
  (setq-local ac-disable-faces '(font-lock-comment-face font-lock-string-face)))

(with-eval-after-load 'php-ts-mode
  (add-hook 'php-mode-hook #'my-php-mode-init))

;; misc - non-related to programming
(import 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

(load custom-file :no-error-if-file-is-missing)
;;; init.el ends here
