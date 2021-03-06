
# Require

THREE = require \three-js

{ Sprite } = require \./sprite.ls

settings = require \../materials.ls


# Internal

quality-boost-factor = qbf = 4


# Drawing functions

draw-text = (w, h, { text, size = 12, align = \center, offset = 0 }) ->
  @font          = "#{size * qbf}px Blender Pro"
  @text-baseline = \middle
  @text-align    = align
  if align is \center
    @fill-text (String text).to-upper-case!, w/2, h/2
  else
    @fill-text (String text).to-upper-case!, offset * qbf, h/2

draw-border = (w, h, z) ->
  @line-width   = z * qbf
  @stroke-style = \white
  @stroke-rect 0, 0, w, h

draw-underline = (w, h, z) ->
  @line-width   = z * qbf
  @stroke-style = \white
  @move-to 0, h
  @line-to w, h
  @stroke!

draw-bullet = (w, h, z) ->
  m = (h - z * 4) / 2
  @fill-style = \white
  @fill-rect 0, m, z * qbf, z * qbf


# Greebles

DynamicTexture = (w, h, λ, color = settings.colors.main) ->

  # First, provide a canvas to draw the texture on with requested aspect
  drawing-canvas = document.create-element \canvas
  drawing-canvas.width  = w * qbf
  drawing-canvas.height = h * qbf
  ctx = drawing-canvas.get-context \2d
  ctx.fill-style = \white

  # Supply the canvas to the callback, transparently multiplied by quality boost
  λ.call ctx, w * qbf, h * qbf

  # Once the drawing is complete, write this image to a new canvas with perfect
  # PO2 dimensions, so it can be automatically mipmapped
  mipmap-canvas = document.create-element \canvas
  mipmap-canvas.width  = 1024
  mipmap-canvas.height = 1024
  mipmap-ctx = mipmap-canvas.get-context \2d
  mipmap-ctx.draw-image drawing-canvas, 0, 0, 1024, 1024

  # Now sprite the mipmappable texture, with the plane at the original size.
  Sprite mipmap-canvas, color, w, h

Text = (text, w, h, { align, size, color }) ->
  if color?
    DynamicTexture w, h, ((w, h) ->
      draw-text.call this, w, h, { text, size, align }), color
  else
    DynamicTexture w, h, (w, h) ->
      draw-text.call this, w, h, { text, size, align }

Label = (text, w, h) ->
  DynamicTexture w, h, (w, h) ->
    draw-text.call      this, w, h, { text, size: 12, align: \left, offset: 16 }
    draw-underline.call this, w, h, 2
    draw-bullet.call    this, w, h, 9

TrimLabel = (text, w, h) ->
  group = new THREE.Object3D

  main = DynamicTexture w, h, (w, h) ->
    draw-text.call      this, w, h, { text, size: 12, align: \left, offset: 16 }

  trim = DynamicTexture w, h, ((w, h) -> draw-bullet.call this, w, h, 9), settings.colors.trim

  [ main, trim ].map group~add
  return group

# Export

module.exports = { Text, Label, TrimLabel, DynamicTexture }

