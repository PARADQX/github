quest dragon_soul_shop begin
	state start begin
		when 20001.chat." Marketi aç " with ds.is_qualified() begin
			setskin(NOWINDOW)
			npc.open_shop(51)
		end
	end
end
