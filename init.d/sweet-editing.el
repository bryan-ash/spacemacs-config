(define-prefix-command 'sweet-editing-map)
(global-set-key (kbd "C-.") 'sweet-editing-map)
(define-key sweet-editing-map (kbd "C-f") 'fiplr-find-file)
(define-key sweet-editing-map (kbd "C-g") 'magit-status)
(define-key sweet-editing-map (kbd "C-r f") 'rubocop-check-current-file)
(define-key sweet-editing-map (kbd "C-r F") 'rubocop-autocorrect-current-file)

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
(define-key global-map (kbd "C-S-j") 'evil-join)
(define-key global-map (kbd "C-S-k") 'kill-whole-line)
(define-key global-map (kbd "C-x p") 'previous-multiframe-window)

(global-set-key "\C-x\C-b" 'buffer-menu)

;; tell flyspell to use mouse-3 instead of mouse-2
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

(defun duplicate-line()
  "Duplicate the current line"
  (interactive)
  (let ((beg (line-beginning-position))
        (end (line-end-position))
        (column (current-column)))
    (copy-region-as-kill beg end)
    (end-of-line)
    (newline)
    (yank)
    (move-to-column column)))
(define-key global-map (kbd "C-S-d") 'duplicate-line)

(defun insert-and-move-to-new-line ()
  "Inserts a blank line after the current one"
  (interactive)
  (end-of-line)
  (do-return))
(define-key global-map (kbd "M-<return>") 'insert-and-move-to-new-line)

(defun insert-before-and-move-to-new-line ()
  "Inserts a blank line before the current one"
  (interactive)
  (previous-line)
  (insert-and-move-to-new-line)
  (indent-according-to-mode))
(define-key global-map (kbd "M-S-<return>") 'insert-before-and-move-to-new-line)

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (forward-line -2)
    (move-to-column col)))

(global-set-key (kbd "<C-S-up>") 'move-line-up)
(global-set-key (kbd "<C-S-down>") 'move-line-down)

(defun do-return ()
  (funcall (or (local-key-binding (kbd "<return>")) (key-binding (kbd "RET")))))

;; Keep region when undoing in region
(defadvice undo-tree-undo (around keep-region activate)
  (if (use-region-p)
      (let ((m (set-marker (make-marker) (mark)))
            (p (set-marker (make-marker) (point))))
        ad-do-it
        (goto-char p)
        (set-mark m)
        (set-marker p nil)
        (set-marker m nil))
    ad-do-it))

;; fix Ruby indenting
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; allow emacsclient to open in this instance
(server-start)

;; use UTF-8 everywhere
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en_GB.UTF-8")
(prefer-coding-system 'utf-8)

(setq ruby-use-smie nil)

;; turn on fill-column-indicator line for all code buffers
(add-hook 'coffee-mode-hook 'fci-mode)
(add-hook 'js-mode-hook 'fci-mode)
(add-hook 'ruby-mode-hook 'fci-mode)
(add-hook 'yaml-mode-hook 'fci-mode)

(provide 'sweet-editing)
