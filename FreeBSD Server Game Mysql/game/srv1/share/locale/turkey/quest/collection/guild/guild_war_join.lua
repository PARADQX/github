quest guild_war_join begin
    state start begin
        when letter begin
            local e = guild.get_any_war()

            if e != 0 and pc.get_war_map() == 0 then
                setskin(NOWINDOW)
                send_letter("Giri� izni iste")
            end
        end

        when button begin
            local e = guild.get_any_war()

            if e == 0 then
                say("Sava� bitti bile.")
            else
                say(guild.name(e).." loncas� ile sen de sava�mak istiyor musun?")

                local s = select("Evet","Hay�r")

                if s == 1 then
                    guild.war_enter(e)
                else
                    setskin(NOWINDOW)
                    send_letter("Giri� izni iste")
                end
            end
        end
    end
end
