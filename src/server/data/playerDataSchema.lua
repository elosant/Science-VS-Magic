return {
	schema = function()
		return {
			FinancialData = {
				MainCurrency = 0,
				PremiumCurrency = 0,

				MainCurrencyGained = 0,
				MainCurrencySpent = 0,

				PremiumCurrencyGained = 0,
				PremiumCurrencySpent = 0
			},

			KillData = {
				Kills = 0,
				Deaths = 0,
				KDRatio = 0
			},

			SessionsData = {
				SessionCount = 0, -- Number of times player has joined the server.
				LastJoin = 0,
				TimePlayed = 0,
			},

			PurchaseData = {
				RobuxSpent = 0,
				PurchaseLog = {}
			}
		}
	end,

	replicatedFields = {
		FinancialData = true,
		KillData = true,
		PurchaseData = true
	}
}