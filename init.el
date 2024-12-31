;;; init.el --- emacs init
;;; Commentary:
;;; Code:

;; set minimum version
(let ((minver "29.0"))
  (when (version< emacs-version minver)
    (error "This config requires Emacs v%s or higher" minver)))

;;; Frame configuration
(add-to-list 'default-frame-alist '(font . "Spleen 16x32 10"))
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
(defun si/kill-word-or-region ()
  "Kill the region if the mark is active, otherwise kill the previous word."
  (interactive)
  (if mark-active
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'si/kill-word-or-region)
(global-set-key "\C-d" 'backward-delete-char)
(global-set-key (kbd "C-,") (lambda ()
                              (interactive)
                              (duplicate-line)
                              (next-line)))

;; theme
(load-theme 'wombat)
(custom-set-faces
 '(highlight ((t (:background "#353535" :underline nil))))
 '(hl-line ((t (:background "#353535" :underline nil))))
 '(vertical-border ((t (:foreground "#95e454")))))

(set-face-attribute
 'fill-column-indicator nil
 :foreground "#e5786d"
 :background 'unspecified)

;; built-in global mode
(global-hl-line-mode 1)
(delete-selection-mode 1)

(setq display-line-numbers 'relative)
(global-display-line-numbers-mode 1)

(setq-default display-fill-column-indicator-character ?┃)
(global-display-fill-column-indicator-mode 1)

(column-number-mode 1)
(fido-mode 1)

;; treesitter
(customize-set-variable 'treesit-font-lock-level 4)

;; setup eglot -- LSP client
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (define-key eglot-mode-map (kbd "C-c e f") 'eglot-format-buffer)
            (define-key eglot-mode-map (kbd "C-c e r") 'eglot-rename)))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; External Packages
;;;;;;;;;;;;;;;;;;;;
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'eldoc-box)
(add-hook 'eldoc-mode-hook 'eldoc-box-hover-at-point-mode)
;; (eldoc-box-hover-at-point-mode 1)

(straight-use-package 'which-key)
(setq which-key-idle-delay 0.5)
(which-key-mode)

;; editorconfig
(straight-use-package 'editorconfig)
(editorconfig-mode 1)

;; magit
(straight-use-package 'magit)
(with-eval-after-load 'magit
  (setq transient-default-level 5))

;; diff-hl
(straight-use-package 'diff-hl)
(global-diff-hl-mode)

;; company-mode
(straight-use-package 'company)
(straight-use-package 'company-quickhelp) ;; disable this cause didn't follow theme
(global-company-mode 1)
(add-hook 'company-mode-hook
          (lambda ()
            (company-quickhelp-mode 1)))

(straight-use-package 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(straight-use-package 'markdown-mode)

;; languages
(straight-use-package 'web-mode)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)


(straight-use-package 'go-mode)
(straight-use-package 'zig-mode)

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
(straight-use-package 'dune)
(straight-use-package 'tuareg)
(add-hook 'tuareg-mode-hook #'eglot-ensure)

;; Lua
(straight-use-package 'lua-mode)

;; php
(straight-use-package 'php-mode)
;; (straight-use-package
;;  '(php-ts-mode :type git :host github :repo "emacs-php/php-ts-mode"))

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
   '(php-imenu-generic-expression 'php-imenu-generic-expression-simple)))


;; Custom modeline
(defun rc/modeline-buffer-name ()
  (let ((name (buffer-name))
        (symbol (cond (buffer-read-only (format "%s " (char-to-string #xE0A2)))
                      ((buffer-modified-p) "◆ ")
                      (t ""))))
    (format "%s%s" symbol name)))

(defvar-local rc/mode-line-buffer-identification
    '(:eval
      (propertize (rc/modeline-buffer-name))))

(put 'rc/mode-line-buffer-identification 'risky-local-variable t)

(defun rc/modeline-vc-mode ()
  (let* ((file (buffer-file-name))
         (backend (and file (vc-backend file)))
         (rev (cond
               ((eq backend 'Git) (vc-git--symbolic-ref file))
               (t (vc-working-revision file backend)))))
    (when (and backend rev)
      (format "[%s:%s] " (symbol-name backend) rev))))

(defvar-local rc/mode-line-vc-mode
    '(:eval
      (propertize (rc/modeline-vc-mode))))

(put 'rc/mode-line-vc-mode 'risky-local-variable t)

(defvar-local rc/mode-line-major-mode
    '(:eval
      (propertize (capitalize (string-replace "-mode" "" (symbol-name major-mode)))
                  'face '(t :background "#b85149" :inherit bold)))
  "Mode line construct to display the major mode.")

(put 'rc/mode-line-major-mode 'risky-local-variable t)


(defun rc/modeline-render (left right)
  "Return a string of `window-width' length.
Containing LEFT, and RIGHT aligned respectively."
  (let ((available-width
         (- (window-total-width)
            (+ (length (format-mode-line left))
               (length (format-mode-line right))))))
    (append left
            (list (format (format "%%%ds" available-width) ""))
            right)))

(setq-default mode-line-format
              '((:eval
                 (rc/modeline-render
                  ;; left
                  (quote ("%e"
                          mode-line-front-space
                          rc/mode-line-vc-mode
                          rc/mode-line-buffer-identification
                          ;; TODO: Flymake/Flycheck
                          ))
                  ;; Right
                  (quote ("%e"
                          
                          " Ln %l, Col %c"
                          " %p "
                          rc/mode-line-major-mode
                          mode-line-end-spaces
                          ))))))


;;; init.el ends here
