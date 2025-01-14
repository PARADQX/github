quest pet_system begin
	state start begin

		function get_pet_info(itemVnum)
			if pet_system.pet_info_map==nil then
				pet_system.pet_info_map = {
				-- [ITEM VNUM] MOB_VNUM, DEFAULT NAME
					[53001] = {34001, " - Pet", 0}, --			no bonus	120giorni
					[53002] = {34002, " - Pet", 0}, --		 	+1500 HP e +15% danno, Permette di droppare le calze se lo si tiene al proprio fianco mentre si uccidono mob.				20giorni
					[53003] = {34003, " - Pet", 0}, --			no bonus	120giorni
					[53005] = {34004, " - Pet", 1}, --			+1500 HP e +15% di danno, se il PG si trova dal 2° piano della Torre dei Demoni in su, o se si trova all'interno delle Catacombe del Diavolo	30giorni
					[53006] = {34009, " - Pet", 1}, --			+1500 HP e +15% di danno, se il PG si trova dal 2° piano della Torre dei Demoni in su, o se si trova all'interno delle Catacombe del Diavolo	200giorni(non implementato sull offy ma c'è)
					[53007] = {34010, " - Pet", 0}, --			+1500 HP e +15% danno, Permette di droppare le calze se lo si tiene al proprio fianco mentre si uccidono mob.				20giorni
					[53008] = {34011, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53009] = {34012, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53010] = {34008, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53011] = {34007, " - Pet", 0}, --			+1500 HP e +15% di danno	120giorni
					[53012] = {34005, " - Pet", 0}, --			+15% danno e +1500 HP		30giorni
					[53013] = {34006, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53014] = {34013, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53015] = {34014, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53016] = {34015, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53017] = {34016, " - Pet", 0}, --			+30% di Exp e +15% di Danno	120giorni
					[53018] = {34020, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53019] = {34019, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53020] = {34017, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53021] = {34018, " - Pet", 0}, --			+1500 HP, +15% Forte contro Mostri	30giorni
					[53022] = {34021, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53023] = {34022, " - Pet", 0}, --			+1500 HP e +15% di danno	30giorni
					[53024] = {34023, " - Pet", 0}, --			+1500 HP, +5% Trafiggente, +5% Resistenza Abilità		7giorni
					[53025] = {34024, " - Pet", 0}, --			+1500 HP e +5% Critico, +10% Resistenza ai Danni Medi	7giorni
					-- [53026] = { ???, "Pepsi", 0}, -- ???
					[53218] = {34023, " - Pet", 0}, --			+1500 HP, +5% Trafiggente, +5% Resistenza Abilità		30giorni
					[53219] = {34023, " - Pet", 0}, --			+1500 HP, +5% Trafiggente, +5% Resistenza Abilità		120giorni
					[53220] = {34024, " - Pet", 0}, --			+1500 HP e +5% Critico, +10% Resistenza ai Danni Medi	30giorni
					[53221] = {34024, " - Pet", 0}, --			+1500 HP e +5% Critico, +10% Resistenza ai Danni Medi	120giorni
					[53222] = {34026, " - Pet", 0}, --			1500 HP, +15% danno		30giorni
					[53223] = {34027, " - Pet", 0}, --			+1500 HP, +15% danno	30giorni
					[53224] = {34028, " - Pet", 0}, --			+1500 HP, +15% danno	30giorni
					[53225] = {34029, " - Pet", 0}, --			+15% danno, +5% danno critico, +15% danno magico	30giorni
					[53226] = {34030, " - Pet", 0}, --			+1500 HP +5% Trafiggenti	120giorni
					[53227] = {34031, " - Pet", 0}, --			+1500 HP +5% Critico		120giorni
					[53228] = {34033, " - Pet", 0}, --			+1500 HP, +15% danno fisico e danno magico	30giorni
					[53229] = {34032, " - Pet", 0}, --			+5% colpi critici, +15% danno fisico e danno magico	30giorni
					[53230] = {34034, " - Pet", 0}, --			+5% colpi trafiggenti e +1500 HP	30giorni
					[53231] = {34035, " - Pet", 0}, --			+5% colpi critici e +1500 HP	30giorni
					[53232] = {34039, " - Pet", 0}, --			+1500 HP e +5% Trafiggenti		30giorni
					[53233] = {34055, " - Pet", 0}, --			+5% colpi critici e +1500 HP	30giorni	Il pet raccoglierà automaticamente tutti gli oggetti a terra nelle sue vicinanze.
					[53234] = {34056, " - Pet", 0}, --			+5% colpi trafiggenti e +1500 HP	30giorni	Il pet raccoglierà automaticamente tutti gli oggetti a terra nelle sue vicinanze.
					[53235] = {34057, " - Pet", 0}, --			+5% colpi critici e +1500 HP	1giorno Il pet raccoglierà automaticamente tutti gli oggetti a terra nelle sue vicinanze.
					[53236] = {34060, " - Pet", 0}, --			+15% Forte contro Mostri e +1500 HP		30giorni	Se insieme al Pet evocato si sta utilizzando un Icona Amuleto del Cioccolato.pngAmuleto del Cioccolato, si otterrà 50% Exp Bonus.
					[53237] = {34061, " - Pet", 0}, --			+5% colpi critici e +1500 HP			30giorni	Se insieme al Pet evocato si sta utilizzando un Icona Amuleto del Cioccolato.pngAmuleto del Cioccolato, si otterrà 50% Exp Bonus.
					[53238] = {34058, " - Pet", 0}, --			no bonus								1giorno		Se insieme al Pet evocato si sta utilizzando un Icona Amuleto del Cioccolato.pngAmuleto del Cioccolato, si otterrà 20% Exp Bonus.
					[53239] = {34059, " - Pet", 0}, --			no bonus								1giorno		Se insieme al Pet evocato si sta utilizzando un Icona Amuleto del Cioccolato.pngAmuleto del Cioccolato, si otterrà 20% Exp Bonus.
					[53240] = {34063, " - Pet", 0}, --			+5% colpi critici e +1500 HP		30giorni
					[53241] = {34062, " - Pet", 0}, --			+1500 HP, +15% Forte contro Mostri	30giorni
					[53256] = {34066, " - Pet", 0}, --			no bonus							3600giorni
					[53242] = {34066, " - Pet", 0}, --			+5% colpi critici e +1500 HP		30giorni		Il pet raccoglierà automaticamente tutti gli oggetti a terra nelle sue vicinanze.
					[53243] = {34066, " - Pet", 0}, --			20% exp								30giorni
					[53244] = {34067, " - Pet", 0}, --			+5% colpi critici e +15% di danno		30giorni		Equipaggiandolo con un'armatura Vampiro+ , un elmo Vampiro+ e il Leccalecca garantisce un bonus di +20% Exp e + 5% Danni Medi e Abilità
					[53245] = {34068, " - Pet", 0}, --			+5% colpi trafiggenti e +15% di danno	30giorni		Equipaggiandolo con un'armatura Vampiro+ , un elmo Vampiro+ e il Leccalecca garantisce un bonus di +20% Exp e + 5% Danni Medi e Abilità
					[53246] = {34069, " - Pet", 0}, --			no bonus								1giorno			Equipaggiandolo con un'armatura ed elmo Vampiro garantisce un bonus di +20% Exp
					[53247] = {34070, " - Pet", 0}, --			+5% colpi critici e +5% Possibilità di Svenimento		30giorni	Equipaggiandolo con il Vestito da festa+, il Copricapo+ o il Basco+ si riceveranno, in aggiunta, due bonus del set. Aggiungendo un Anello della Felicità, si riceverà un altro bonus del set.
					[53248] = {34071, " - Pet", 0}, --			+5% colpi trafiggenti e +5% Possibilità di Svenimento	1giorno		Equipaggiandolo con il Vestito da festa+, il Copricapo+ o il Basco+ si riceveranno, in aggiunta, due bonus del set. Aggiungendo un Anello della Felicità, si riceverà un altro bonus del set.
					[53249] = {34072, " - Pet", 0}, --			no bonus												30giorni	Equipaggiandolo con il vestito da festa, il copricapo o il basco si riceveranno, in aggiunta, un bonus del set. Aggiungendo un Anello della Felicità, si riceverà un altro bonus del set.
					[53250] = {34084, " - Pet", 0}, --			Donnie ???
					[53251] = {34085, " - Pet", 0}, --			Frank ???
					-- GF specials
					[38200] = {34006, " - Pet", 0}, --			Sigillo Rufus ???
					[38201] = {34006, " - Pet", 0}, --			Sigillo Rufus ???
					-- New Pets Added By Tunga
					[53253] = {34086, " - Pet", 0},
					[53254] = {34087, " - Pet", 0},
					[53255] = {34088, " - Pet", 0},
					[53256] = {34066, " - Pet", 0},
					[53257] = {34089, " - Pet", 0},
					[53258] = {34090, " - Pet", 0},
					[53259] = {34091, " - Pet", 0},
					[53260] = {34092, " - Pet", 0},
					[53261] = {34093, " - Pet", 0},
					[53262] = {34094, " - Pet", 0},
					[53263] = {34095, " - Pet", 0},
					[53264] = {34096, " - Pet", 0},
					[53265] = {34097, " - Pet", 0},
					[53266] = {34098, " - Pet", 0},
					[53267] = {34099, " - Pet", 0},
					[53268] = {34100, " - Pet", 0},
					[53269] = {34101, " - Pet", 0},
					[53270] = {34102, " - Pet", 0},
					[53271] = {34103, " - Pet", 0},
					[53272] = {34104, " - Pet", 0},
					[53273] = {34105, " - Pet", 0},
					[53274] = {34106, " - Pet", 0},
					[53275] = {34107, " - Pet", 0},
					[53276] = {34108, " - Pet", 0},
					[53277] = {34109, " - Pet", 0},
					[53278] = {34110, " - Pet", 0},
					[53279] = {34111, " - Pet", 0},
					[53280] = {34112, " - Pet", 0},
					[53281] = {34113, " - Pet", 0},
					[53282] = {34114, " - Pet", 0},
					[53283] = {34115, " - Pet", 0},
					[53284] = {34116, " - Pet", 0},
					[53285] = {34117, " - Pet", 0},
					[53286] = {34118, " - Pet", 0},
					[53287] = {34119, " - Pet", 0},
					[53288] = {34120, " - Pet", 0},
					[53289] = {34121, " - Pet", 0},
					[53290] = {34124, " - Pet", 0},
					[53291] = {34125, " - Pet", 0},
					[53292] = {34126, " - Pet", 0},
					[53293] = {34127, " - Pet", 0},
					[53294] = {34128, " - Pet", 0},
					[53295] = {34129, " - Pet", 0},
					[53296] = {34130, " - Pet", 0},
					[53297] = {34131, " - Pet", 0},
					[53298] = {34130, " - Pet", 0},
					[53299] = {34133, " - Pet", 0},
					[53300] = {34134, " - Pet", 0},
					--

				}
			end
			return pet_system.pet_info_map[itemVnum]
		end

		function get_spawn_effect_file(idx)
			if pet_system.effect_table==nil then
				pet_system.effect_table = {
					[0] = nil,
					[1] = "d:\\\\ymir work\\\\effect\\\\etc\\\\appear_die\\\\npc2_appear.mse",
				}
			end
			return pet_system.effect_table[idx]
		end

		when
			-- 38200~38201
			38200.use or 38201.use or
			-- 53001~53026 (no 53003, 53026)
			53001.use or 53002.use or 53003.use or 53005.use or 53006.use or 53007.use or 53008.use or 53009.use or
			53010.use or 53011.use or 53012.use or 53013.use or 53014.use or 53015.use or 53016.use or 53017.use or 53018.use or 53019.use or
			53020.use or 53021.use or 53022.use or 53023.use or 53024.use or 53025.use or -- 53004.use or 53026.use or
			-- 53218~53251
			53218.use or 53219.use or
			53220.use or 53221.use or 53222.use or 53223.use or 53224.use or 53225.use or 53226.use or 53227.use or 53228.use or 53229.use or
			53230.use or 53231.use or 53232.use or 53233.use or 53234.use or 53235.use or 53236.use or 53237.use or 53238.use or 53239.use or
			53240.use or 53241.use or 53242.use or 53243.use or 53244.use or 53245.use or 53246.use or 53247.use or 53248.use or 53249.use or
			53250.use or 53251.use or
			-- 53256
			53256.use or
			-- new pets added by Tunga
			53253.use or 53254.use or 53255.use or 53256.use or 53257.use or 53258.use or 53259.use or
			53260.use or 53261.use or 53262.use or 53263.use or 53264.use or 53265.use or 53266.use or 53267.use or 53268.use or 53269.use or
			53270.use or 53271.use or 53272.use or 53273.use or 53274.use or 53275.use or 53276.use or 53277.use or 53278.use or 53279.use or
			53280.use or 53281.use or 53282.use or 53283.use or 53284.use or 53285.use or 53286.use or 53287.use or 53288.use or 53289.use or
			53290.use or 53291.use or 53292.use or 53293.use or 53294.use or 53295.use or 53296.use or 53297.use or 53298.use or 53299.use or
			53300.use
			--
		begin
			local pet_info = pet_system.get_pet_info(item.vnum)

			if null ~= pet_info then

				local mobVnum = pet_info[1]
				local petName = pet_info[2]
				local spawn_effect_file_name = pet_system.get_spawn_effect_file(pet_info[3])

				if true == pet.is_summon(mobVnum) then
					if spawn_effect_file_name ~= nil then
						pet.spawn_effect(mobVnum, spawn_effect_file_name)
					end
					pet.unsummon(mobVnum)
				else
					if pet.count_summoned() < 1 then
						pet.summon(mobVnum, petName, false)
					else
						syschat("�u anda petini �a��ramazs�n. ")
					end
					if spawn_effect_file_name ~= nil then
						pet.spawn_effect(mobVnum, spawn_effect_file_name)
					end
				end -- if pet.is_summon
			end -- if null ~= pet_info

		end -- when
	end -- state
end -- quest
