;; stop spacemacs from hiding usefull buffers in buffer list
(setq spacemacs-useless-buffers-regexp nil)

;; fix buffer list cursor jumping bug
(add-hook 'Buffer-menu-mode-hook
          (lambda ()
            (setq-local revert-buffer-function
                        (lambda (&rest args)))))

;; show full file path in frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(defun my-spaceline-theme ()
  (setq spaceline-window-numbers-unicode t)
  (spaceline-install '(((window-number
                         persp-name
                         point-position
                         line-column
                         buffer-position)
                        :face highlight-face)
                       anzu
                       auto-compile
                       '(buffer-modified
                         buffer-size)
                       buffer-id
                       (process :when active)
                       ((flycheck-error flycheck-warning flycheck-info)
                        :when active)
;;                       (minor-modes :when active)
                       (mu4e-alert-segment :when active)
                       (erc-track :when active)
                       (version-control :when active)
                       (org-pomodoro :when active)
                       (org-clock :when active))

                     '(which-function
                       (python-pyvenv :fallback python-pyenv)
                       purpose
                       selection-info
                       input-method
                       buffer-encoding-abbrev
                       (global :when active))))
(my-spaceline-theme)

;; this formats the Helm buffer list to only show the buffer name and directory
(defun helm-buffer--show-details (buf-name prefix help-echo
                                           size mode dir face1 face2
                                           proc details type)
  (append
   (list
    (concat prefix
            (propertize buf-name 'face face1
                        'help-echo help-echo
                        'type type)))
   (and details
        (list (propertize
               (if proc
                   (format "(%s %s in `%s')"
                           (process-name proc)
                           (process-status proc) dir)
                 (format "(in `%s')" dir))
               'face face2)))))
