
# Require

THREE = require \three-js

{ Sprite } = require \./sprite.ls

# Drawing functions

draw-text = (w, h, { text, size = 12, align = \center, offset = 0 }) ->
  @font          = "#{size * 4}px Blender Pro"
  @text-baseline = \middle
  @text-align    = align
  if align is \center
    @fill-text (String text).to-upper-case!, w/2, h/2
  else
    @fill-text (String text).to-upper-case!, offset * 4, h/2

draw-border = (w, h, z) ->
  @line-width   = z * 4
  @stroke-style = \white
  @stroke-rect 0, 0, w, h

draw-underline = (w, h, z) ->
  @line-width   = z * 4
  @stroke-style = \white
  @move-to 0, h
  @line-to w, h
  @stroke!

draw-bullet = (w, h, z) ->
  m = (h - z * 4) / 2
  @fill-style = \white
  @fill-rect 0, m, z * 4, z * 4


# Greebles

DynamicTexture = (w, h, λ) ->
  c = document.create-element \canvas
  c.width  = w * 4
  c.height = h * 4
  x = c.get-context \2d
  x.fill-style = \white
  λ.call x, w * 4, h * 4
  Sprite c, w, h

Text = (text, w, h, { align, size }) ->
  DynamicTexture w, h, (w, h) ->
    draw-text.call this, w, h, { text, size, align }
    #draw-border.call this, w, h, 0.5

Label = (text, w, h) ->
  DynamicTexture w, h, (w, h) ->
    draw-text.call      this, w, h, { text, size: 12, align: \left, offset: 20 }
    draw-underline.call this, w, h, 2
    draw-bullet.call    this, w, h, 9


# Export

module.exports = { Text, Label, DynamicTexture }

