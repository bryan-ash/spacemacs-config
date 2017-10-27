(remove-hook 'prog-mode-hook #'smartparens-mode)
(spacemacs/toggle-smartparens-globally-off)

(eval-after-load 'smartparens
  '(progn
     (sp-pair "(" nil :actions :rem)
     (sp-pair "[" nil :actions :rem)
     (sp-pair "{" nil :actions :rem)
     (sp-pair "'" nil :actions :rem)
     (sp-pair "\"" nil :actions :rem)
     (sp-pair "\\\"" nil :actions :rem)
     ))
