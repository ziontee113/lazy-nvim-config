;; extends

((identifier) @function (#any-of? @function "describe"))

((identifier) @annotation (#any-of? @annotation "before_each" "after_each"))
((identifier) @character.special (#any-of? @character.special "it"))
((identifier) @symbol (#eq? @symbol "works"))
