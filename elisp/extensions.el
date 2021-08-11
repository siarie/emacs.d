;;; extensions.el

;; company-mode
(el-get-bundle company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)

;; which keys
(el-get-bundle which-key)
(which-key-mode 1)
(setq which-key-idle-delay 0.6)

;; ivy, counsel and swiper
(el-get-bundle swiper)
(ivy-mode 1)
(global-set-key (kbd "C-x s") 'swiper)

;; yasnippet
(el-get-bundle yasnippet)
(yas-global-mode 1)

;; editorconfig
(el-get-bundle editorconfig)
(editorconfig-mode 1)

;; projectile
(el-get-bundle projectile)
(add-hook 'after-init-hook 'projectile-mode)
(with-eval-after-load 'projectile
  (setq projectile-mode-line-prefix " pj" ;; short modeline
	projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") projectile-command-map))

;; rainbow delimiters
(el-get-bundle rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; magit
(el-get-bundle magit)
(with-eval-after-load 'magit
  (setq transient-default-level 5
	magit-completing-read-function 'ivy-completing-read))

(provide 'extensions)
