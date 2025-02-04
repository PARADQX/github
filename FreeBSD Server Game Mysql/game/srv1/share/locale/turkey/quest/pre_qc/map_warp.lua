quest map_warp begin
    state start begin
        when 9012.chat."Seyehat etmek istiyorum. "  begin
            say_title("I��nlay�c�: ")
            say("Buras� g�zel bir k�y. Burada[ENTER]bir �ey mi oluyor?[ENTER]Seni ���nlayabilece�im �zel bir yer var.[ENTER]nas�lsa, �eytani g��ler tekrar y�kselip[ENTER]g��lenmeye ba�l�yorlar. Uzak ve zaman kaosa[ENTER]d���yor. Bu nedenle geri d�nmek her zaman m�mk�n[ENTER]olmayabilir. Oraya ���nlanmak istiyor[ENTER]musun?")

            local main_set =  select("Evet ", "Hay�r ")
            if main_set == 2 then
                return
            end

            if pc.get_level() <= 10 then
                say_title("I��nlay�c�: ")
                say("Hmm.. Senin seviyende zaman ve boslukta[ENTER]yolculuk yapmak m�mk�n de�il.[ENTER]10. seviyeye ula�t���nda yolculuk[ENTER]yapabilirsin. ")
                return
            end

            local map = pc.get_map_index()
            local empire = pc.get_empire()
            local level = pc.get_level()
            local cost = math.floor(level / 5) * 1000

            if cost < 1000 then
                cost = 1000
            end

            say_title("I��nlay�c�: ")
            say("Nereye ���nlanmak istiyorsun? ")
            say_reward(string.format("�cret: %s Yang. ", cost))
            
            if map == 1 or map == 3 or map == 21 or map == 23 or map == 41 or map == 43 then

                local guild_map_names = {
                    "Jungrang �ehri",
                    "Waryong �ehri",
                    "Imha �ehri ",
                }

                guild_map_name = guild_map_names[empire]
                local added_guild_map = {
                    "Miryang �ehri",
                    "Songpa �ehri",
                    "Daeyami �ehri",
                }

                added_guild_map = added_guild_map[empire]
                local sub_set = 0
                if level < 60 then -- weniger als 60 : die Privatkarte von Gild, das Drache, die Wuste Youngbi, Der Eisberg im Westen
                    if pc.count_item(30180) == 0 then
                        sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ",added_guild_map, "Kapat ")
                        if sub_set == 6 then -- Schliessen
                            return
                        end
                    else 
                        sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ", added_guild_map, "Ejderha Tanr� T�ls�m� kullan. ", "Kapat ")
                        if sub_set == 7 then -- Schliessen
                            return
                        end
                    end
                    

                else -- mehr als 61 :die Wuste Youngbi, der Eisberg im Westen, das Schlangengeistturm, die Pfirsischblumendorf
                    if pc.count_item(30180) == 0 then
                        sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ",added_guild_map, "Daha fazla ")
                    else
                        sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ",added_guild_map, "Ejderha Tanr� T�ls�m� kullan. ","Daha fazla ")
                    end
                    if sub_set == 6 and pc.count_item(30180) == 0 then 
                        sub_set = sub_set +1
                    end
                    if sub_set == 7 then -- weiter
                        say_title("I��nlay�c�: ")
                        say("Baz� yerlere seni ancak seviyen 60 oldu�unda[ENTER]���nlayabilirim.")
                        say_reward(string.format("�cret: %s Yang. ", cost))
                        sub_set =  select("Doyyumhwan ", "�eytan Kulesi ", "Hayalet Orman ","K�z�l Orman ", "Geri d�n ", "Kapat ") + 6 
                        if sub_set == 12 then 
                            return
                        end
                        if sub_set == 11 then -- vorher
                            say_title("I��nlay�c�: ")
                            say("Acele et ve nereye ���nlanmak[ENTER]istedi�ini s�yle.")
                            ---                                                   l
                            say_reward(string.format("�cret: %s Yang. ", cost))
                            say("E�er bu �ekilde devam edersen fiyat�[ENTER]artt�raca��m. Yoruldum. ")
                  if pc.count_item(30180) == 0 then
                  sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ",added_guild_map, "Daha fazla ")
                else
                sub_set =  select(guild_map_name, "Seungryong Vadisi ", "Yongbi ��l� ", "Sohan Da�� ", added_guild_map, "Ejderha Tanr� T�ls�m� kullan. ","Daha fazla ")
                  end

                            if sub_set == 6 and pc.count_item(30180) == 0 then 
                                sub_set = sub_set +1
                            end
                            if sub_set == 7 then -- weiter
                                say_title("I��nlay�c�: ")
                                say("Daha �nce s�yledi�im gibi: Buras� �zel bir[ENTER]b�lge ve seni ancak seviyen 60 oldu�unda[ENTER]���nlayabilirim. Hala ���nlanmak istiyor musun?[ENTER]E�er istemiyorsan, pencereyi kapat. Sen ne[ENTER]ne yap�yorsun? Bu ���nlanma al��t�rmas� de�il...")
                                say_reward(string.format("�cret: %s Yang. ", cost))
                                sub_set =  select("Doyyumhwan ", "�eytan Kulesi ",  "Hayalet Orman ", "K�z�l Orman ", "Kapat ") + 6
                                if sub_set == 11 then 
                                    return
                                end
                            end
                        end
                    end
                end

                if pc.gold < cost then
                    say_title("I��nlay�c�: ")
                    say("Seni �cretsizde ���nlayabilirim,[ENTER]fakat b�y�k bir ailem var.[ENTER]Onlara bakabilmek i�in[ENTER]para kazanmal�y�m. ")
                    say_reward(string.format("�cret: %s Yang. ", cost))
                    return
                end

                pc.changegold(-cost)

                local warp = {
                    -- <<1>> guild_map
                    {
                        { 135600, 4300 },
                        { 179500, 1000 },
                        { 271800, 13000 },
                    },
                    -- <<2>> 64 Seungryong
                    {
                        { 402100, 673900 },
                        { 270400, 739900 },
                        { 321300, 808000 },
                    },
                    -- <<3>> 63 Yonbi-Desert
                    {
                        { 217800, 627200 },
                        { 221900, 502700 },
                        { 344000, 502500 },
                    },
                    -- <<4>> 61 Sohan Mountain
                    {
                        { 434200, 290600 },
                        { 375200, 174900 },
                        { 491800, 173600 },
                    },
                    {--added_guild_map
                    {204800, 204800},
                    {614400, 384000},
                    {256000, 819200},
                            
                   } ,
                    -- <<5>> 64 Seungryong - Heavens Cave entrance
                    {
                        { 287800, 799700 },
                        { 275500, 800000 },
                        { 277000, 788000 },
                    },
                    -- <<6>> 62 metin2_map_n_flame_01
                    {
                        { 599400, 756300 },
                        { 597800, 622200 },
                        { 730700, 689800 },
                    },
                    -- <<7>> devil_tower
                    {
                        { 590500, 110500 },
                        { 590500, 110500 },
                        { 590500, 110500 },
                    },

                    -- <<8>> wood 
                    {
                        { 290000, 5600 },
                        { 290000, 5600 },
                        { 290000, 5600 },
                    },
                    -- <<9>> red wood 
                    {
                        { 1119500, 70200 },
                        { 1119500, 70200 },
                        { 1119500, 70200 },
                    },
                }
                test_chat(warp[sub_set][empire][1]..warp[sub_set][empire][2])
                say_title("I��nlay�c�: ")
                say("Dikkat! �imdi ���nlanacaks�n.[ENTER]Tehlikeli bir yere gideceksin[ENTER]Kendine dikkat et... �yi �anslar! ")
                
                
                wait()
                if pc.is_dead() == false then
                    pc.warp(warp[sub_set][empire][1], warp[sub_set][empire][2])
                else
                    return
                end


            else -- Falls jedes Dorf nicht 1,2 Dorf ist,ist es moglich zum 1,2 Dorf im Reich zuruckzukehren
                local sub_set2 = 4
                if pc.count_item(30180) == 0 then
                    if empire==1 then
                        sub_set2 =  select("Yongan ", "Yayang  �ehri", "Kapat ")
                    elseif  empire ==2 then
                        sub_set2 =  select("Joan ", "Bokjung B�lgesi", "Kapat ")
                    elseif  empire ==3 then
                        sub_set2 =  select("Pyungmoo ", "Bakra B�lgesi", "Kapat ")
                    end
                    if sub_set2 == 3 then
                        return
                    end
                else
                    if empire==1 then
                        sub_set2 =  select("Yongan ", "Yayang  �ehri", "Ejderha Tanr� T�ls�m� kullan. ", "Kapat ")
                    elseif  empire ==2 then
                        sub_set2 =  select("Joan ", "Bokjung B�lgesi", "Ejderha Tanr� T�ls�m� kullan. ", "Kapat ")
                    elseif  empire ==3 then
                        sub_set2 =  select("Pyungmoo ", "Bakra B�lgesi", "Ejderha Tanr� T�ls�m� kullan. ", "Kapat ")
                    end
                    if sub_set2 == 4 then
                        return
                    end
                end
                if sub_set2 != 4 then
                    if pc.gold < cost then
                        say_title("I��nlay�c�: ")
                        say("Seni �cretsizde ���nlayabilirim,[ENTER]fakat b�y�k bir ailem var.[ENTER]Onlara bakabilmek i�in[ENTER]para kazanmal�y�m. ")
                        say_reward(string.format("�cret: %s Yang. ", cost))
                    else
                        if sub_set2 == 1 then
                            say_title("I��nlay�c�: ")
                            say("Seni hemen ���nlayaca��m. ")
                            wait()
                            if  pc.is_dead() == false then
                                if empire == 1 then
                                    pc.warp(474300,954800)
                                elseif empire == 2 then
                                    pc.warp(63800,166400)
                                elseif empire == 3 then
                                    pc.warp(959900,269200)
                                end
                            else
                                return
                            end
                        elseif sub_set2 == 2 then
                            say_title("I��nlay�c�: ")
                            say("G�r��mek �zere! ")
                            wait()
                            if pc.is_dead() == false then
                                if empire == 1 then
                                    pc.warp(353100,882900)
                                elseif empire == 2 then
                                    pc.warp(145500,240000)
                                elseif empire == 3 then
                                    pc.warp(863900,246000)
                                end
                            else
                                return
                            end
                        elseif sub_set2 == 3 then
                            say_title("I��nlay�c�: ")
                            say("G�r��mek �zere! ")
                            wait()
                            if pc.is_dead() == false then
                                if empire == 1 then
                                    pc.warp(287800, 799700)
                                elseif empire == 2 then
                                    pc.warp(275500, 800000)
                                elseif empire == 3 then
                                    pc.warp(277000, 788000)
                                end
                            else
                                return
                            end
                        end
                        pc.changegold(-cost)
                    end
                end
            end
        end -- end_of_chat
		when 9012.chat."Karanl�k Ejderha Kayas� " with pc.get_level() >= 90 and pc.get_map_index() < 207 begin
		local level_cost = pc.get_level() - 85
		local cost = level_cost*10000
		say("I��nlay�c� ")
		say("K�sa bir s�re �nce gizemli bir ada ke�fedildi. Ad� ")
		say("Karanl�k Ejderha Kayas� konuldu. Orada hayatta")
		say("kalmak i�in yeterli tecr�beye sahip olmak gerekir.")
		say("O y�zden sadece seviye 90 �zeri oyuncular� ")
		say("g�t�rece�im. Yolculu�a kat�lmaya haz�r m�s�n?")
		local s = select("Evet","Hay�r")
			if s == 2 then
			return
			else
				if pc.get_gold() < cost then
				say_title("I��nlay�c� ")
				say("Yeterli yang yok.")
				return
				else
				say("I��nlay�c� ")
				say("Adaya ula��m sadece gemilerle sa�lan�yor -")
				say("yolculuksa uzun ve yorucu. Seviyen ne kadar")
				say("y�ksekse nakliye o kadar zorludur. Bu nedenle")
				say("senden daha y�ksek bir �cret talep etmek zorunday�m.")
				say("")
				say_reward("Yolculuk i�in "..cost.." Yang harcan�r.")
				local ss = select("Evet","Hay�r")
					if ss == 2 then
					return
					else
					pc.change_gold(-cost)
					pc.warp(1104300,1788500)			
					end
				end
			end
		end
    end -- end_of_state
end -- end_of_quest
