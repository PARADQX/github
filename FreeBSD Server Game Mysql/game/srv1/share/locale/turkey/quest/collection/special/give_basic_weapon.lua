quest basic_weapon begin
	state start begin
		when login with pc.getqf("basic_weapon") == 0 begin
			notice_all(string.format("Metin2'ye hoþgeldin %s ! ",pc.get_name()))
			pc.setqf("basic_weapon",1)
		end
	end
end