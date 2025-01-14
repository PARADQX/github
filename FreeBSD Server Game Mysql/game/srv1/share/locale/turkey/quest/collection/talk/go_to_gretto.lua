quest go_to_gretto begin
	state start begin
		when login or levelup with pc.level >0 begin
			set_state(zone_enter)
		end
	end
		
	state zone_enter begin
		when 20093.chat."Giriş izni iste" begin
			if pc.level < 75 then
				say_title("Koe-Pung:")
				say("")
				---                                                   l
				say("75. seviyenin altında oldugun için")
				say("seni buz zindanına ışınlayamam..")
				return
			end
			say_title("Koe-Pung:")
			say("Dur! Ben Ejderha Mezhebinden Koe-Pung,")
			say("bu kapının bekçisiyim. Sadece mezhebin")
			say("iznini alırsan geçebilirsin!")
			wait()
			say_title(""..mob_name(20093).."")
			say("Ejderha Tanrı seni seçti.")
			say("O her zaman seni izliyor olmalı!")	
			wait()
			pc.warp(10000, 1213200)
		end
	end

end

