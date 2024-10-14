;;; init.el --- emacs init
;;; Commentary:
;;; Code:

;; set minimum version
(let ((minver "29.0"))
  (when (version< emacs-version minver)
    (error "This config requires Emacs v%s or higher" minver)))

(add-to-list 'default-frame-alist '(font . "Spleen 16x32 10"))

(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(setq make-backup-files nil) ; stop creating ~ files
(defalias 'yes-or-no-p 'y-or-n-p)
(setq initial-scratch-message nil)
(setq create-lockfiles nil)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8
	  coding-system-for-read 'utf-8
	  coding-system-for-write 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

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

;; built-in global mode
(delete-selection-mode 1)

;; theme
(load-theme 'wombat)

(defun display-startup-echo-area-message ()
  "Disable startup message."
  (message ""))

(defun si/enable-line-numbers ()
  "Enable relative line numbers."
  (interactive)
  (display-line-numbers-mode)
  (setq display-line-numbers 'relative)
  )
(add-hook 'prog-mode-hook #'si/enable-line-numbers)
(put 'dired-find-alternate-file 'disabled nil)

;; bootstrap straight.el
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


;; editorconfig
(straight-use-package 'editorconfig)
(editorconfig-mode 1)

;; magit
(straight-use-package 'magit)
(with-eval-after-load 'magit
  (setq transient-default-level 5
	    magit-completing-read-function 'ivy-completing-read))

;; diff-hl
(straight-use-package 'diff-hl)
(global-diff-hl-mode)

;; company-mode
(straight-use-package 'company)
(straight-use-package 'company-quickhelp) ;; disable this cause didn't follow theme
(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode)))

;; projectile
(straight-use-package 'projectile)
;; (add-hook 'after-init-hook 'projectile-mode)
(projectile-mode +1)
(with-eval-after-load 'projectile
  (setq projectile-mode-line-prefix " P" ;; short modeline
        projectile-indexing-method 'alien
	    ;; projectile-completion-system 'ivy
        projectile-enable-caching nil
        projectile-sort-order 'default)
  (define-key projectile-mode-map (kbd "C-c p") projectile-command-map)
  ;; register project type
  (projectile-register-project-type 'zig '("build.zig")
                                    :project-file "build.zig"
				                    :compile "zig build"
				                    :run "zig build run")

  ;; ignored these directories globally
  (add-to-list 'projectile-globally-ignored-directories "node_modules") ; nodejs project
  (add-to-list 'projectile-globally-ignored-directories "vendor"))

;; which-key
(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.5)

;; swipper
(straight-use-package 'swiper)
(ivy-mode)
(setq ivy-use-selectable-prompt t)
(global-set-key "\C-s" 'swiper)

;; corfu -- COmpletion in Region FUnction
;; (straight-use-package 'corfu)
;; (global-corfu-mode)



;; setup eglot -- LSP client
(straight-use-package 'eglot)

;; treesitter
(customize-set-variable 'treesit-font-lock-level 4)
(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
        (bash-mode . bash-ts-mode)
        (js2-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode . json-ts-mode)
        (css-mode . css-ts-mode)
        (python-mode . python-ts-mode)
        (php-mode . php-ts-mode)))

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (php "https://github.com/tree-sitter/tree-sitter-php" "master" "php/src")))

;; highlight
(straight-use-package 'markdown-ts-mode)
(straight-use-package 'markdown-mode)

;; languages
(straight-use-package 'go-mode)
(straight-use-package 'zig-mode)

;; js/ts
(straight-use-package 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)
  ;; (flycheck-mode +1)
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; auto mode list
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zig.zon\\'" . zig-mode))

;; go specific
(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'gofmt)
            (add-hook 'before-save-hook 'gofmt-before-save)))

;; Ocaml
(straight-use-package 'dune)
(straight-use-package 'merlin)
(straight-use-package 'tuareg)
(straight-use-package 'flycheck-ocaml)
(flycheck-ocaml-setup)
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'merlin-mode-hook #'company-mode)


;; Lua
(straight-use-package 'lua-mode)


;; php
(straight-use-package
 '(php-ts-mode :type git :host github :repo "emacs-php/php-ts-mode"))

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-ts-mode))
(add-hook 'php-ts-mode-hook
          (lambda ()
			;; Use spaces for indent
			(setq-local indent-tabs-mode nil)
            (setq-local show-trailing-whitespace t)))

;;; init.el ends here

(put 'upcase-region 'disabled nil)
