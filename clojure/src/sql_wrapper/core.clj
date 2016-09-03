(ns sql-wrapper.core
  (:require [sql-wrapper.insert :as db]
            [clojure.tools.cli :refer [parse-opts]])
  (:gen-class))


(defn -main [& args]

  (def option-vector
    [["-d" "--database DATABASE" "MySQL database name"
      :default "note_keywords"]
     ["-u" "--user USER" "MySQL user"
      :default "root"]
     ["-p" "--password PASSWORD" "MySQL password for USER"
      :default ""]
     ["-h" "--help"]])

  (let [{:keys [options arguments errors summary]} (parse-opts args option-vector)]
    (if (:help options)
      (do (println summary)
          (System/exit 0))
      (let [reader (new java.io.BufferedReader *in*)
            file-name (.readLine reader)
            course (.readLine reader)
            name (.readLine reader)
            keywords (line-seq reader)]
        (db/add-keywords-main! :date file-name
                               :course course
                               :document_name name
                               :keywords keywords)))))
