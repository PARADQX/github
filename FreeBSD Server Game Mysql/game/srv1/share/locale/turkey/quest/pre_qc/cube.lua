quest cube begin
    state start begin
        when 20018.chat."Þifalý Bitkiler Bilimi " or 20017.chat."Þifalý Bitkiler Bilimi " or 20022.chat."Gizli tarif" begin
			say_title(npc.get_name())
			say("")
			say("Merhaba, nasýlsýn?")
			say("Seni güclendirecek yada iyileþtirecek ")
			say("iksirler yaratmakla ilgileniyormusun?")
			say("Bir þifacý olarak kendimi ")
			say("iksirlere adadým.")
			say("Birçok tarif buldum. ")
			say("Onlarý denemek istermisin? ")
			say("")
			wait()
			setskin(NOWINDOW)
			command("cube open")
		end
		-- when 20383.chat."Arýndýrma Penceresini Aç " or 20421.chat."Arýndýrma Penceresini Aç " or 20470.chat."Arýndýrma Penceresini Aç " or 20406.chat."Arýndýrma Penceresini Aç " or 20015.chat."Arýndýrma Penceresini Aç " begin
		-- 	say_title(npc.get_name())
		-- 	say("")
		-- 	say("Senin için birþeyleri yükseltebilirim... ")
		-- 	say("Eþyayý sürükle ve yeni bir eþya oluþtur. ")
        --     say("")
        --     wait()
        --     setskin(NOWINDOW)
        --     command("cube open")
		-- end
	end
end
