;;; x-projectile.el --- projectile configurations

;;; Code:

(straight-use-package 'projectile)

(add-hook 'after-init-hook 'projectile-mode)
(with-eval-after-load 'projectile
  (setq projectile-mode-line-prefix " pj" ;; short modeline
	    projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") projectile-command-map)

  ;; ignored these directories globally
  (add-to-list 'projectile-globally-ignored-directories "node_modules") ; nodejs project
  (add-to-list 'projectile-globally-ignored-directories "vendor"))

(provide 'x-projectile)

;;; x-projectile.el ends here
