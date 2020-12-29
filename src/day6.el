;;; day6.el --- My solution to the sixth day of the 2020 Advent of Code
;;; Commentary:
;;; Code:
(require 'cl-lib)

;; Part 1
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

;; Part 2
(with-temp-buffer
  (insert-file-contents "../input/day6.txt")
  (let ((total-responses 0))
    (while (not (eobp))
      (narrow-to-region (point)
			(re-search-forward "^$"))
      (let* ((responses (split-string (buffer-string)))
	     (resp-intersect (append (car responses) ())))
	(dolist (response (cdr responses))
	  (setq resp-intersect (cl-intersection resp-intersect (append response ()))))
	(setq total-responses (+ total-responses (length resp-intersect))))
      (widen)
      (forward-line))
    total-responses))
;;; day6.el ends here
