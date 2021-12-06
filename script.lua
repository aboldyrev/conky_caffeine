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

    draw_time(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function draw_time(cr)
    draw_text(cr, 64, colors.white, 786, 568, conky_parse('${time %H:%M}'))
    draw_text(cr, 32, colors.white, 972, 568, conky_parse('${time %S}'))
    draw_text(cr, 16, colors.white, 835, 588, conky_parse('${time %a, %e %b %Y}'))

    -- Закомментировать или удалить, если не нужно
    draw_text(cr, 16, colors.white, 860, 618, conky_parse('${tztime Europe/Moscow %H:%M:%S}'))

    draw_text(cr, 32, colors.white, 1130, 568, conky_parse('$uptime_short'))
end

function draw_text(cr, font_size, color, x, y, text)
    red, green, blue, alpha = rgb_to_r_g_b(color, 1)
    cairo_select_font_face (cr, font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, x, y)
    cairo_show_text (cr, text)
    cairo_stroke (cr)
end

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end