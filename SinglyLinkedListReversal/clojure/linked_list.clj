(ns linked-list)

(deftype Node [^:volatile-mutable car ^:volatile-mutable cdr])

(def node (Node. "boo" nil))

(def linked-list ( Node. "foo" (Node. "bar" (Node. "baz" nil))))

(-> node
    .car
    println)
