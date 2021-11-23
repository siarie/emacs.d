;;; lang-dart.el

;;; Code:

(straight-use-package 'dart-mode)


(defun lang/dart-mode--setup ()
  (eglot-ensure)
  (add-to-list 'eglot-server-programs
               `(dart-mode . ("dart" "language-server" "--diagnostic-port=12345"))))
  ;; (setq-local eglot-workspace-configuration '((:dart . ((:save "false"))))))

(add-hook 'dart-mode-hook #'lang/dart-mode--setup)

(provide 'lang-dart)

;;; lang-dart.el ends here
