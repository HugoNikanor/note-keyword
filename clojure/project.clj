(defproject sql-wrapper "0.1.0-SNAPSHOT"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.clojure/tools.cli "0.3.5"]
                 [org.clojure/java.jdbc "0.6.1"]
                 [mysql/mysql-connector-java "5.1.25"]]
  :aot [sql-wrapper.core]
  :target-path "target/"
  :compile-path "target/classes/"
  :native-path "target/bin/"
  :uberjar-name "database-deploy.jar"
  :main sql-wrapper.core)
