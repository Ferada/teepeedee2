(asdf:defsystem :teepeedee2-blog
  :depends-on (:teepeedee2
               :cl-fad)
  :components ((:module :src
                :components ((:file "packages")
                             (:module :blog
                              :depends-on (:webapp :ml :datastore)
                              :components ((:file "entry")
                                           (:file "feed" :depends-on ("blog"))
                                           (:file "blog" :depends-on ("entry"))))))))
