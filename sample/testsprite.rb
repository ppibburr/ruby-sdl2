require "sdl2"

SDL2.init(SDL2::INIT_EVERYTHING)

p SDL2::Display.displays
SDL2::Display.displays.each{|display| p display.modes }
print "curent mode: "; p SDL2::Display.displays.first.current_mode
print "desktop mode: "; p SDL2::Display.displays.first.desktop_mode

window = SDL2::Window.create("testsprite",
                             SDL2::Window::OP_CENTERED, SDL2::Window::OP_CENTERED,
                             640, 480, 0)
puts "window id: #{window.window_id}"
p SDL2::Window.all_windows
p window.display_mode
renderer = window.create_renderer(-1, 0)
texture = renderer.load_texture("icon.bmp")

rect = SDL2::Rect.new(48, 128, 32, 32)
renderer.copy(texture, nil, rect)
renderer.copy_ex(texture, nil, SDL2::Rect[128, 256, 48, 48], 45, nil,
                 SDL2::Renderer::FLIP_NONE)
texture.blend_mode = SDL2::BLENDMODE_ADD
renderer.copy(texture, nil, SDL2::Rect[128, 294, 48, 48])

texture.blend_mode = SDL2::BLENDMODE_NONE
texture.color_mod = [128, 128, 255]
renderer.copy(texture, nil, SDL2::Rect[300, 420, 48, 48])
loop do
  while ev = SDL2::Event.poll
    p ev
    case ev
    when SDL2::Event::KeyDown
      if ev.scancode == SDL2::Key::Scan::ESCAPE
        exit
      else
        p ev.scancode
      end
    end
  end

  renderer.present
  sleep 0.1
end

