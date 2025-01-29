return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			"*", -- Aktiviert für alle Dateitypen
		}, {
			names = false, -- Deaktiviert Farbnamen
			css = false, -- Deaktiviert die Überschreibung durch die Alias-Option
			RRGGBB = true, -- Aktiviert Hex-Codes wie #RRGGBB
			RRGGBBAA = true, -- Aktiviert Hex-Codes mit Alpha-Werten
			rgb_fn = true, -- Aktiviert rgb() Funktionen
			hsl_fn = true, -- Aktiviert hsl() Funktionen
			mode = "background", -- Setzt den Anzeigemodus
		})
	end,
}
