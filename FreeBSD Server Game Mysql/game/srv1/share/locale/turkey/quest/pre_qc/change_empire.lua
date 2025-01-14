quest change_empire begin
	state start begin
		when 71054.use begin
			say_title("Krall�klar�n �zi ")

			if get_time() < pc.getqf("next_use_time") then
				say("3 g�n boyunca imparatorluk de�istiremezsin.")
				say("")
				return
			end

			if change_empire.move_pc() == true then
				pc.setqf("next_use_time", get_time() + 86400 * 3)
			end
		end



		function move_pc()
			if pc.is_engaged() then
				say("Ni�anl� oldu�un i�in")
				say("imparatorluk de�i�tiremezsin.")
				say("")
				return false
			end

			if pc.is_married() then
				say("Evli oldu�un i�in")
				say("imparatorluk de�i�tiremezsin.")
				say("")
				return false
			end

			if pc.is_polymorphed() then
				say("D�n��m�� �ekilde imparatorluk de�i�tiremezsin.")
				say("")
				return false
			end

			if pc.has_guild() then
				say("Bir loncaya �yeyken")
				say("imparatorluk de�i�tiremezsin.")
				say("")
				return false
			end
			if pc.money < 500000 then
				say("Yeterli Alt�n yok.")
				say("500 bin Alt�n'a ihtiyac�n var.")
				say("")
				return false
			end
			say("Ka�mak istedi�in �lkeyi se�.")
			local s = select("Shinsoo Krall���(K�rm�z� Irk) ", "Chunjo �lkesi(Sar� Irk)", "Jinno �mparatorlu�u(Mavi Irk)", "Vazge� ")
			if 4==s then
				return false 
			end
			say_title("Krall�klar�n �zi ")
			say("")
			say("Ger�ekten imparatorluk de�i�tirmek istiyor musun?")
			say("Arkada�lar�n� b�rak�p gidiyorsun yani?")
			say("")
			local a = select("Evet", "Hay�r")
			if 2== a then
				return false
			end

			local ret = pc.change_empire(s)
			local oldempire = pc.get_empire()
			if ret == 999 then
				say_title("Krall�klar�n �zi ")
				say("Ba�ar�yla imparatorluk de�i�ti.")
				say("Oyundan ��k ve tekrar gir.")
				say("")
				pc.change_gold(-500000)
				pc.remove_item(71054,1)
				char_log(0, "CHANGE_EMPIRE",string.format("%d -> %d", oldempire, s))

			
				return  true
			else
				if ret == 1 then
					say_title("Krall�klar�n �zi ")
					say("Zaten bu imparatorluktas�n.")
					say("L�tfen ba�ka bir imparatorluk se�.")
					say("")
					say("")
				elseif ret == 2 then
					say_title("Krall�klar�n �zi ")
					say("De�i�im �u an m�mk�n de�il.")
					say("Son zamanlarda yap�lan lonca de�i�imi y�z�nden ")
					say("imparatorluk de�i�tiremezsin.")
					say("")
				elseif ret == 3 then
					say_title("Krall�klar�n �zi ")
					say("Degi�im �u an m�mk�n de�il.")
					say("Son zamanlardaki evlilik durumundaki de�i�iklik y�z�nden")
					say("imparatorluk de�i�tiremezsin.")
				elseif ret == 4 then
					say_title("Krall�klar�n �zi ")
					say("De�i�im �u an m�mk�n de�il.")
					say("Bir gruba �ye oldu�un i�in")
					say("�mparatorluk de�i�tiremezsin.")
				end
			end
			return false
		end

	end
end
