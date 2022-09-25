(use ../utils)

(assert (= (key-by (fn [] false) @{}) nil)
        (error "key_by should return nil"))

(assert (= (key-by (fn [key val] (= val "hei")) @{:test "hei"}) :test)
        (error "should return :test"))

(assert (= (key-by (fn [key val] (= key :test)) @{:test "hei"}) :test)
        (error "should return :test"))

(assert (= (key-by (fn [key val] (= key :test)) @{:hei "hei"}) nil)
        (error "should return nil"))

(assert (= (key-by-value @{:test "hei"} "hei") :test)
        (error "should return :test"))

(assert (deep= (flip map [1 2 3] (fn [i] (+ 1 i))) @[2 3 4])
        (error "Should return @[2 3 4]"))

(assert (deep= (map-indexed (fn [i v] [i v] ) ["a" "b"]) @[(tuple 0 "a") (tuple 1 "b")])
        (error "Should return @[(tuple 0 a) (tuple 1 b)]"))

(assert (= (end [1 2 3]) 3)
        (error "Should return 3"))

(assert (= (end []) nil)
        (error "Should return nil"))

(assert (= (end [] :error) :error)
        (error "Should return :error"))
