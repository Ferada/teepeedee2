(in-package #:tpd2.io)

(define-condition socket-error (error)
  ())
(define-condition socket-closed (socket-error)
  ())
(define-condition socket-explicitly-hungup (socket-error)
  ())

(defgeneric socket-read (socket buf offset))
(defgeneric socket-write (socket buf offset))
(defgeneric socket-accept (socket)) ; returns a CON
(defgeneric socket-close (socket))
(defgeneric socket-register (socket events con))

(defgeneric socket-supports-writev (socket))
(defgeneric socket-writev (socket iovec count))

(defmethod socket-supports-writev (socket)
  (declare (ignore socket)))

(defmethod socket-register (socket events con)
  (declare (ignore events))
  (debug-assert (eql socket (con-socket con)) (socket con))
  (values))

(defgeneric socket-recvfrom (socket buf)) ; returns (values length/nil address)
(defgeneric socket-sendto (socket address buf))

(defmethod socket-sendto (socket address buf)
  (declare (ignore address))
  (socket-write socket buf 0))

(defgeneric socket-shutdown-write (socket)
  (:method (socket)
    (declare (ignore socket))))

(defgeneric socket-peer (socket))

(defmethod socket-peer ((socket null))
  (declare (ignore socket)))

(defgeneric socket-only-accept-if-data-ready (socket timeout)
  (:method (socket timeout) (declare (ignore socket timeout))))
