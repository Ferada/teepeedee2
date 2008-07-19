(in-package #:tpd2.http)

(defun url-encoding-decode (encoded)
  (declare (optimize speed (safety 0)))
  (declare (type byte-vector encoded))
  (match-replace-all 
   encoded
   (("%" (word (string 2)))
    (vector (byte-vector-parse-integer word 16)))
   ("+" " ")))

(defun percent-hexpair-encode (plain)
  (declare (optimize speed (safety 0)))
  (declare (type byte-vector plain))
  (match-replace-all 
   plain
   ((c (and (not (or (- #\A #\Z) (- #\a #\z) (- #\0 #\9) #\- #\_ )) (char)))
    (labels ((digit (digit)
	       (if (>= digit 10)
		   (+ digit (- (char-code #\A) 10))
		   (+ digit (char-code #\0)))))
      (multiple-value-bind (hi lo)
	  (floor (aref c 0) 16)
	(vector (char-code #\%) (digit hi) (digit lo)))))))
