;-------------------hightlight symbol with double click----------------------------

(setq load-path (cons (expand-file-name "/home/shafqat/my_cloud/Develop/emacs/highlight") load-path))
(require 'highlight-symbol)
(global-set-key [double-mouse-1] 'copy-and-highlight)

(global-set-key (kbd "C-n")         (quote highlight-symbol-next))
(global-set-key (kbd "C-p")         (quote highlight-symbol-prev))
(global-set-key (kbd "M-r")         (quote highlight-symbol-remove-all))


(defun copy-and-highlight ()
  "copy the word under point and highligt it"
  (interactive)
  (highlight-symbol-at-point)
  (copy-word)
  )

                                        ;--------------------- Copy word---------------------
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
         (lambda()
           (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
            nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))



(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  )
