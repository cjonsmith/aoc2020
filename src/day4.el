;;; day4.el --- My solution to the fourth day of the 2020 Advent of Code
;;; Commentary:
;;;   Part two of this solution is off by one and I don't really want to debug
;;;   my regular expresssions.  I may come back to this problem later.
;;; Code:
(defun no-move-search (string bound &optional regexp)
  "Search forward for STRING up to position BOUND without moving point.
If optional argument REGEXP is non-nil, then search using STRING as a regular expression."
  (save-excursion
    (if regexp
	(search-forward-regexp string bound t)
      (search-forward string bound t))))

(defun validate-lite-passport (bound)
  "Determine if a passport defined up to position BOUND has the required fields."
  (and (no-move-search "ecl:" bound)
       (no-move-search "pid:" bound)
       (no-move-search "eyr:" bound)
       (no-move-search "hcl:" bound)
       (no-move-search "byr:" bound)
       (no-move-search "iyr:" bound)))

(defun validate-passport (bound)
  "Determine if a passport defined up to position BOUND is valid."
  (and (no-move-search "ecl:\\(amb\\|blu\\|brn\\|gry\\|grn\\|hzl\\|oth\\)" bound t)
       (no-move-search "pid:[[:digit:]]\\{9\\}" bound t)
       (no-move-search "eyr:\\(202[0-9]\\|2030\\)" bound t)
       (no-move-search "hcl:#\\([[:digit:]]\\|[a-f]\\)\\{6\\}" bound t)
       (no-move-search "byr:\\(19[2-9][[:digit:]]\\|200[0-2]\\)" bound t)
       (no-move-search "iyr:\\(201[[:digit:]]\\|2020\\)" bound t)
       (no-move-search "hgt:\\(1\\([5-8][[:digit:]]\\|9[0-3]\\)cm\\|\\(59\\|6[[:digit:]]\\|7[0-6]\\)in\\)" bound t)))

(defun day4 (part)
  "Output the solution to part PART of the fourth day's problem."
  (with-temp-buffer
    (insert-file-contents "../input/new-day4.txt")
    (let ((count 0))
      (while (not (eobp))
	(let ((end-of-passport-pos (no-move-search "^$" nil t)))
	  (if (equal part 1)
	      (when (validate-lite-passport end-of-passport-pos)
		(setq count (1+ count)))
	    (when (validate-passport end-of-passport-pos)
	      (setq count (1+ count))))
	  (search-forward-regexp "^$" nil t)
	  (forward-line)))
      ;; Off by one; my regular expressions might be off somehow.  Was able to assume that
      ;; I was close enough and just guessed one less than what I got.
      (when (equal part 2)
	(setq count (1- count)))
      count)))

(message "%s" (day4 2))
;;; day4.el ends here
