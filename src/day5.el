;;; day5.el --- My solution to the fifth day of the 2020 Advent of Code
;;; Commentary:
;;; Code:
(with-temp-buffer
  (insert-file-contents "../input/day5.txt")
  (let ((largest-id 0)
	(seat-ids ()))
    (while (not (eobp))
      (let ((front 0)
	    (back 127)
	    (left 0)
	    (right 7))
	(while (not (eolp))
	  (cond ((equal (thing-at-point 'char) "F")
		 (setq back (/ (+ front back) 2)))
		((equal (thing-at-point 'char) "B")
		 (setq front (ceiling (+ front back) 2)))
		((equal (thing-at-point 'char) "L")
		 (setq right (/ (+ left right) 2)))
		((equal (thing-at-point 'char) "R")
		 (setq left (ceiling (+ left right) 2))))
	  (forward-char))
	;; `front' and `back' should be equal at this point, and
	;; `left' and `right' should be equal as well.  They can be
	;; used interchangably following this point.
	(when (> (+ (* front 8) left) largest-id)
	  (setq largest-id (+ (* front 8) left)))
	(push (+ (* front 8) left) seat-ids))
      (forward-char))
    (let ((prev (car seat-ids)))
      (dolist (id (sort (cdr seat-ids) '<))
	(when (not (equal id (1+ prev)))
	  (message "Your (possible) seat number: %d" (1- id)))
	(setq prev id)))
    (message "Largest seat id: %d" largest-id)))
;;; day5.el ends here
