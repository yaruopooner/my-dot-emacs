;; ps2ref.el

(defun jump-psref ()
  "search PS function manual"
  (interactive)
  (if (not (file-exists-p "~/.lib_idx"))
      (progn
	(message "making ~/.lib_idx , please wait.")
	(shell-command "grep -n '^sce' /usr/local/sce/lib/doc/*.txt > ~/.lib_idx")))
  (let (beg end line file)
    (save-excursion
      (if (not (looking-at "\\<"))
	  (forward-word -1))
      (setq beg (point))
      (forward-word 1)
      (setq end (point))
      (setq case-fold-search nil)
      (setq search-last-string (buffer-substring beg end)))
    (other-window 1)
    (if (get-buffer "*psref*")
	(kill-buffer "*psref*"))
    (get-buffer-create "*psref*")
    (switch-to-buffer "*psref*")
    (insert-file "~/.lib_idx")
    (search-forward search-last-string)
    (search-backward-regexp ":.*:")
    (setq line (buffer-substring (+ (match-beginning 0) 1) (- (match-end 0) 1)))
    (beginning-of-line)
    (setq file (buffer-substring (point) (match-beginning 0)))
    (switch-to-buffer "*psref*")
    (kill-region (point-min) (point-max))
    (insert-file file)
    (goto-line (string-to-int line))))

;;(global-set-key "\e?" 'jump-psref)

;; eof
