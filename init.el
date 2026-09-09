;; -*- lexical-binding: t; -*-

(when (< emacs-major-version 31)
  (error "Error: Emacs version 31 or higher is required"))

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

;; host spesific configuration
(defconst host (system-name))
(load
 (file-name-concat user-emacs-directory "hosts" host)
 'noerror 'nomessage)

;;; Frame configuration
(add-to-list 'default-frame-alist         '(font . "Iosevka 11"))

(setq-default mode-line-buffer-identification
	      '(:eval
		(let ((file (buffer-file-name)))
		  (if file
		      (let ((project (project-current)))
			(if project
			    (file-relative-name file (project-root project))
			  (abbreviate-file-name file)))
		    (buffer-name)))))

(setq custom-scratch-message ";;
;; Quick cheatseat
;; Key                         Binding
;;
;; C-c c                       org-capture
;; C-c a                       org-agenda-list
")

(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq
 ring-bell-function 'ignore
 initial-scratch-message (concat initial-scratch-message custom-scratch-message)
 inhibit-splash-screen t
 use-file-dialog nil
 create-lockfiles nil
 make-backup-files nil
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq-default show-trailing-whitespace t)

(defun rc/kill-word-or-region ()
  "Kill the region if the mark is active, otherwise kill the previous word."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun rc/duplicate-line ()
  (interactive)
  (duplicate-line)
  (next-line))

(keymap-global-set "C-d" #'delete-backward-char)
(keymap-global-set "C-w" #'rc/kill-word-or-region)
(keymap-global-set "C-," #'rc/duplicate-line)

;; dired
(with-eval-after-load 'dired
  (put 'dired-find-alternate-file 'disabled nil)
  (setq dired-dwim-target t))

;; org
(setq org-agenda-files `(,org-root-directory))
(setq org-capture-templates
      `(("j" "Journal" entry
	 (file+datetree ,(file-name-concat org-root-directory "inbox.org"))
	 "* %?\nEntered on %U\n  %i\n  %a")
	("t" "Todo" entry
	 (file+headline ,(file-name-concat org-root-directory "inbox.org") "Tasks")
	 "* TODO %?\n %i\n %a")
	("b" "Bookmark" entry
	 (file+headline
	  ,(file-name-concat org-root-directory "inbox.org") "Bookmarks")
	 "* %?\n%^L\n%i\n%a")))

(keymap-global-set "C-c c" 'org-capture)
(keymap-global-set "C-c a" 'org-agenda-list)

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

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)
(add-hook 'org-mode-hook #'turn-on-auto-fill)
(add-hook 'git-commit-mode-hook
	  (lambda ()
	    (setq-local fill-column 72)
	    (turn-on-auto-fill)))

(column-number-mode 1)
(editorconfig-mode 1)

;; treesitter
(setq treesit-auto-install-grammar t
      treesit-enabled-modes t)
(customize-set-variable 'treesit-font-lock-level 2)

;; setup eglot -- LSP client
(defun rc/eglot-setup ()
  (keymap-local-set "C-h ." 'eldoc-box-help-at-point)
  (add-hook 'before-save-hook
	    (lambda ()
	      (when (bound-and-true-p eglot--managed-mode)
		(eglot-format-buffer)))))

(with-eval-after-load 'eglot
  (dolist (item '((neocaml-base-mode . ("ocamllsp" "--fallback-read-dot-merlin"))
		  (zig-ts-mode . ("zls"))))
    (add-to-list 'eglot-server-programs item))
  (add-hook 'eglot-managed-mode-hook #'rc/eglot-setup))

;; Flymake
(defun rc/flymake-setup ()
  (keymap-local-set (kbd "M-n") 'flymake-goto-next-error)
  (keymap-local-set (kbd "M-p") 'flymake-goto-prev-error)
  (keymap-local-set (kbd "C-c f d") 'flymake-show-diagnostic))

(with-eval-after-load 'flymake-mode
  (add-hook 'flymake-mode-hook #'rc/flymake-setup))

(import 'which-key)
(setq which-key-idle-delay 0.5)
(which-key-mode)

;; magit
(import 'magit)
(with-eval-after-load 'magit
  (setq magit-diff-refine-hunk t)
  (setq transient-default-level 5))

;; diff-hl
(import 'diff-hl)
(global-diff-hl-mode)

;; rainbow-mode
(import 'rainbow-mode)

;; auto-detect indentation
(import 'dtrt-indent)
(with-eval-after-load 'dtrt-indent
  (add-hook 'prog-mode-hook
	    (lambda ()
	      (dtrt-indent-mode 1))))

;; corfu
(import 'corfu)

(defun corfu-enable-always-in-minibuffer ()
  "Enable Corfu in the minibuffer if Vertico/Mct are not active."
  (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
	      (bound-and-true-p vertico--input))
    (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
    (corfu-mode 1)))

(with-eval-after-load 'corfu
  (setq tab-always-indent 'complete)
  (setq completion-cycle-threshold nil)
  (setq global-corfu-minibuffer t)
  (setq corfu-auto nil
	corfu-auto-delay 0.25
	corfu-auto-trigger "." ;; Custom trigger characters
	corfu-min-width 72
	corfu-max-width 72
	corfu-count 14
	corfu-quit-no-match 'separator) ;; or t
  (global-corfu-mode 1)
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))


(import 'multiple-cursors)
(keymap-global-set "C-S-c C-S-c" 'mc/edit-lines)
(keymap-global-set "C->" 'mc/mark-next-like-this)
(keymap-global-set "C-<" 'mc/mark-previous-like-this)
(keymap-global-set "C-c C-<" 'mc/mark-all-like-this)

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

;; elixir
(import 'elixir-mode)

;; misc - non-related to programming
(import 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

(import 'minions)
(minions-mode 1)

(load custom-file :no-error-if-file-is-missing)
;;; init.el ends here
