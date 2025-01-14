quest servis begin
	state start begin
		function TeleportIsAvailable()
			local maps = { 5, 7, 25, 27, 28, 45, 47, 79, 81, 112, 113, 206, 211, 212, 213, 351, 352 } 
			for i = 1, table.getn(maps) do
				if pc.get_map_index() == maps[i] then
					return true -- false
				end
			end
			if pc.in_dungeon() == true then
				return true -- false
			end
			return true
		end
			
		when 70058.use begin

			if not servis.TeleportIsAvailable() then
				say_title("Iþýnlanma Yüzüðü: ")
				say("")
				say_reward("Bu haritada bir noktaya ýþýnlanamazsýn.")
				return
			end

			say_size(350,350)
			say_title("Iþýnlanma Yüzüðü: ")
			say("")
			say_reward("Nereye ýþýnlanmak istiyorsun ?")
			local s = select("Þehirler","Orman Bölgeleri ","Örümcek Zindaný ","Sürgün Maðarasý ","Diðer Bölgeler ","Vazgeç ")
			if s == 1 then
				local ss = select("Yongan (Lv.1~25)","Jayang Bölgesi (Lv.26~37)","Joan (Lv.1~25)","Bokjung Bölgesi (Lv.26~37)","Pyungmoo (Lv.1~25)","Bakra Bölgesi (Lv.26~37)","Vazgeç ")
				local warps_1 = { 465800,958200, 357400,877200, 52100,154100, 137100,239400, 965000,273900, 867800,240700 }	
				if ss == 7 then
					return
				end
				pc.warp(warps_1[2*ss-1],warps_1[2*ss])
			elseif s == 2 then
				local sss = select("Hayalet Orman (Lv.65~70)","Kýzýl Orman Giriþ (Lv.74~77)","Kýzýl Orman Sonu (Lv.74~77)","Vazgeç ")
				local warps_2 = { 288700,5700, 1119900,70800, 1118100,8600 }
				if sss == 4 then
					return
				end
				pc.warp(warps_2[2*sss-1],warps_2[2*sss])
			elseif s == 3 then
				local zindan = select("Örümcek Zindaný 1 (Lv.57~69)","Örümcek Zindaný 2 (Lv.65~78)","Vazgeç ")
				local warps_3 = { 59800,497300, 704100,521900 }
				if zindan == 2 then
					if pc.get_level() < 50 then
						syschat("Seviyen 50 olmadan bu haritaya giriþ yapamazsýn.")
						return
					end
				end
				if zindan == 3 then
					return
				end
				pc.warp(warps_3[2*zindan-1],warps_3[2*zindan])
			elseif s == 4 then
				pc.warp(284400,810700)
			elseif s == 5 then
				local ssss = select("Seungryong Vadisi (Lv.34~49)","Sohan Daðý (Lv.49~65)","Yongbi Çölü (Lv.37~50)","Doyyumhwan (Lv.69~72)","Devler Diyarý (Lv.65-70)","Þeytan Kulesi (Lv.57~69)","Þeytan Katakombu (Lv.75~80)","Kýrmýzý Ejderha Kalesi (Lv.90~120)","Nemerenin Gözetleme Kulesi (Lv.90~120)","Vazgeç ")
				local warps_4 = { 336000,755600, 436400,215600, 296800,547400, 600800,687400, 829900,763300, 590500,110500, 591100,99300,600600,707200,432792,165998}
				if ssss == 10 then
					return
				end
				pc.warp(warps_4[2*ssss-1],warps_4[2*ssss])
			end
		end
	end
end