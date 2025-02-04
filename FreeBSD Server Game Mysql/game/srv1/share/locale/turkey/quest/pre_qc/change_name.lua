quest change_name begin
	state start begin
		when 71055.use begin
		say_title("�sim izi ")
			if pc.is_married() then
				say("Evli oldu�un i�in isim de�i�tiremezsin.")
				say("")
				return
			end

			if pc.is_polymorphed() then
				say("D�n��m�� halde isim de�i�tiremezsin.")
				say("")
				return
			end

			if pc.has_guild() then
				say("Bir loncan�n �yesiyken isim de�i�tiremezsin.")
				say("")
				return
			end

			if party.is_party() then
				say("�sim de�i�tirmek i�in gruptan ��kmal�s�n.")
				say("")
				return
			end

			if pc.get_level() < 50 then
				say("�sim de�i�tirmek i�in yeterli seviyede de�ilsin.")
				say("50. seviyeye ula�t���nda tekrar dene.")
				return
			end

			if get_time() < pc.getqf("next_time") then
				say("Hen�z isim de�i�tiremezsin.")
				say("")
				say_reward("Tekrar isim de�i�tirebilece�in tarih:")
				say_reward(string.format("%s", time_to_str(pc.getqf("next_time"))))

				if is_test_server() == true then
					say("Test serverdayken bu s�re s�f�rlan�r.")
					say("")
				else
					return
				end
			end

			say("Yeni ismini a�a��daki kutuya yaz.") 

			local name = pc.name
			local str = input()

			local ret = pc.change_name(str)
			
			if string.len(str) > 12 then
			say_title("�sim izi")
			say("�sim �ok uzun.")
			return
			end
			
			if ret == 0 then
			say_title("�sim izi")
				say("�sim ge�erli de�il. Ba�ka bir isim")
				say("yaz. T�rk�e veya �zel karakter kullanma.")
				say("L�tfen oyuna tekrar giri� yap.")

				char_log(0, "CHANGE_NAME", "HAVE NOT RE-LOGIN")
			elseif ret == 1 then
			say_title("�sim izi")
				say("Bir sorun var.")
				say("Daha sonra tekrar dene.")
				say("")
				
				char_log(0, "CHANGE_NAME", "ITEM USE PROBLEM")
			elseif ret == 2 then
			say_title("�sim izi")
				say("�sim ge�erli de�il. Ba�ka bir isim")
				say("yaz. T�rk�e veya �zel karakter kullanma.")
				say("")

				char_log(0, "CHANGE_NAME", "CAN NOT USE NAME")
			elseif ret == 3 then
			say_title("�sim izi")
				say("Bu ismi ba�ka bir oyuncu kullan�yor.")
				say("Kendine ba�ka bir isim bul.")
				say("")

				char_log(0, "CHANGE_NAME", "ALREADY USING NAME")
			elseif ret == 4 then
			say_title("�sim izi")
				say("�sim de�i�tirme ger�ekle�ti.")
				say("Oyuna tekrar giri� yap.")
				say("")

				pc.remove_item("71055",1)

				pc.setqf("next_time", get_time() + time_hour_to_sec(1*1))

				char_log(0, "CHANGE_NAME", "SUCCESS: from "..name.." to "..str)
			else
				say("Bir hata olu�tu.")

				char_log(0, "CHANGE_NAME", "UNKNOWN NAME")
			end
		end
	end
end

