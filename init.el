;;; init.el --- init.el
;;; Commentary:
;;; Code:

;; System
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq make-backup-files nil)
(setq auto-save-default nil)

(show-paren-mode t)
(column-number-mode t)
(line-number-mode t)
(global-font-lock-mode t)

(global-set-key "\C-xj" 'goto-line)
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(delete-selection-mode t)
(size-indication-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq confirm-kill-emacs 'y-or-n-p)

;; Packages
(require 'cask)
(cask-initialize)

;; theme
(require 'molokai-theme)
(setq molokai-theme-kit t)

;; helm
(require 'helm-config)
(require 'helm-ag)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-buffers-list)
(global-set-key (kbd "C-M-s") #'helm-ag)
(global-set-key (kbd "C-x C-r") #'helm-imenu)
(custom-set-variables
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text"))

;; company
(require 'company)
(global-company-mode +1)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")
(global-set-key (kbd "C-c i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key emacs-lisp-mode-map (kbd "C-c i") 'company-complete)

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        ))
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
(yas-global-mode 1)

;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-display-errors-delay 0.3)
(define-key global-map (kbd "\C-cn") 'flycheck-next-error)
(define-key global-map (kbd "\C-cp") 'flycheck-previous-error)
(define-key global-map (kbd "\C-cl") 'flycheck-list-errors)

;; anzu
(require 'anzu)
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'php-mode-hook 'rainbow-delimiters-mode)

;; php-mode
(require 'php-mode)
(require 'phpcbf)
(custom-set-variables
 '(phpcbf-standard "PSR2")
 '(flycheck-phpcs-standard "PSR2")
 '(php-manual-url "http://php.net/ja/manual"))
(add-hook 'php-mode-hook
          (lambda ()
            (require 'company-php)
            (ac-php-core-eldoc-setup)
	    (make-local-variable 'company-backends)
	    (add-to-list 'company-backends '(company-ac-php-backend company-yasnippet :with company-dabbrev-code))
	    (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)
	    (add-hook 'php-mode-hook 'php-enable-default-coding-style)
	    (define-key php-mode-map  (kbd "C-c C-i") 'phpcbf)
	    )
          )
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade.php\\'" . web-mode))

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-hook 'js2-mode-hook 'js-indent-hook)

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

;; json-mode
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; markdown mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; editor config
(require 'editorconfig)
(editorconfig-mode 1)

;;; init.el ends here
