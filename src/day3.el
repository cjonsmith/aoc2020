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

(defun traverse (right down)
  "Move point RIGHT times to the right, then down DOWN line.
If when moving right the last non-newline character is found, move to the
beginning of the line.  When moving down, point will occupy the same column
that it did in the previous line."
  (dotimes (_ right)
    (safe-move-right))
  (dotimes (_ down)
    (next-line-same-column)))

(defun number-of-trees (right down)
  "Return the number of trees encountered when traversing the hill.
The route taken down the hill is determined by moving RIGHT number of times to
the right, and then moving down DOWN number of times.  If when moving right the
last non-newline character is found, move to the beginning of the line.  When
moving down, point will occupy the same column that it did in the previous line.
The sum of trees that were encountered after moving point until the end of the buffer
is returned."
  (let ((count 0)
	(num-lines (count-lines (point-min) (point-max))))
    (while (not (equal (line-number-at-pos) num-lines))
      (traverse right down)
      (when (equal (thing-at-point 'char) "#")
	(setq count (1+ count))))
    count))


(with-temp-buffer
  (insert-file-contents "../input/day3.txt")
  (message "%d" (number-of-trees 3 1)))
;;; day3.el ends here
