;;; day2.el --- My solution to the second day of the 2020 Advent of Code
;;; Commentary:
;;; Code:
(let ((data (split-string
	     (with-temp-buffer
	       (insert-file-contents "../input/day2.txt")
	       (buffer-string)) "\n" t)))
  (let ((count 0))
    (dolist (line data)
      (let* ((split-line (split-string line))
	     (range (mapcar 'string-to-number
			    (split-string
			     (nth 0 split-line)
			     "-")))
	     (min (nth 0 range))
	     (max (nth 1 range))
	     (character (string-to-char (substring (nth 1 split-line) 0 1)))
	     (password (nth 2 split-line))
	     (num-chars-in-pw (length (seq-filter
				       (lambda (char) (char-equal char character))
				       password))))
	(when (and
	       (>= num-chars-in-pw min)
	       (<= num-chars-in-pw max))
	  (setq count (1+ count)))))
    (message "%d" count)))
;;; day2.el ends here
