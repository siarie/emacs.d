;;; lang-zig.el --- zig programming language

;;; Code:

(straight-use-package 'zig-mode)

(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))


(provide 'lang-zig)

;;; lang-zig.el ends here
