doctype
html
  head
    title (= "luoshu grids")
    meta (:charset utf-8)
    link (:rel stylesheet) (:href css/style.css)
    link
      :rel "shortcut icon"
      :type image/png
      :href png/luoshu.png
    script (:defer) (:src build/build.js)
  body
    canvas#canvas