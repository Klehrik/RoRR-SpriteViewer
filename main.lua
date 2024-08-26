-- Sprite Viewer v1.0.0
-- Klehrik

log.info("Successfully loaded ".._ENV["!guid"]..".")

local show = true

local sprite = "sCommandoShoot1"
local img_count = ""
local width = ""
local height = ""
local origin_x = ""
local origin_y = ""



-- ========== Main ==========

gui.add_imgui(function()
    if ImGui.Begin("Sprite Viewer") then
        local value, pressed = ImGui.Checkbox("Show sprite", show)
        if pressed then show = value end

        ImGui.Text("\nSprite:")
        sprite = ImGui.InputText("", sprite, 100)

        ImGui.Text("\nImage count:  "..img_count)
        ImGui.Text("Width (px):  "..width)
        ImGui.Text("Height (px):  "..height)
        ImGui.Text("Origin X:  "..origin_x)
        ImGui.Text("Origin Y:  "..origin_y)
    end
end)


gm.post_code_execute(function(self, other, code, result, flags)
    if code.name:match("oInit_Draw_7") and show then
        local spr = gm.constants[sprite]
        if spr then
            img_count = gm.sprite_get_number(spr)
            width = gm.sprite_get_width(spr)
            height = gm.sprite_get_height(spr)
            origin_x = gm.sprite_get_xoffset(spr)
            origin_y = gm.sprite_get_yoffset(spr)

            local spacing_h = width + 8
            local spacing_v = height + 24
            local c = 16777215

            local start_x = 40
            local start_y = 60
            local x = 0
            local y = 0

            for img = 0, img_count - 1 do
                gm.draw_set_alpha(0.25)
                gm.draw_rectangle_color(start_x + x - 1, start_y + y - 1, start_x + x + width + 1, start_y + y + height + 1, c, c, c, c, true)
                gm.draw_text(start_x + x + 1, start_y + y - 18, img, c, c, c, c, 1.0)
                gm.draw_set_alpha(1)
                gm.draw_sprite(spr, img, start_x + x + origin_x, start_y + y + origin_y)

                x = x + spacing_h
                if start_x + x + spacing_h > gm.camera_get_view_width(gm.camera_get_active()) then
                    x = 0
                    y = y + spacing_v
                end
            end

        else img_count, width, height, origin_x, origin_y = "", "", "", "", ""
        end
    end
end)