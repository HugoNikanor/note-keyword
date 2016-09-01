(ns sql-wrapper.core
  (:require [sql-wrapper.insert :as db])
  (:gen-class))

;; MAIN
(defn -main [& args]
  (def reader (new java.io.BufferedReader *in*))
  (let [file-name (.readLine reader)
        course (.readLine reader)
        name (.readLine reader)
        keywords (line-seq reader)]
    (db/add-keywords-main! :date file-name
                           :course course
                           :document_name name
                           :keywords keywords)))
