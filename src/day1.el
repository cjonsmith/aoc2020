;;; day1.el --- My solution to the first day of the 2020 Advent of Code

;;; Commentary:
;;; code:
; Part 1 of the problem: find the product of two numbers whose sum is 2020.
(let ((data (mapcar 'string-to-number
		    (split-string
		     (with-temp-buffer
		       (insert-file-contents "../input/day1.txt")
		       (buffer-string))))))
  (catch 'match
    (while data
      (dolist (num (cdr data))
	(when (equal (+ num (car data))
		     2020)
	  (throw 'match (* num (car data)))))
      (pop data))))

; Part 2 of the problem: find the product of three numbers whose sum is 2020.
(let ((data (mapcar 'string-to-number
		    (split-string
		     (with-temp-buffer
		       (insert-file-contents "../input/day1.txt")
		       (buffer-string))))))
  (catch 'match
    (while data
      (dolist (numa (cdr data))
	(dolist (numb (cddr data))
	  (when (equal (+
			(car data)
			numa
			numb)
		       2020)
	    (throw 'match (*
			   (car data)
			   numa
			   numb)))))
      (pop data))))
;;; day1.el ends here
