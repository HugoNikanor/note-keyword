(ns sql-wrapper.core
  (:require [clojure.java.jdbc :as sql]))

(def database {:subprotocol "mysql"
               :subname "//127.0.0.1:3306/note_keywords"
               :user "root"
               :password ""})

;; TODO error handling on already existing courses
(defn add-course! [name department]
  ((first (sql/insert! database
                       :courses
                       {:name name
                        :department department}))
   :generated_key))

;; TODO error handling on already existing notes
(defn add-note! [date course_id & [name]]
  ((first (sql/insert! database
                       :notes
                       (merge {:date date
                               :course_id course_id}
                              (if name {:name name}))))
   :generated_key))

;; TODO error handling on already existing keywords
(defn add-keyword-defs! [& name]
  (map #(%1 :generated_key)
       (sql/insert-multi! database :keywords (map #(hash-map :name %1) name))))

;; TODO error handling on already existing keywords
(defn add-keyword-bindings! [note_id & keyword_ids]
  (map #(%1 :generated_key)
       (sql/insert-multi! database :keyword_bindings 
                    (map #(hash-map :note_id note_id :keyword_id %1) keyword_ids))))

(defn add-keywords-main! [& {:keys [department course date document_name keywords]}]
  (let [course_id (add-course! course department)
        note_id (add-note! date course_id (if document_name document_name))
        keyword_ids (apply add-keyword-defs! keywords)]
    (apply add-keyword-bindings! (cons note_id keyword_ids))))

;; MAIN
(defn -main [& args]
  (println args))
