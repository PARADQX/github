quest ride_ticket_change begin
	state start begin
		when 20349.chat."Sertifikay� binek ile de�i�tir "  begin 
			say_title(mob_name (20349))
			say("Sertifikan� bir binek ile mi de�i�tirmek[ENTER]istiyorsun? Bakal�m hangisini getirdin. �ok[ENTER]say�da sertifikaya sahipsen, �n�m�zdeki ad�mlarda[ENTER]aralar�ndan bir tane se�ebilirsin. ")
			wait()
			local items = {pc.get_sig_items(10032)}
			local ticket = nil
			if table.getn (items) > 1 then
				for i, v in ipairs (items) do
					item.select (v)
					say_title(mob_name(20349))
					say ("Bu bine�i almak istiyorsun, �yle mi?[ENTER]�yleyse 'Evet' ile onayla ve bir sonraki ad�mda onun[ENTER]i�in bir bonus se�. Sonraki sertifikaya gitmek i�in 'Hay�r' se�. ")
					say_item_vnum (item.vnum)
					say ("Emin misin? ")
					local s = select ("Evet ", "Hay�r ", "�ptal ")
					if s == 3 then
						return
					end
					if s == 1 then 
						ticket = v
						break
					end
				end
			else
				ticket = items [1]
			end
			if ticket == nil then
				say_title (mob_name (20349))
				say ("Demek sertifikan� de�i�tirmek istemiyorsun.[ENTER]Haz�r oldu�unda tekrar gel. ")
				return 
			end
			say_title (mob_name (20349))
			say("�imdi de bir bonus se�. ")
			item.select (ticket)
			local s = select ("Canavarlara kar�� g�� ", "Tecr�be (EXP) ","Hayat Puan� (HP) ", "Savunma (SAV) ", "Sald�r� de�eri (SD) ", "Hay�r, �imdi de�il. ")
			if s == 6 then
				say_title (mob_name (20349))
				say ("Hen�z karar veremiyorsun galiba. Haz�r oldu�unda[ENTER]tekrar gel. ")
				return
			end
			local summon_item = item.get_value (s-1)
			say_title (mob_name (20349))
			say("�yi bir se�im. Ba�ar�lar! ")
			if pc.give_item2 (summon_item) == 0 then
				say_title (mob_name (20349))
				say ("Hm, bir �ey yanl�� gitmi� gibi g�z�k�yor.")
				return
			end
			item.remove()
		end
	end
end
