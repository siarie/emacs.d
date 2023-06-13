;;; x-company.el --- company-mode configurations

;;; Code:

(straight-use-package 'company-mode)

(global-company-mode)
(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)
(setq company-backends '((company-files          ; files & directory
                          company-keywords       ; keywords
                          company-capf)
                         (company-abbrev company-dabbrev)))

(diminish 'company-mode)

(provide 'x-company)

;;; x-company.el ends here
