

class b_m107 : basestandardrifle {
	default {
		-hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            6;
		weapon.slotpriority          1;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M107.";
		scale                        0.7;
		weapon.bobrangex             4.4;
		weapon.bobrangey             2.5;
		obituary                     "%o was assaulted by %k.";
		tag                          "M107";
		inventory.icon               "M17PA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_BMG";
		BHDWeapon.BAmmoClass         "B50BMGAmmo";
		BHDWeapon.BMagazineClass     "M107Magazine";
		BHDWeapon.BGunMass           12.0;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M17PA0";
		BHDWeapon.BSpriteWithoutMag  "M17PB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "M17MA0";
		BHDWeapon.BWeaponBulk        c_m107_bulk;
		BHDWeapon.BMagazineBulk      c_m107_mag_bulk;
		BHDWeapon.BBulletBulk        c_762_round_bulk;
		BHDWeapon.BMagazineCapacity  10;
		BHDWeapon.BarrelLength       48;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        1;
		BHDWeapon.BFlashSprite       "M7FLA0";

		BHDWeapon.BFireSound         "weapons/m107/fire";
		BHDWeapon.BSFireSound        "weapons/m14/silentfire";
		BHDWeapon.BChamberSound      "weapons/m14/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/m14/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/m14/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/m14/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/m14/clipeject";

		BHDWeapon.BROF               0;
		BHDWeapon.BBackSightImage    "m17sig";
		BHDWeapon.BBackOffsetX       2;
		BHDWeapon.BBackOffsetY       22;
		BHDWeapon.BFrontSightImage   "";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      15;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "";
		BHDWeapon.EjectShellClass    "B50BMGSpent";
		hdweapon.refid               B_M107_REFID;

		BHDWeapon.BAltFrontSightImage "";
		BHDWeapon.BAltBackSightImage "altm17";

		BHDWeapon.BRecoilXLow -2.5;
		BHDWeapon.BRecoilXHigh 2.5;
		BHDWeapon.BRecoilYLow  10.1;
		BHDWeapon.BRecoilYHigh 19.4;

		BHDWeapon.BLayerSight   104;
		BHDWeapon.bLayerRHand   107;
		BHDWeapon.bLayerGun     102;
		BHDWeapon.bLayerGunBack 106;
		BHDWeapon.bLayerMisc    99;
		BHDWeapon.bLayerBarrel  98;
		BHDWeapon.bShowFireMode true;
	}

	states {
		Spawn:
			M17P A 0 GetMagState();
			Goto Super::Spawn;
			
		Firemode:
			#### A 1 {
				return ResolveState("Nope");
			}

		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass && invoker.scopeClass is "B_Scope_10x") {
					return ResolveState("HighMag");
				}
				else if (invoker.scopeClass) {
					return ResolveState("LowMag");
				}
				return ResolveState(NULL);
			}
			M17P A -1;
			Goto HDWeapon::Spawn;

		HighMag:
			M17P E -1;
			Goto HDWeapon::Spawn;

		LowMag:
			M17P C -1;
			Goto HDWeapon::Spawn;


		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass && invoker.scopeClass is "B_Scope_10x") {
					return ResolveState("HighMagEmpty");
				}
				else if (invoker.scopeClass) {
					return ResolveState("LowMagEmpty");
				}
				return ResolveState(NULL);
			}
			M17P B -1;
			Goto HDWeapon::Spawn;

		HighMagEmpty:
			M17P F -1;
			Goto HDWeapon::Spawn;

		LowMagEmpty:
			M17P D -1;
			Goto HDWeapon::Spawn;


		LayerReloadHands:
			M107 C 0;
			#### C 2; //Offset(-1, 36);
			#### D 5;
			#### E 5 {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### C 2 {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 0 {
				return ResolveState("LayerGun");
			} 


		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) ;//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
				}
				else {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					//invoker.weaponStatus[I_MAG]--;
				}
				return ResolveState("ReloadEnd");
			}

		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}
				A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
				A_SetTics(10);
				return ResolveState(NULL);
			}
			#### A 8 Offset(-15, 45);
			#### A 10 Offset(-15, 46);
			#### A 2 Offset(-15, 47) A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 2 Offset(-15, 45);
			#### A 2 Offset(-15, 43);
			#### A 2 Offset(-15, 41);
			#### A 5 Offset(-15, 38);
			#### A 3 Offset(-13, 41);
			#### A 3 Offset(-11, 39);
			#### A 3 Offset(-9, 37);

			//#### A 2 Offset(-14, 47);
			//#### A 2 Offset(-14, 45);
			#### A 3 Offset(-5, 35) {
				//A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
					//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("ReloadEnd");
			}


		Chamber_Manual:
			TNT1 A 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0 {
				A_Overlay(invoker.bLayerGun, "LayerReloadHands");
				//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### C 2;
			#### D 5 Offset(-1, 36) A_WeaponBusy();
			#### E 5 Offset(-1, 42);
			#### C 2 Offset(-1, 38);
			/*
			#### C 3;
			#### D 5 Offset(-1, 36) A_WeaponBusy();
			#### E 5 Offset(-1, 42) {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### C 3 Offset(-1, 38) {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			*/
			#### A 3 Offset(-1, 36) {
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
				return ResolveState("Nope");
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Ready");
			}



		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37); //A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				//console.printf("m14 am I here? %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);
				return ResolveState("Chamber_Manual");
			}


		ShootGun:
			#### A 0 {
				if (invoker.fireMode() > 0) {
					A_SetTics(invoker.bROF);
				}
			}
			#### A 1 {
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Chamber_Manual");
				}
				else {
					if (!gunbraced()) {
						A_ChangeVelocity(-cos(pitch), 0, -sin(pitch), CVF_RELATIVE);
					}
					else {
						A_ChangeVelocity(-cos(pitch) * .1, 0, -sin(pitch) * .1, CVF_RELATIVE);
					}
					A_Overlay(-500, "Flash");
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1 Offset (0, 42) {
				A_Overlay(invoker.bLayerGun, "LayerGunFire");
			}
			#### B 0 Offset (0, 38) {
				return ResolveState("Chamber");
			}


		FlashDummy:
			M7FL ABCD -1;
			Stop;

		LayerGun:
			M107 A 1;
			Loop;

		LayerGunBack:
			TNT1 A 1;
			Loop;

		NoHandsBack:
			Stop;

		LayerGunFire:
			M107 B 3;
			Goto LayerGun;

		BoltMove:
			TNT1 A 1;
			Goto LayerGunBack;

		LayerGunBolt:
			TNT1 A 1;
			Goto LayerGun;
			
		LayerDefaultSight:
			TNT1 A 1;
			Loop;

	}

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			if (scopeClass && scopeClass is "B_Scope_10x") {
				return "M17PE0", 1.;
			}
			else if (scopeClass) {
				return "M17PC0", 1.;
			}
			return "M17PA0", 1.;
		}
		else {
			if (scopeClass && scopeClass is "B_Scope_10x") {
				return "M17PF0", 1.;
			}
			else if (scopeClass) {
				return "M17PD0", 1.;
			}
			return "M17PB0", 1.;
		}


	}




















}



class M107AcogOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M107";
		Offset.WeaponOverlay "B_ACOG_Red";
		Offset.OffY 11;
		Offset.OffX 0;
	}
}

class M107ScopeOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M107";
		Offset.WeaponOverlay "B_Scope_10x";
		Offset.OffY 8;
		Offset.OffX 0;
	}
}

class M107CRDotOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M107";
		Offset.WeaponOverlay "B_Sight_CRdot";
		Offset.OffY 8;
		Offset.OffX 0;
	}
}

class M107HoloOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M107";
		Offset.WeaponOverlay "B_Sight_Holo_Red";
		Offset.OffY 11;
		Offset.OffX 0;
	}
}

class M107ReflexOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_M107";
		Offset.WeaponOverlay "B_Reflex_Red";
		Offset.OffY 11;
		Offset.OffX 0;
	}
}