quest costume_voucher begin
	state start begin
		when 30334.use begin
			say_title("Baþlýk Fiþi: ")
			say("")
			say_reward("Baþlýk almak için cinsiyet seç.")
			local s = select("Erkek","Kadýn","Vazgeç ")
			local item = 45002
			if s == 1 then
				if pc.count_item(30334) < 1 then
					say_title("Baþlýk Fiþi: ")
					say("")
					say("Üzgünüm envanterinde baþlýk fiþi bulamadým.")
					return
				end
				local prob = number(1,8)
				if prob == 1 then
					item = 45002
				elseif prob == 2 then
					item = 45003
				elseif prob == 3 then
					item = 45005
				elseif prob == 4 then
					item = 45007
				elseif prob == 5 then
					item = 45009
				elseif prob == 6 then
					item = 45055
				elseif prob == 7 then
					item = 45057
				elseif prob == 8 then
					item = 45061
				end
				say_title("Baþlýk Fiþi: ")
				say("")
				say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
				say_item_vnum(item)
				pc.give_item2(item, 1)
				pc.remove_item(30334, 1)
			elseif s == 2 then
				if pc.count_item(30334) < 1 then
					say_title("Baþlýk Fiþi: ")
					say("")
					say("Üzgünüm envanterinde baþlýk fiþi bulamadým.")
					return
				end
				local prob = number(1,8)
				if prob == 1 then
					item = 45001
				elseif prob == 2 then
					item = 45004
				elseif prob == 3 then
					item = 45006
				elseif prob == 4 then
					item = 45008
				elseif prob == 5 then
					item = 45010
				elseif prob == 6 then
					item = 45056
				elseif prob == 7 then
					item = 45058
				elseif prob == 8 then
					item = 45062
				end
				say_title("Baþlýk Fiþi: ")
				say("")
				say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
				say_item_vnum(item)
				pc.give_item2(item, 1)
				pc.remove_item(30334, 1)
			elseif s == 3 then
				return
			end
		end
		when 30338.use begin
			say_title("Baþlýk Fiþi: ")
			say("")
			say_reward("Baþlýk almak için cinsiyet seç.")
			local s = select("Erkek","Kadýn","Vazgeç ")
			local item = 45001
			if s == 1 then
				if pc.count_item(30338) < 1 then
					say_title("Baþlýk Fiþi: ")
					say("")
					say("Üzgünüm envanterinde baþlýk fiþi bulamadým.")
					return
				end
				local prob = number(1,8)
				if prob == 1 then
					item = 45011
				elseif prob == 2 then
					item = 45013
				elseif prob == 3 then
					item = 45015
				elseif prob == 4 then
					item = 45017
				elseif prob == 6 then
					item = 45065
				elseif prob == 7 then
					item = 45067
				elseif prob == 8 then
					item = 45069
				elseif prob == 9 then
					item = 45073
				end
				say_title("Baþlýk Fiþi: ")
				say("")
				say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
				say_item_vnum(item)
				pc.give_item2(item, 1)
				pc.remove_item(30338, 1)
			elseif s == 2 then
				if pc.count_item(30338) < 1 then
					say_title("Baþlýk Fiþi: ")
					say("")
					say("Üzgünüm envanterinde baþlýk fiþi bulamadým.")
					return
				end
				local prob = number(1,8)
				if prob == 1 then
					item = 45012
				elseif prob == 2 then
					item = 45014
				elseif prob == 3 then
					item = 45016
				elseif prob == 4 then
					item = 45018
				elseif prob == 5 then
					item = 45066
				elseif prob == 6 then
					item = 45068
				elseif prob == 7 then
					item = 45070
				elseif prob == 8 then
					item = 45074
				end
				say_title("Baþlýk Fiþi: ")
				say("")
				say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
				say_item_vnum(item)
				pc.give_item2(item, 1)
				pc.remove_item(30338, 1)
			elseif s == 3 then
			end
		end
		when 30335.use begin
			say_title("Silah Görünüm Fiþi: ")
			say("")
			say_reward("Silah kostümü almak için tip seç.")
			local s = select("Tek El","Býçak","Yay","Çift El","Çan","Yelpaze","Vazgeç ")
			local item = 40130
			if pc.count_item(30335) < 1 then
				say_title("Baþlýk Fiþi: ")
				say("")
				say("Üzgünüm envanterinde silah görünüm fiþi bulamadým.")
				return
			end
			say_size(300,375)
			item = 0
			if s == 1 then
				item = 40101
			elseif s == 2 then
				item = 40102
			elseif s == 3 then
				item = 40103
			elseif s == 4 then
				item = 40104
			elseif s == 5 then
				item = 40105
			elseif s == 6 then
				item = 40106
			elseif s == 7 then
				return
			end
			if item == 0 then
				return
			end
			say_title("Silah Görünüm Fiþi: ")
			say("")
			say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
			say_item_vnum(item)
			pc.give_item2(item, 1)
			pc.remove_item(30335, 1)
		end
		when 30339.use begin
			say_title("Silah Görünüm Fiþi: ")
			say("")
			say_reward("Silah kostümü almak için tip seç.")
			local s = select("Tek El","Býçak","Yay","Çift El","Çan","Yelpaze","Vazgeç ")
			local item = 40151
			if pc.count_item(30339) < 1 then
				say_title("Baþlýk Fiþi: ")
				say("")
				say("Üzgünüm envanterinde silah görünüm fiþi bulamadým.")
				return
			end
			item = 0
			if s == 1 then
				item = 40108
			elseif s == 2 then
				item = 40109
			elseif s == 3 then
				item = 40110
			elseif s == 4 then
				item = 40111
			elseif s == 5 then
				item = 40112
			elseif s == 6 then
				item = 40113
			elseif s == 7 then
				return
			end
			if item == 0 then
				return
			end
			say_title("Silah Görünüm Fiþi: ")
			say("")
			say_reward(string.format("Tebrikler , %s isimli nesneden 1 adet kazandýn.", item_name(item)))
			say_item_vnum(item)
			pc.give_item2(item, 1)
			pc.remove_item(30339, 1)
		end
	end
end