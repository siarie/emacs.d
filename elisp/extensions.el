;;; extensions.el

;; company-mode
(el-get-bundle company-mode)
(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode)
            (setq company-minimum-prefix-length 2
                  company-idle-delay 0.2)
            (diminish 'company-mode)))

;; which keys
(el-get-bundle which-key)
(which-key-mode 1)
(setq which-key-idle-delay 0.6)
(diminish 'which-key-mode)

;; ivy, counsel and swiper
(el-get-bundle swiper)
(ivy-mode 1)
(global-set-key (kbd "C-x s") 'swiper)
(diminish 'ivy-mode)

;; yasnippet
(el-get-bundle yasnippet)
(yas-global-mode 1)

;; editorconfig
(el-get-bundle editorconfig)
(editorconfig-mode 1)
(diminish 'editorconfig-mode)

;; projectile
(el-get-bundle projectile)
(add-hook 'after-init-hook 'projectile-mode)
(with-eval-after-load 'projectile
  (setq projectile-mode-line-prefix " pj" ;; short modeline
	projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") projectile-command-map))

;; rainbow delimiters
(el-get-bundle rainbow-delimiters)
(add-hook 'prog-mode-hook (lambda ()
                            (rainbow-delimiters-mode)
                            (diminish 'rainbow-delimiters-mode)))

;; magit
(el-get-bundle magit)
(with-eval-after-load 'magit
  (setq transient-default-level 5
	magit-completing-read-function 'ivy-completing-read))

;; diminish
(el-get-bundle diminish)
;; (eval-after-load 'diminish
;;   (diminish 'company-mode)
;;   (diminish 'editorconfig)
;;   (diminish 'ivy))

(provide 'extensions)
