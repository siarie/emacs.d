;;; init.el --- emacs init
;;; Code:

;; set minimum version
(let ((minver "28.0"))
  (when (version< emacs-version minver)
    (error "this config requires emacs v%s or higher." minver)))

;; (menu-bar-mode -1)
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(setq make-backup-files nil) ; stop creating ~ files
(defalias 'yes-or-no-p 'y-or-n-p)
(setq initial-scratch-message nil)


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

;; built-in global mode
(delete-selection-mode 1)
;; theme
(load-theme 'wombat)

(defun display-startup-echo-area-message ()	       
  (message ""))

(defun si/enable-line-numbers ()
  "Enable relative line numbers"
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


;; company-mode
(straight-use-package 'company)
;; (straight-use-package 'company-quickhelp) ;; disable this cause didn't follow theme
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

;; languages
(straight-use-package 'go-mode)
(straight-use-package 'zig-mode)

;; auto mode list
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zig.zon\\'" . zig-mode))

;; go specific
(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'gofmt)
            ;; format before save
            (add-hook 'before-save-hook 'gofmt-before-save)))

;; Ocaml
(straight-use-package 'dune)
(straight-use-package 'merlin)
(straight-use-package 'tuareg)
(straight-use-package 'flycheck-ocaml)

(flycheck-ocaml-setup)
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'merlin-mode-hook #'company-mode)

;; (add-to-list 'load-path "/home/neo/.opam/5.1.1/share/emacs/site-lisp")
;; (require 'ocp-indent)

;;; init.el ends here

