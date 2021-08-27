;;; x-company.el --- company-mode configurations

;;; Code:

(el-get-bundle company-mode)

(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode)
            (setq company-minimum-prefix-length 2
                  company-idle-delay 0.2)
            (diminish 'company-mode)))

(provide 'x-company)

;;; x-company.el ends here
