;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; Set Charset
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; Set Backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Set Editer
(show-paren-mode t)
(column-number-mode t)
(line-number-mode t)
(setq-default tab-width 2 indent-tabs-mode nil)
(global-font-lock-mode t)
(global-set-key "\C-xj" 'goto-line)
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(display-time)
(setq display-time-string-forms
      '((format "%s/%s(%s)%s:%s"
                month day dayname
                24-hours minutes
                )))
(delete-selection-mode t)
(size-indication-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Packages
(require 'cask)
(cask-initialize)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; helm
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; php-mode, php-cs-fixer
(require 'php-mode)
(add-hook 'php-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 2)
            (define-key php-mode-map "\C-c\C-i" 'php-cs-fixer)
            )
          )
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(defun php-cs-fixer ()
  (interactive)
  (setq filename (buffer-file-name (current-buffer)))
  (call-process "php-cs-fixer" nil nil nil "fix" filename)
  (revert-buffer t t)
  )

;; point-undo
(global-set-key (kbd "\C-o") 'all-indent)
(require 'point-undo)
(defun all-indent ()
  (interactive)
  (mark-whole-buffer)
  (indent-region (region-beginning)(region-end))
  (point-undo)
  )

;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'php-mode-hook 'rainbow-delimiters-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig?$" . web-mode))
(defun web-mode-indent (num)
  (interactive "nIndent: ")
  (setq web-mode-markup-indent-offset num)
  (setq web-mode-css-indent-offset num)
  (setq web-mode-style-padding num)
  (setq web-mode-code-indent-offset num)
  (setq web-mode-script-padding num)
  (setq web-mode-block-padding num)
  (setq web-mode-tag-auto-close-style 2)
  )
(web-mode-indent 2)

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

;; theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-bright t)
