;; (add-hook 'ruby-mode-hook #'rubocop-mode)
(setq rubocop-check-command
      "~/code/wegowise/bin/rubocop --format emacs")
(setq rubocop-autocorrect-command
      "~/code/wegowise/bin/rubocop -a --format emacs")

(setq flycheck-ruby-rubocop-executable "~/code/wegowise/bin/rubocop")
