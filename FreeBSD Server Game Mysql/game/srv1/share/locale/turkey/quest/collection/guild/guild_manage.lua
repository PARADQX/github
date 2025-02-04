quest guild_building begin
        state start begin
                when guild_man1.chat."GM: Yeniden kaydolma.." or guild_man2.chat."GM: Yeniden kaydolma.." or guild_man3.chat."GM: Yeniden kaydolma.."
                        with pc.is_gm() begin

                        say_title("K�y Gardiyan�: ")
                        say("")
                        say("Bilgi istiyor isen, kay�tl� ")
                        say("ki�inin ismini yaz.")
                        say("")
                        local u_name = input()
                        local u_vid=find_pc_by_name(u_name)

                        if u_vid==0 then
                                say_title("Bu isim kay�tl� de�il.")
                                say(u_name)
                                return
                        end

                        local old_vid = pc.select(u_vid)
                        u_withdrawTime=pc.getqf("new_withdraw_time")
                        u_withdrawTime=pc.getqf("new_withdraw_time")
                        pc.select(old_vid)

                        withdrawDelay=game.get_event_flag("guild_withdraw_delay")
                        disbandDelay=game.get_event_flag("guild_disband_delay")

                        say_title("K�y Gardiyan�:")
                        say("")
                        say("En erken kat�l�� tarihini")
                        say("kontrol et.")

                        if u_withdrawTime>0 then
                                say("Ge�en zaman: "..time_to_str(u_withdrawTime))
                                say("(Kalan zaman: ".. withdrawDelay.." G�n)")
                                say("")
                        end

                        if u_disbandTime>0 then
                                say("kay�p olmaya zaman: "..time_to_str(u_disbandTime))
                                say("(kalan zaman: ".. disbandDelay.." G�n)")
                                say("")
                        end

                        local retryTime1 = u_withdrawTime + withdrawDelay*86400
                        local retryTime2 = u_withdrawTime + disbandDelay*86400

                        local retryTime = 0
                        if retryTime1 > retryTime2 then
                                retryTime = retryTime1
                        else
                                retryTime = retryTime2
                        end

                        local curTime = get_time()
                        if curTime < retryTime then
                                say("Yeni denemeye, kalan zaman: "..time_to_str(retryTime))
                                say("(Kalan zaman: "..((retryTime-curTime)/3600).." saat)")
                                say("")

                                if is_test_server() then
                                        local s=select("Hemen intibak et", "Kapat")
                                        if s==1 then
                                                local old_vid = pc.select(u_vid)
                                                local curTime=get_time()
                                                pc.setqf("new_withdraw_time", curTime-withdrawDelay*86400)
                                                pc.setqf("new_withdraw_time", curTime-disbandDelay*86400)
                                                pc.select(old_vid)
                                        end
                                end
                        else
                                say("Hemen kay�t m�mk�n.");
                                say("")
                        end
                end
                when    guild_man1.chat."GM: Loncan�n imkanlar�na bak" or
                        guild_man2.chat."GM: Loncan�n imkanlar�na bak" or
                        guild_man3.chat."GM: Loncan�n imkanlar�na bak"
                        with pc.is_gm() begin
						setskin(NOWINDOW)
                        test_chat("pc.has_guild: "..bool_to_str(pc.has_guild()))
                        test_chat("pc.is_guildmaster: "..bool_to_str(pc.isguildmaster()))
                        test_chat("pc.empire: "..pc.empire)
                        test_chat("npc.empire: "..npc.empire)
                end
                when guild_man1.chat."Loncadan ��k " or
                        guild_man2.chat."Loncadan ��k " or
                        guild_man3.chat."Loncadan ��k "
                        with pc.hasguild() and not pc.isguildmaster() begin
                        -- ??
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Oldu�un loncadan ��kmak m� istiyorsun?")
                        say("Herhalde orada arkada� bulamad�n. ")
                        say("Nas�l istersen.")
                        say("Loncadan �ikmak istedi�ine emin misin?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s==1 then
                                say_title("K�y Gardiyan�:")
                                say("")
                                say("Tamam.")
                                say("Art�k loncada de�ilsin. ")
                                say("")
                                say("")
                                pc.remove_from_guild()
                                pc.setqf("new_withdraw_time",get_global_time())
                        end
                end

                when guild_man1.chat."Loncay� kapat" or
                        guild_man2.chat."Loncay� kapat" or
                        guild_man3.chat."Loncay� kapat"
                        with pc.hasguild() and pc.isguildmaster() begin
                        -- ??
						if guild.get_any_war() == true then
							say_title("K�y Gardiyan�: ")
							say("")
							say("Lonca sava�ta iken loncan� kapatamazs�n.")
							setskin(NOWINDOW)
							return
						end
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Ne?")
                        say("[DELAY value;150]        [/DELAY]")
                        say("O kadar zahmetle bu loncay� ")
                        say("kurdum ve sen onu �imdi kapatmak m� istiyorsun?")
                        say("B�t�n hat�ralar�n ve dostlar�n ")
                        say("sonsuza kadar kaybolacak!")
                        say("")
                        say("Loncay� kapatmak istedi�ine emin misin?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s==1 then
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Tamam.")
                        say("Loncay� kapatt�m.")
                        say("")
                        say("")
                        pc.destroy_guild()
                        pc.setqf("new_disband_time", get_global_time())
                        pc.setqf("new_withdraw_time", get_global_time())
                        end
                end

                when guild_man1.chat."Yeni Lonca kur" or
                        guild_man2.chat."Yeni Lonca kur" or
                        guild_man3.chat."Yeni Lonca kur"
						with (not pc.hasguild() and npc.empire == pc.empire) begin
                        --------------------------------------------------------------
                        local level_limit;
                        local guild_create_item

                        level_limit = 40
                        guild_create_item = false
                        -----------------------------------------------------------------------

                        if pc.hasguild() then
							setskin(NOWINDOW)
                            return
                        end
                        if game.get_event_flag("guild_withdraw_delay")*86400 >
                                get_global_time() - pc.getqf("new_withdraw_time") then
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Bir loncadan ayr�ld�ktan sonra, 1 g�n beklemelisin.")
                        return
                        end

                        if game.get_event_flag("guild_disband_delay")*86400 >
                                get_global_time() - pc.getqf("new_withdraw_time") then
                        say_title("K�y Gardiyan�: ")
                        say("")
                        say("Bir lonca kapatt�n! ")
                        say("Bu y�zden 1 g�n beklemelisin.")
                        say_reward("Loncay� kapatt���n tarih: ")
						say_reward(string.format("%s", time_to_str(pc.getqf("new_withdraw_time"))))
                        return
                        end
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Yeni lonca kurmak istiyor musun?")
                        say("")
                        say("Yeni lonca kurmak i�in ")
                        say("en az 40.seviyede olmal�s�n. Ayr�ca")
                        say(" 200.000 Yang gerekiyor.")
                        say("")
                        say("Lonca kurmak istiyor musun?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s == 2 then
                                return
                        end

                        if pc.level >= 40 then
                        if pc.gold >= 200000 then

				if not guild_create_item or pc.countitem(guild_create_item)>0 then
                                        game.request_make_guild()
                                end

                                else
                                say_title("K�y Gardiyan�:")
                                say("")
                                say("Yeterli Yang yok!")
                                say("")
                                return
                                end
                        else
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Seviyen lonca kurmak i�in ")
                        say("yeterli de�il. ")

                        end
                end
        end
end
