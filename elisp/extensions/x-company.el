;;; x-company.el --- company-mode configurations

;;; Code:

(el-get-bundle company-mode)


(global-company-mode)

(setq company-backends '((company-files          ; files & directory
                          company-keywords       ; keywords
                          company-capf
                          company-yasnippet)
                         (company-abbrev company-dabbrev)))

(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)

;; (add-to-list 'company-backends 'company-yasnippet)
(diminish 'company-mode)

(provide 'x-company)

;;; x-company.el ends here
