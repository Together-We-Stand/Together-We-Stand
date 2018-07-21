library TestUnit
	globals
		private constant real X = 0.00
		private constant real Y = 0.00
	endglobals
	
	function CreateTestUnit takes integer unitId, integer spellId, integer spellLvl returns unit
		local unit u = CreateUnit(Player(0), unitId, X, Y, 0)
		call UnitAddAbility(u, spellId)
		call SetUnitAbilityLevel(u, spellId, spellLvl)
		return u
	endfunction
endlibrary
