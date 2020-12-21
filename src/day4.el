;;; day4.el --- My solution to the fourth day of the 2020 Advent of Code
;;; Commentary:
;;; Code:
(defun no-move-search (string bound &optional regexp)
  "Search forward for STRING up to position BOUND without moving point.
If optional argument REGEXP is non-nil, then search using STRING as a regular expression."
  (save-excursion
    (if regexp
	(search-forward-regexp string bound t)
      (search-forward string bound t))))

(defun validate-passport (bound)
  "Determine if a passport defined up to position BOUND is valid."
  (and (no-move-search "ecl:" bound)
       (no-move-search "pid:" bound)
       (no-move-search "eyr:" bound)
       (no-move-search "hcl:" bound)
       (no-move-search "byr:" bound)
       (no-move-search "iyr:" bound)
       (no-move-search "hgt:" bound)))

(with-temp-buffer
  (insert-file-contents "../input/day4.txt")
  (let ((count 0))
    (while (not (eobp))
      (let ((end-of-passport-pos (no-move-search "^$" nil t)))
	(when (validate-passport end-of-passport-pos)
	  (setq count (1+ count)))
	(search-forward-regexp "^$" nil t)
	(forward-line)))
    count))
;;; day4.el ends here
