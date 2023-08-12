-- If your mod loads after this one you can override the values below.
-- If you add your own WeaponGroup or Combataction it is also possible to add a suppression value for it.
-- WeaponGroup: SuppressionValue
-- CombatAction:  .BaseSuppressionValue

SUPPWeaponSuppressionValues = {
    Unarmed = 0,
    MeleeWeapon = 0,
    AssaultRifle = 5,
    SubmachineGun = 4,
    Pistol = 4,
    Revolver = 4,
    Shotgun = 6,
    SniperRifle = 14,
    MachineGun = 5,
    HeavyWeapon = 0,
    Grenade = 0,
    ConcussiveGrenade = 5,
    HE_Grenade = 32,
    FragGrenade = 30,
    ShapedCharge = 30,
    Super_HE_Grenade = 34,
    PipeBomb = 28,
    ProximityC4 = 29,
    RemoteC4 = 29,
    TimedC4 = 29,
    ProximityPETN = 34,
    RemotePETN = 34,
    TimedPETN = 34,
    ProximityTNT = 28,
    RemoteTNT = 28,
    TimedTNT = 28,
    Warhead_Frag = 36,
    MortarShell_HE = 44,
    _40mmFragGrenade = 34,
    _40mmFlashbangGrenade = 5,
}

SUPPCombatActionSuppressionBonus = {
    SingleShot = 1,
    DualShot = 1,
    RightHandShot = 1,
    LeftHandShot = 1,
    CancelShotCone = 1,
    TheGrim = 2,
    KalynaPerk = 2,
    IcePerk = 2,
    PinDown = 2,
    GloryHog = 0,
    ExplodingPalm = 0,
    KnifeThrow = 0,
    MeleeAttack = 0,
    Brutalize = 0,
    Charge = 0,
    RecklessAssault = 0,
    BurstFire = 4,
    BulletHell = 6,
    AutoFire = 6,
    Buckshot = 10,
    BuckshotBurst = 10,
    DoubleBarrel = 10,
    ThrowGrenadeA = 0,
    ThrowGrenadeB = 0,
    DoubleTossB = 0,
    MGBurstFire = 8,
    RocketLauncherFire = 0,
    GrenadeLauncherFire = 0,
}



-- Single Shot Actions

CombatActions.SingleShot.BaseSuppressionValue = CombatActions.SingleShot.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.SingleShot
CombatActions.DualShot.BaseSuppressionValue = CombatActions.DualShot.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.DualShot
CombatActions.RightHandShot.BaseSuppressionValue = CombatActions.RightHandShot.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.RightHandShot
CombatActions.LeftHandShot.BaseSuppressionValue = CombatActions.LeftHandShot.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.LeftHandShot
CombatActions.CancelShotCone.BaseSuppressionValue = CombatActions.CancelShotCone.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.CancelShotCone
CombatActions.TheGrim.BaseSuppressionValue = CombatActions.TheGrim.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.TheGrim
CombatActions.KalynaPerk.BaseSuppressionValue = CombatActions.KalynaPerk.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.KalynaPerk
CombatActions.IcePerk.BaseSuppressionValue = CombatActions.IcePerk.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.IcePerk
CombatActions.PinDown.BaseSuppressionValue = CombatActions.PinDown.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.PinDown

-- Melee Actions

CombatActions.GloryHog.BaseSuppressionValue = CombatActions.GloryHog.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.GloryHog
CombatActions.ExplodingPalm.BaseSuppressionValue = CombatActions.ExplodingPalm.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.ExplodingPalm
CombatActions.KnifeThrow.BaseSuppressionValue = CombatActions.KnifeThrow.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.KnifeThrow
CombatActions.MeleeAttack.BaseSuppressionValue = CombatActions.MeleeAttack.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.MeleeAttack
CombatActions.Brutalize.BaseSuppressionValue = CombatActions.Brutalize.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.Brutalize
CombatActions.Charge.BaseSuppressionValue = CombatActions.Charge.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.Charge
CombatActions.RecklessAssault.BaseSuppressionValue = CombatActions.RecklessAssault.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.RecklessAssault

-- Ranged Actions Multiround Actions

CombatActions.BurstFire.BaseSuppressionValue = CombatActions.BurstFire.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.BurstFire
CombatActions.BurstFire.AreaSuppression = true
CombatActions.BulletHell.BaseSuppressionValue = CombatActions.BulletHell.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.BulletHell
CombatActions.BulletHell.AreaSuppression = true
CombatActions.AutoFire.BaseSuppressionValue = CombatActions.AutoFire.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.AutoFire
CombatActions.AutoFire.AreaSuppression = true

-- Shotgun Actions

CombatActions.Buckshot.BaseSuppressionValue = CombatActions.Buckshot.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.Buckshot
CombatActions.Buckshot.AreaSuppression = true
CombatActions.BuckshotBurst.BaseSuppressionValue = CombatActions.BuckshotBurst.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.BuckshotBurst
CombatActions.BuckshotBurst.AreaSuppression = true
CombatActions.DoubleBarrel.BaseSuppressionValue = CombatActions.DoubleBarrel.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.DoubleBarrel
CombatActions.DoubleBarrel.AreaSuppression = true

-- Grenade Actions

CombatActions.ThrowGrenadeA.BaseSuppressionValue = CombatActions.ThrowGrenadeA.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.ThrowGrenadeA
CombatActions.ThrowGrenadeA.AreaSuppression = true
CombatActions.ThrowGrenadeB.BaseSuppressionValue = CombatActions.ThrowGrenadeB.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.ThrowGrenadeB
CombatActions.ThrowGrenadeB.AreaSuppression = true
CombatActions.DoubleTossB.BaseSuppressionValue = CombatActions.DoubleTossB.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.DoubleTossB
CombatActions.DoubleTossB.AreaSuppression = true

-- MgBurstFire

CombatActions.MGBurstFire.BaseSuppressionValue = CombatActions.MGBurstFire.BaseSuppressionValue or
SUPPCombatActionSuppressionBonus.MGBurstFire
CombatActions.MGBurstFire.AreaSuppression = true

-- Heavy Weapons

CombatActions.RocketLauncherFire.BaseSuppressionValue = 0
CombatActions.RocketLauncherFire.AreaSuppression = true

CombatActions.GrenadeLauncherFire.BaseSuppressionValue = 0
CombatActions.GrenadeLauncherFire.AreaSuppression = true

-- Some weapons cause more suppression than others

Unarmed.SuppressionValue = Unarmed.SuppressionValue or SUPPWeaponSuppressionValues.Unarmed
MeleeWeapon.SuppressionValue = MeleeWeapon.SuppressionValue or SUPPWeaponSuppressionValues.MeleeWeapon
AssaultRifle.SuppressionValue = AssaultRifle.SuppressionValue or SUPPWeaponSuppressionValues.AssaultRifle
SubmachineGun.SuppressionValue = SubmachineGun.SuppressionValue or SUPPWeaponSuppressionValues.SubmachineGun
Pistol.SuppressionValue = Pistol.SuppressionValue or SUPPWeaponSuppressionValues.Pistol
Revolver.SuppressionValue = Revolver.SuppressionValue or SUPPWeaponSuppressionValues.Revolver
Shotgun.SuppressionValue = Shotgun.SuppressionValue or SUPPWeaponSuppressionValues.Shotgun
SniperRifle.SuppressionValue = SniperRifle.SuppressionValue or SUPPWeaponSuppressionValues.SniperRifle
MachineGun.SuppressionValue = MachineGun.SuppressionValue or SUPPWeaponSuppressionValues.MachineGun
HeavyWeapon.SuppressionValue = 0
Grenade.SuppressionValue = 0

-- Grenades and Explosives

ConcussiveGrenade.SuppressionValue = ConcussiveGrenade.SuppressionValue or SUPPWeaponSuppressionValues.ConcussiveGrenade
HE_Grenade.SuppressionValue = HE_Grenade.SuppressionValue or SUPPWeaponSuppressionValues.HE_Grenade
FragGrenade.SuppressionValue = FragGrenade.SuppressionValue or SUPPWeaponSuppressionValues.FragGrenade
ShapedCharge.SuppressionValue = ShapedCharge.SuppressionValue or SUPPWeaponSuppressionValues.ShapedCharge
Super_HE_Grenade.SuppressionValue = Super_HE_Grenade.SuppressionValue or SUPPWeaponSuppressionValues.Super_HE_Grenade
PipeBomb.SuppressionValue = PipeBomb.SuppressionValue or SUPPWeaponSuppressionValues.PipeBomb
ProximityC4.SuppressionValue = ProximityC4.SuppressionValue or SUPPWeaponSuppressionValues.ProximityC4
RemoteC4.SuppressionValue = RemoteC4.SuppressionValue or SUPPWeaponSuppressionValues.RemoteC4
TimedC4.SuppressionValue = TimedC4.SuppressionValue or SUPPWeaponSuppressionValues.TimedC4
ProximityPETN.SuppressionValue = ProximityPETN.SuppressionValue or SUPPWeaponSuppressionValues.ProximityPETN
RemotePETN.SuppressionValue = RemotePETN.SuppressionValue or SUPPWeaponSuppressionValues.RemotePETN
TimedPETN.SuppressionValue = TimedPETN.SuppressionValue or SUPPWeaponSuppressionValues.TimedPETN
ProximityTNT.SuppressionValue = ProximityTNT.SuppressionValue or SUPPWeaponSuppressionValues.ProximityTNT
RemoteTNT.SuppressionValue = RemoteTNT.SuppressionValue or SUPPWeaponSuppressionValues.RemoteTNT
TimedTNT.SuppressionValue = TimedTNT.SuppressionValue or SUPPWeaponSuppressionValues.TimedTNT


-- Rockets, launched Grenades and Mortar Shells

Warhead_Frag.SuppressionValue = Warhead_Frag.SuppressionValue or SUPPWeaponSuppressionValues.Warhead_Frag
MortarShell_HE.SuppressionValue = MortarShell_HE.SuppressionValue or SUPPWeaponSuppressionValues.MortarShell_HE
_40mmFragGrenade.SuppressionValue = _40mmFragGrenade.SuppressionValue or SUPPWeaponSuppressionValues._40mmFragGrenade
_40mmFlashbangGrenade.SuppressionValue = _40mmFlashbangGrenade.SuppressionValue or
SUPPWeaponSuppressionValues._40mmFlashbangGrenade
