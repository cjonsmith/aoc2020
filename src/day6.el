;;; day6.el --- My solution to the sixth day of the 2020 Advent of Code
;;; Commentary:
;;; Code:
(with-temp-buffer
  (insert-file-contents "../input/day6.txt")
  (let ((total-responses 0))
    (while (not (eobp))
      (narrow-to-region (point)
			(re-search-forward "^$"))
      (setq total-responses (+ total-responses
			       (length (delete-dups (delq (string-to-char "\n")
							  (append (buffer-string) ()))))))
      (widen)
      (forward-line))
    total-responses))
;;; day6.el ends here
