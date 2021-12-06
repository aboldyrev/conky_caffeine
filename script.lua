require 'cairo'

font = "Roboto"
font_slant = CAIRO_FONT_SLANT_NORMAL
font_face = CAIRO_FONT_WEIGHT_NORMAL

colors = {
    white  = 0xffffff,
    orange = 0xff7e00,
    blue   = 0x0069ff,
    green  = 0x00ff00,
    pink   = 0xff45b2,
}

previousEpoch = os.time()
gpu_level = 0

function conky_main()
    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create (
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    
    cr = cairo_create(cs)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end