--!strict  											: Full checking
--!nonstrict										: Only annotated types checked
--!nocheck											: No type checking 

-- 1. Primitive type annotations for variables
local playerName: string = "Alex"
local score: number = 100

-- 2. Optional types (can be the type OR nil)
local nickname: string? = nil

-- 3. Type alias for structured table (like an object or struct)
type PlayerData = {
	Name: string,
	Score: number,
	IsAlive: boolean,
	Nickname: string?,
}

-- 4. Function that accepts and returns a structured type
function CreatePlayer(name: string, score: number): PlayerData
	return {
		Name = name,
		Score = score,
		IsAlive = true,
		Nickname = nil,
	}
end

-- 5. Type assertion using `::` (useful for empty tables or instances)
local player = {} :: PlayerData
player.Name = "Jordan"
player.Score = 75
player.IsAlive = false

-- 6. Function with multiple return types
function GetPosition(): (number, number, number)
	return 0, 10, 5
end

local x, y, z = GetPosition()

-- 7. Function type alias
type DamageFunction = (target: PlayerData, amount: number) -> ()

-- 8. Function with explicit parameter and return type annotations
local function ApplyDamage(target: PlayerData, amount: number): ()
	target.Score -= amount
	if target.Score <= 0 then
		target.IsAlive = false
	end
end

-- 9. Using function type as a variable
local damage: DamageFunction = ApplyDamage

-- 10. Using a typed instance with assertion
local part = Instance.new("Part") :: Part
part.Position = Vector3.new(x, y, z)

-- 11. Using method syntax (`:`) with `self` type
type BankAccount = {
	Balance: number,
	Deposit: (self: BankAccount, amount: number) -> (),
	Withdraw: (self: BankAccount, amount: number) -> (),
}

local AccountImpl = {} :: BankAccount
AccountImpl.Balance = 0
function AccountImpl:Deposit(amount: number)
	self.Balance += amount
end
function AccountImpl:Withdraw(amount: number)
	self.Balance -= amount
end
