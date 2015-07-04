;; Set Language For Japanese
(set-language-environment 'Japanese)

;; Set Environment For Mac App
(setq default-input-method "MacOSX")
(when (eq window-system 'ns)
  (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")
  ;; ツールバーの非表示
  (tool-bar-mode 0)
  )

;; Set Backup
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; Set Char-Set
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Set Editer
;; 対応括弧のハイライト表示
(show-paren-mode t)
;; モードラインの行,列表示
(column-number-mode t)
(line-number-mode t)
;; タブキーをスペース2個に変更
(setq-default tab-width 2 indent-tabs-mode nil)
;; キーワードのカラー表示
(global-font-lock-mode t)
;; セーブ時に末尾のスペースを削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Set Cask Path
(require 'cask)
(cask-initialize)

;; Set Plugin
;; For smooth-scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; For auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-start t)

;; For php-mode, php-cs-fixer, php-completion
(require 'php-mode)
(setq php-enable-psr2-coding-style t)
(add-hook 'php-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 2)
            (define-key php-mode-map "\C-c\C-i" 'php-cs-fixer)
            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
            (when (require 'auto-complete nil t)
              (make-variable-buffer-local 'ac-sources)
              (add-to-list 'ac-sources 'ac-source-php-completion)
              (auto-complete-mode t))
            )
          )
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; For Helm
(require 'helm-config)
(helm-mode 1)

;; For smartparens
(require 'smartparens-config)
(smartparens-global-mode t)

;; For rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'php-mode-hook 'rainbow-delimiters-mode)

;; For ruby-mode
(autoload 'ruby-mode "ruby-mode"
    "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; For ruby-end
;; (require 'ruby-end)

;; For ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; For web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl?$" . web-mode))
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

;; For markdown-mode
(require 'markdown-mode)

;; For flycheck
(require 'flycheck)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(add-hook 'php-mode-hook 'flycheck-mode)

;; Set Function
;; For php-cs-fixer
(defun php-cs-fixer ()
  (interactive)
  (setq filename (buffer-file-name (current-buffer)))
  (call-process "php-cs-fixer" nil nil nil "fix" filename )
  (revert-buffer t t)
  )
(put 'set-goal-column 'disabled nil)
