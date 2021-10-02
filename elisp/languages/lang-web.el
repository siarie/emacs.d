;;; lang-web.el --- html, css, js

;;; code:

(straight-use-package 'web-mode)
(straight-use-package 'company-web)


;; automatically activate web-mode when opening files with any
;; extensions listed bellow
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade.php\\'" . web-mode))

;; front-end frameworks
(add-to-list 'auto-mode-alist '("\\.riot\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; jinja(2) & django
(add-to-list 'auto-mode-alist '("\\.j2\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(defun lang/web-mode--setup ()
  "Web mode config."
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2)

  (with-eval-after-load 'web-mode
    (setq web-mode-enable-auto-pairing t
	      web-mode-enable-css-colorization t)))

(add-hook 'web-mode-hook 'lang/web-mode--setup)

(provide 'lang-web)

;;; lang-web.el ends here
