quest training_grandmaster_skill begin
	state start begin
		when 50513.use begin
			say_title("Grand Masterlar�n Beceri E�itimi ")
			if pc.get_skill_group() == 0 then
				---                                                   l
				say("Hen�z beceri e�itimine ba�lamad�n.")
  
				return
			end

			local result = training_grandmaster_skill.BuildGrandMasterSkillList(pc.get_job(), pc.get_skill_group())

			local vnum_list = result[1]
			local name_list = result[2]

			if table.getn(vnum_list) == 0 then
				---                                                   l
				say("Grand Master seviyesinde olan ")
				say("bir becerin yok.")
				return
			end
			---                                                   l
			say("Grand Master seviyesini art�rmak istedi�in")
			say("beceriyi se�. ")
			local menu_list = {}
			table.foreach(name_list, function(i, name) table.insert(menu_list, name) end)
			table.insert(menu_list, "Kapat")

			local s=select_table(menu_list)
			if table.getn(menu_list) == s then
				return
			end

			local skill_name=name_list[s]
			local skill_vnum=vnum_list[s]
			local skill_level = pc.get_skill_level(skill_vnum)
			local cur_alignment = pc.get_real_alignment()
			local need_alignment = 1000+500*(skill_level-30)

			--test_chat("G�ncel Derece:" .. cur_alignment.."! ") 
			--test_chat("Gereken Derece: " .. need_alignment .."! ")  
			
			--syschat("G�ncel Derece:" .. cur_alignment.."! ") 
			--syschat("Gereken Derece: " .. need_alignment .."! ")  

			local title = string.format("%s grand master beceri e�itimi ",skill_name)

			say_title(string.format("%s",title))
			say("")
			say("Grand Master becerisi i�in s�ralama puan� ") 
			say("harcan�r.Yani s�ralama puan�n negatif de�ere ") 
			say("d��ebilir. ")  
			say("")

			if cur_alignment<-19000+need_alignment then
				say_reward("E�itim i�in yeterli derece yok.")
				say("")
				return
			end

			if cur_alignment<0 then
				say_reward(string.format("Gereken s�ralama puan�: %d -> %d ", need_alignment, need_alignment*2))
				say_reward("Bu da demek oluyor ki, grand master becerilerini ") 
				say_reward("y�kseltmek i�in s�ralama puan� pozitif olan bir ")
				say_reward("ki�iye g�re iki kat puan harcamal�s�n.")
				need_alignment=need_alignment*2
				elseif cur_alignment<need_alignment then
			say_reward(string.format("Gereken s�ralama puan�: %d " , need_alignment )) 
			say_reward("E�er �imdi e�itim al�rsan, s�ralama puan�n ") 
			say_reward("negatif de�ere d��ecek. ") 
			else
				say_reward(string.format("Gereken s�ralama puan�:: %d ", need_alignment ))
			end
			say("")

			local s=select("Devam", "Vazge� ")
			if s==2 then
				return
			end

			if pc.count_item(50513) < 1 then
				say("Hey!")
				say("Ruh ta��n olmadan nas�l ��reneceksin ")
				say("becerilerini.")
				say("")
				say_reward("Git ve ruh ta�� bul.")
				return
			end

			if need_alignment>0 then
				if pc.count_item(50513) < 1 then
						say("Hey!")
						say("Ruh ta��n olmadan nas�l ��reneceksin ")
						say("becerilerini.")
						say("")
						say_reward("Git ve ruh ta�� bul.")
				else
					if pc.learn_grand_master_skill(skill_vnum) then
						pc.change_alignment(-need_alignment)
						say_title(string.format("%sBa�ar�l� ", title))
						if 40 == pc.get_skill_level(skill_vnum) then
							say(string.format("%s Perfect Master oldu.", skill_name))
						else
							say(string.format("%s ula�t��� seviye %d." , skill_name , skill_level - 30+1+1)) 
						end
						say("")
						say_reward("Seviyeni ba�ar� ile y�kselttin!") 
						say_reward(string.format("%d s�ralama puan� kulland�n.", need_alignment))
						say("")
					else
						say_title(string.format("%s [ENTER]Ba�ar�s�z ", title))
						say("Becerini geli�tiremedin.")
						say("")
						say_reward("Bir miktar s�ralama puan� kaybettin[ENTER] ve bir Ruh Ta�� kulland�n.")
						say("")
						pc.change_alignment(-number(need_alignment/3, need_alignment/2))
					end
				end
			end
			pc.remove_item(50513,1)
		end
		
		function BuildGrandMasterSkillList(job, group)
			GRAND_MASTER_SKILL_LEVEL = 30
			PERFECT_MASTER_SKILL_LEVEL = 40
			local skill_list = special.active_skill_list[job+1][group]
			local ret_vnum_list = {}
			local ret_name_list = {}
			table.foreach(skill_list,
			function(i, skill_vnum)
				local skill_level = pc.get_skill_level(skill_vnum)
				if skill_level >= GRAND_MASTER_SKILL_LEVEL and skill_level < PERFECT_MASTER_SKILL_LEVEL then
					table.insert(ret_vnum_list, skill_vnum)
					local name=locale.GM_SKILL_NAME_DICT[skill_vnum]
					if name == nil then name=skill_vnum end
					table.insert(ret_name_list, name)
				end
			end)
			return {ret_vnum_list, ret_name_list}
		end
	end
end
