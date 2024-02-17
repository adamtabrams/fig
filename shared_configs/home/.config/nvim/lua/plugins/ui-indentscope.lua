-- stylua: ignore
-- if true then return {} end

return {
  "echasnovski/mini.indentscope",
  opts = {
    draw = {
      delay = 10,
      animation = require("mini.indentscope").gen_animation.none(),
    },
  },
}
