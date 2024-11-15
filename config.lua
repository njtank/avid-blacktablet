Config = {}

-- Name of the cryptocurrency used for transactions
Config.CryptoName = "doge"

-- Starting number of gang members
Config.StartingGangMembers = 8

-- Settings for gang reputation 
Config.GangReputation = {
    DefaultPoints = 0,
    TierThresholds = {
        Neutral = 0,
        Respected = 100,
        Feared = 200,
        Legendary = 300
    },
    Rewards = {
        Respected = "Access to minor black market benefits.",
        Feared = "Unlock advanced black market items.",
        Legendary = "Exclusive headquarters upgrades."
    },
    Penalties = {
        Arrest = -5,
        TerritoryLost = -10
    },
    Bonuses = {
        TerritoryCapture = 10,
        HeistCompletion = 20
    }
}
