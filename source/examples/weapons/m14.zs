
class b_m14 : basestandardrifle {
	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            5;
		weapon.slotpriority          1;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M14.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M14";
		inventory.icon               "M14UA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_762x51";
		BHDWeapon.BAmmoClass         "B762x51Ammo";
		BHDWeapon.BMagazineClass     "b762_m14_mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M14UA0";
		BHDWeapon.BSpriteWithoutMag  "M14UB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "M14CA0";
		BHDWeapon.BWeaponBulk        110;
		BHDWeapon.BMagazineBulk      20;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  20;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;

		BHDWeapon.BFireSound         "weapons/m14/fire";
		BHDWeapon.BSFireSound        "weapons/m14/silentfire";
		BHDWeapon.BChamberSound      "weapons/m14/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/m14/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/m14/boltforward";
		BHDWeapon.BClickSound        "weapons/m14/click";
		BHDWeapon.BLoadSound         "";
		BHDWeapon.BUnloadSound       "weapons/m14/clipeject";

		BHDWeapon.BROF               0;
		BHDWeapon.BBackSightImage    "bm14sig";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       16;
		BHDWeapon.BFrontSightImage   "bm14ir";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      15;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "762_NATO_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "B762x51Spent";
		hdweapon.refid               B_M14_REFID;

		BHDWeapon.BLayerSight   104;
		BHDWeapon.bLayerRHand   107;
		BHDWeapon.bLayerGun     102;
		BHDWeapon.bLayerGunBack 106;
		BHDWeapon.bLayerMisc    99;
		BHDWeapon.bLayerBarrel  98;
	}

	states {
		Spawn:
			M14U A 0 GetMagState();
			Goto Super::Spawn;
			


		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "BaseAcog" || invoker.scopeClass is "BaseFullDotSight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("HighMiscBarrel");
						}
						else if (invoker.barrelClass) {
							return ResolveState("HighBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("HighMisc");
						}
						return ResolveState("High");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowMiscBarrel");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowMisc");
						}
						return ResolveState("Low");
					}
				}
				else {
					if (invoker.barrelClass && invoker.miscClass) {
						return ResolveState("NoneMiscBarrel");
					}
					else if (invoker.barrelClass) {
						return ResolveState("NoneBarrel");
					}
					else if (invoker.miscClass) {
						return ResolveState("NoneMisc");
					}
					return ResolveState(NULL);
				}
			}
			M14U A -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrel:
			M14U W -1;
			Goto HDWeapon::Spawn;

		HighBarrel:
			M14U U -1;
			Goto HDWeapon::Spawn;

		HighMisc:
			M14U S -1;
			Goto HDWeapon::Spawn;

		High:
			M14U Q -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrel:
			M14U O -1;
			Goto HDWeapon::Spawn;

		LowBarrel:
			M14U M -1;
			Goto HDWeapon::Spawn;

		LowMisc:
			M14U K -1;
			Goto HDWeapon::Spawn;

		Low:
			M14U I -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrel:
			M14U G -1;
			Goto HDWeapon::Spawn;

		NoneBarrel:
			M14U E -1;
			Goto HDWeapon::Spawn;

		NoneMisc:
			M14U C -1;
			Goto HDWeapon::Spawn;




		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "BaseAcog" || invoker.scopeClass is "BaseFullDotSight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("HighMiscBarrelEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("HighBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("HighMiscEmpty");
						}
						return ResolveState("HighEmpty");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowMiscBarrelEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowMiscEmpty");
						}
						return ResolveState("LowEmpty");
					}
				}
				else {
					if (invoker.barrelClass && invoker.miscClass) {
						return ResolveState("NoneMiscBarrelEmpty");
					}
					else if (invoker.barrelClass) {
						return ResolveState("NoneBarrelEmpty");
					}
					else if (invoker.miscClass) {
						return ResolveState("NoneMiscEmpty");
					}
					return ResolveState(NULL);
				}
			}
			M14U B -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrelEmpty:
			M14U X -1;
			Goto HDWeapon::Spawn;

		HighBarrelEmpty:
			M14U V -1;
			Goto HDWeapon::Spawn;

		HighMiscEmpty:
			M14U T -1;
			Goto HDWeapon::Spawn;

		HighEmpty:
			M14U R -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrelEmpty:
			M14U P -1;
			Goto HDWeapon::Spawn;

		LowBarrelEmpty:
			M14U N -1;
			Goto HDWeapon::Spawn;

		LowMiscEmpty:
			M14U L -1;
			Goto HDWeapon::Spawn;

		LowEmpty:
			M14U J -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrelEmpty:
			M14U H -1;
			Goto HDWeapon::Spawn;

		NoneBarrelEmpty:
			M14U F -1;
			Goto HDWeapon::Spawn;

		NoneMiscEmpty:
			M14U D -1;
			Goto HDWeapon::Spawn;


		LayerReloadHands:
			M14H A 0;
			#### A 3; //Offset(-1, 36);
			#### B 3;
			#### C 3 {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### B 3 {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 2; //offset(0, 34);
			Stop; 


		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0 {
				A_Overlay(invoker.bLayerRHand, "LayerReloadHands");
				//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 3 Offset(-1, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 999 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity - 1;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}
					invoker.setChamber();
					//BrokenRound();
					return ResolveState(NULL);
				}
				//console.printf("noping");
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				A_Overlay(invoker.bLayerGun, "LayerGunBolt");
			}
			#### D 3 offset(0, 36) {
				//A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}







		LayerGun:
			M14G B 1;
			Loop;

		LayerGunBack:
			M14G A 1;
			Loop;

		NoHandsBack:
			Stop;

		LayerGunFire:
			#### # 0 {
				A_Overlay(invoker.bLayerGunBack, "BoltMove");
			}
			Goto LayerGun;

		BoltMove:
			M14G C 1;
			Goto LayerGunBack;

		LayerGunBolt:
			M14G B 3;
			Goto LayerGun;
			
		LayerDefaultSight:
			TNT1 A 1;
			Loop;

	}

	override string, double GetPickupSprite() {
		if(magazineHasAmmo()) {
			if (scopeClass) {
				if (scopeClass is "BaseAcog" || scopeClass is "BaseFullDotSight") {
					if (barrelClass && miscClass) {
						return "M14UW0", 1.;
					}
					else if (barrelClass) {
						return "M14UU0", 1.;
					}
					else if (miscClass) {
						return "M14US0", 1.;
					}
					return "M14UQ0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M14UO0", 1.;
					}
					else if (barrelClass) {
						return "M14UM0", 1.;
					}
					else if (miscClass) {
						return "M14UK0", 1.;
					}
					return "M14UI0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "M14UG0", 1.;
				}
				else if (barrelClass) {
					return "M14UE0", 1.;
				}
				else if (miscClass) {
					return "M14UC0", 1.;
				}
				return "M14UA0", 1.;
			}
		}
		else {
			if (scopeClass) {
				if (scopeClass is "BaseAcog" || scopeClass is "BaseFullDotSight") {
					if (barrelClass && miscClass) {
						return "M14UX0", 1.;
					}
					else if (barrelClass) {
						return "M14UV0", 1.;
					}
					else if (miscClass) {
						return "M14UT0", 1.;
					}
					return "M14UR0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M14UP0", 1.;
					}
					else if (barrelClass) {
						return "M14UN0", 1.;
					}
					else if (miscClass) {
						return "M14UL0", 1.;
					}
					return "M14UJ0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "M14UH0", 1.;
				}
				else if (barrelClass) {
					return "M14UF0", 1.;
				}
				else if (miscClass) {
					return "M14UD0", 1.;
				}
				return "M14UB0", 1.;
			}
		}


	}




















}


class m14LightOffset : MiscOffset {
	default {
		Offset.WeaponClass "b_m14";
		Offset.WeaponOverlay "B_M16_Flashlight";
		Offset.OffX -7;
		Offset.OffY -8;
	}
}

class M14ReflexRedOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M14";
		Offset.WeaponOverlay "B_Reflex_Red";
		Offset.OffY 5;
		Offset.OffX -1;
	}
}