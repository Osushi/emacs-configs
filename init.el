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
;; 指定行にジャンプする
(global-set-key "\C-xj" 'goto-line)
;; メニューバーを消す(Only Terminal)
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
;; 時計表示
(display-time)
(setq display-time-string-forms
      '((format "%s/%s(%s)%s:%s"
                month day dayname
                24-hours minutes
                )))
;; 選択したリージョンに上書き
(delete-selection-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; マウススクロールでカーソル移動
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key [mouse-4] (kbd "C-p"))
(global-set-key [mouse-5] (kbd "C-n"))

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
(ac-set-trigger-key "TAB")
(global-auto-complete-mode t)
(setq ac-auto-start t)

;; For undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; For whitespece
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(setq ruby-insert-encoding-magic-comment nil)

;; For ruby-end
(require 'ruby-end)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (abbrev-mode 1)
             (electric-pair-mode t)
             (electric-indent-mode t)
             (electric-layout-mode t)))

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

;; For go-mode
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-to-list 'load-path "~/.go/src/github.com/nsf/gocode/emacs")
(require 'go-autocomplete)
(require 'auto-complete-config)

(add-to-list 'load-path "~/.go/src/github.com/dougm/goflymake")
(require 'go-flymake)

;; For yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

;; For swift-mode
(require 'swift-mode)
