;;; day3.el --- My solution to the thrid day of the 2020 Advent of Code
;;; Commentary:
;;;   Solution uses a temporary buffer instead of loading conents of the input file into
;;;   a variable.
;;; Code:
(defun safe-move-right ()
  "Move point right one character without moving to the next line.
If point is at the end of the line, move it to the beginning of the current line."
  (forward-char)
  (when (string-equal (string (char-after)) "\n")
    (beginning-of-line)))

(defun next-line-same-column ()
  "Move point to the next line at the same column it already occupies."
  (let ((column (current-column)))
    (forward-line)
    (move-to-column column)))

(defun traverse ()
  "Move point three times to the right, then down one line.
If when moving right the last non-newline character is found, move to the
beginning of the line.  When moving down, point will occupy the same column
that it did in the previous line."
  (dotimes (_ 3)
    (safe-move-right))
  (next-line-same-column))

(with-temp-buffer
  (insert-file-contents "../input/day3.txt")
  (let ((count 0)
	(num-lines (count-lines (point-min) (point-max))))
    (while (not (equal (line-number-at-pos) num-lines))
      (traverse)
      (when (equal (thing-at-point 'char) "#")
	(setq count (1+ count))))
    (message "%d" count)))
;;; day3.el ends here
