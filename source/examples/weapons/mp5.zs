
class B_MP5 : BHDWeapon {
	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            2;
		weapon.slotpriority          2;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the MP5.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "MP5";
		inventory.icon               "MP5UA0";
		BHDWeapon.BFlashSprite       "MPFLA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_9";
		BHDWeapon.BAmmoClass         "HDPistolAmmo";
		BHDWeapon.BMagazineClass     "B9mm_MP5K_MAG";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "MP5UA0";
		BHDWeapon.BSpriteWithoutMag  "MP5UB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "MP5CA0";
		BHDWeapon.BWeaponBulk        c_mp5_bulk;
		BHDWeapon.BMagazineBulk      c_mp5_mag_bulk;
		BHDWeapon.BBulletBulk        c_van_9mm_bulk;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       18.75;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;

		BHDWeapon.BFireSound         "weapons/mp5/fire";
		BHDWeapon.BSFireSound        "weapons/mp5/silentfire";
		BHDWeapon.BChamberSound      "weapons/mp5/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/mp5/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/mp5/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/mp5/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/mp5/clipeject";

		BHDWeapon.BROF               0;
		BHDWeapon.BBackSightImage    "mp5sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       20;
		BHDWeapon.BFrontSightImage   "mp5iron";
		BHDWeapon.BFrontOffsetX      -6;
		BHDWeapon.BFrontOffsetY      14;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "9MM_GLOCK";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "HDSpent9mm";
		hdweapon.refid               B_MP5_REFID;

		BHDWeapon.BAltFrontSightImage "altm5i";
		BHDWeapon.BAltBackSightImage  "altm5s";

		BHDWeapon.BIronThreshold 10;

		BHDWeapon.BLayerGun    100;
		BHDWeapon.BLayerSight  105;
		BHDWeapon.BLayerMisc   102;
		BHDWeapon.bLayerBarrel 99;
		BHDWeapon.bLayerRHand  104;
		BHDWeapon.bLayerGunBack 106;

		BHDWeapon.BRecoilXLow -0.0;
		BHDWeapon.BRecoilXHigh 0.1;
		BHDWeapon.BRecoilYLow  0.25;
		BHDWeapon.BRecoilYHigh 0.0;	
		BHDWeapon.bShowFireMode true;	
	}

	states {
		Spawn:
			MP5U A 0;
			Goto Super::Spawn; 

		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (!(invoker.scopeClass is "BaseHoloSight") && !(invoker.scopeClass is "BaseCompactDotSight")) {
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
			MP5U A -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrel:
			MP5U W -1;
			Goto HDWeapon::Spawn;

		HighBarrel:
			MP5U U -1;
			Goto HDWeapon::Spawn;

		HighMisc:
			MP5U S -1;
			Goto HDWeapon::Spawn;

		High:
			MP5U Q -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrel:
			MP5U O -1;
			Goto HDWeapon::Spawn;

		LowBarrel:
			MP5U M -1;
			Goto HDWeapon::Spawn;

		LowMisc:
			MP5U K -1;
			Goto HDWeapon::Spawn;

		Low:
			MP5U I -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrel:
			MP5U G -1;
			Goto HDWeapon::Spawn;

		NoneBarrel:
			MP5U E -1;
			Goto HDWeapon::Spawn;

		NoneMisc:
			MP5U C -1;
			Goto HDWeapon::Spawn;




		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (!(invoker.scopeClass is "BaseHoloSight") && !(invoker.scopeClass is "BaseCompactDotSight")) {
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
			MP5U B -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrelEmpty:
			MP5U X -1;
			Goto HDWeapon::Spawn;

		HighBarrelEmpty:
			MP5U V -1;
			Goto HDWeapon::Spawn;

		HighMiscEmpty:
			MP5U T -1;
			Goto HDWeapon::Spawn;

		HighEmpty:
			MP5U R -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrelEmpty:
			MP5U P -1;
			Goto HDWeapon::Spawn;

		LowBarrelEmpty:
			MP5U N -1;
			Goto HDWeapon::Spawn;

		LowMiscEmpty:
			MP5U L -1;
			Goto HDWeapon::Spawn;

		LowEmpty:
			MP5U J -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrelEmpty:
			MP5U H -1;
			Goto HDWeapon::Spawn;

		NoneBarrelEmpty:
			MP5U F -1;
			Goto HDWeapon::Spawn;

		NoneMiscEmpty:
			MP5U D -1;
			Goto HDWeapon::Spawn;

		LayerGun:
			MP5G H 1;
			Loop;

		LayerGunBack:
			MP5G I 1 {
				if (invoker.scopeClass is "B_Scope_10x") {
					invoker.bLayerSight = 999;
				}
				else {
					invoker.bLayerSight = 105;
				}
			}
			Loop;

		NoHandsFront:
			MP5G L 12;
			Goto LayerGun; 

		NoHandsBack:
			MP5G M 12;
			Goto LayerGunBack; 

		LayerGunFire:
			MP5G H 1;
			Goto LayerGun;

		LayerGunBolt:
			MP5G B 3;
			Goto LayerGun;

		LayerReloadHands:
			TNT1 A 6;
			MP5H C 9;
			MP5H A 3;
			Stop;
			
		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadMag:
			TNT1 A 0 {
				A_Overlay(invoker.BLayerRHand, "HandDisengageBolt");
				A_Overlay(invoker.BLayerGun, "UnloadFront");
				A_Overlay(invoker.BLayerGunBack, "UnloadBack");
				A_StartSound(invoker.bloadSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 1 Offset(0, 33);
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-8, 37);
			#### A 2 Offset(-11, 39) {

				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(-12, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			}
			#### A 20 offset(-14, 44) {

				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
				if (invoker.chambered()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
				}
				invoker.unchamber();
				

				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON);
				}
				return ResolveState("MagOut");
			}

		UnloadFront:
			MP5G K 4;

		UnloadFrontWait:
			MP5G L 1;
			Loop;

		UnloadBack:
			MP5G M 1;
			Loop;

		HandDisengageBolt:
			MP5H AB 2;
			MP5H C 2 {
				A_StartSound("mp5/boltb", CHAN_WEAPON, CHANF_OVERLAP);
			}
			Stop;

		HandSlapBolt:
			TNT1 A 9;
			MP5H C 2 {
				A_StartSound("mp5/boltf", CHAN_WEAPON, CHANF_OVERLAP);
			}
			MP5H A 2;
			Stop;

		Front:
			MP5H H 4;
			MP5H J 2;

		BoltBackHands:
			MP5H A 2;
			MP5H B 2;
			MP5H C 4;
			Stop;

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0 {
				A_Overlay(invoker.bLayerRHand, "HandSlapBolt");
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 3 Offset(-1, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 100 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = 29;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}

					A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
					invoker.setChamber();
					BrokenRound();
					return ResolveState(NULL);
				}
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				//A_Overlay(invoker.bLayerRHand, "HandSlapBolt");
				//A_Overlay(invoker.bLayerGunBack, "UnloadBack");
			}
			#### D 3 offset(0, 36) {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}

		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;				
				if (invoker.magazineGetAmmo() >= 0) {
					
					return ResolveState("UnloadMag");
				}
				else {
					return ResolveState("Nope");
				}
			}

		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				bool nomags=HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass);

				if (invoker.weaponstatus[I_FLAGS] & F_CHAMBER_BROKE) {
					return ResolveState("UnloadChamber");
				}
				else if (!invoker.chambered() && invoker.weaponStatus[I_MAG] < 1 && (pressingUse() || nomags)) {
					return ResolveState("LoadChamber");
				}
				if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 30 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() == invoker.bMagazineCapacity - 1) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					return ResolveState("UnloadChamber");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass)) {
					return ResolveState("UnloadMag");
				}
				return ResolveState("Nope");
			}

		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37); //A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				//console.printf("I'm here");
				if (invoker.brokenChamber()) {
					//console.printf("nahing out");
					return ResolveState("Nope");
				}
				return ResolveState("Chamber_Manual");
			}

		Dummy:
			MPFL A -1;
			MPFL B -1;
			MPFL C -1;
			MPFL D -1;
			Stop;

	}	

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			if (scopeClass) {
				if (!(scopeClass is "BaseHoloSight") && !(scopeClass is "BaseCompactDotSight")) {
					if (barrelClass && miscClass) {
						return "MP5UW0", 1.;
					}
					else if (barrelClass) {
						return "MP5UU0", 1.;
					}
					else if (miscClass) {
						return "MP5US0", 1.;
					}
					return "MP5UQ0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "MP5UO0", 1.;
					}
					else if (barrelClass) {
						return "MP5UM0", 1.;
					}
					else if (miscClass) {
						return "MP5UK0", 1.;
					}
					return "MP5UI0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "MP5UG0", 1.;
				}
				else if (barrelClass) {
					return "MP5UE0", 1.;
				}
				else if (miscClass) {
					return "MP5UC0", 1.;
				}
				return "MP5UA0", 1.;
			}
		}
		else {
			if (scopeClass) {
				if (!(scopeClass is "BaseHoloSight") && !(scopeClass is "BaseCompactDotSight")) {
					if (barrelClass && miscClass) {
						return "MP5UX0", 1.;
					}
					else if (barrelClass) {
						return "MP5UV0", 1.;
					}
					else if (miscClass) {
						return "MP5UT0", 1.;
					}
					return "MP5UR0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "MP5UP0", 1.;
					}
					else if (barrelClass) {
						return "MP5UN0", 1.;
					}
					else if (miscClass) {
						return "MP5UL0", 1.;
					}
					return "MP5UJ0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "MP5UH0", 1.;
				}
				else if (barrelClass) {
					return "MP5UF0", 1.;
				}
				else if (miscClass) {
					return "MP5UD0", 1.;
				}
				return "MP5UB0", 1.;
			}
		}
	}

}

class Mp5FlashLightOffset : MiscOffset {
	default {
		Offset.WeaponClass "B_MP5";
		Offset.WeaponOverlay "B_M16_Flashlight";
		Offset.OffX -5;
		offset.OffY 4;
	}
}

class Mp5SilencerOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_MP5";
		Offset.WeaponOverlay "GlockSilencer";
		Offset.OffX -0.5;
		Offset.OffY 9;
	}
}

class Mp5ReflexRedOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5";
		Offset.WeaponOverlay "B_Reflex_Red";
		Offset.OffY 5;
	}
}

class Mp510xScopeOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5";
		Offset.WeaponOverlay "B_Scope_10x";
		Offset.OffY 10;
		Offset.OffX 0;
	}
}






















class B_MP5_M203 : BaseGLRifle {
	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            2;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the MP5 M203.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "MP5 M203";
		inventory.icon               "MP5PA0";
		BHDWeapon.BFlashSprite       "MPFLA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_9";
		BHDWeapon.BAmmoClass         "HDPistolAmmo";
		BHDWeapon.BMagazineClass     "B9mm_MP5K_MAG";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "MP5PA0";
		BHDWeapon.BSpriteWithoutMag  "MP5PB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "MP5CA0";
		BHDWeapon.BWeaponBulk        c_mp5_m203_bulk;
		BHDWeapon.BMagazineBulk      c_mp5_mag_bulk;
		BHDWeapon.BBulletBulk        c_van_9mm_bulk;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;

		BHDWeapon.BFireSound         "weapons/mp5/fire";
		BHDWeapon.BSFireSound        "weapons/mp5/silentfire";
		BHDWeapon.BChamberSound      "weapons/mp5/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/mp5/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/mp5/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/mp5/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/mp5/clipeject";

		BHDWeapon.BROF               0;
	
		BHDWeapon.BBackSightImage    "mp5sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       20;
		BHDWeapon.BFrontSightImage   "mp5iron";
		BHDWeapon.BFrontOffsetX      -6;
		BHDWeapon.BFrontOffsetY      14;

	
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "9MM_GLOCK";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "HDSpent9mm";
		hdweapon.refid               B_MP5M203_REFID;

		BHDWeapon.BAltFrontSightImage "altm5i";
		BHDWeapon.BAltBackSightImage "altm5s";

		BHDWeapon.BIronThreshold 10;

		BaseAltRifle.bAltMagClass    "HDRocketAmmo";
		BaseAltRifle.BAltMagPicture  "ROQPA0";

		BHDWeapon.BIronThreshold 10;

		BHDWeapon.BLayerGun    100;
		BHDWeapon.BLayerSight  105;
		BHDWeapon.BLayerMisc   102;
		BHDWeapon.bLayerBarrel 99;
		BHDWeapon.bLayerRHand  104;
		BHDWeapon.bLayerGunBack 106;

		BHDWeapon.BRecoilXLow -0.4;
		BHDWeapon.BRecoilXHigh 0.4;
		BHDWeapon.BRecoilYLow  0.8;
		BHDWeapon.BRecoilYHigh 1.2;	
		BHDWeapon.bShowFireMode true;	
	}

	bool boltIsBack;

	states {
		Spawn:
			M5GU A 0;
			Goto Super::Spawn; 

		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (!(invoker.scopeClass is "BaseHoloSight") && !(invoker.scopeClass is "BaseCompactDotSight")) {
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
			M5GU A -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrel:
			M5GU W -1;
			Goto HDWeapon::Spawn;

		HighBarrel:
			M5GU U -1;
			Goto HDWeapon::Spawn;

		HighMisc:
			M5GU S -1;
			Goto HDWeapon::Spawn;

		High:
			M5GU Q -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrel:
			M5GU O -1;
			Goto HDWeapon::Spawn;

		LowBarrel:
			M5GU M -1;
			Goto HDWeapon::Spawn;

		LowMisc:
			M5GU K -1;
			Goto HDWeapon::Spawn;

		Low:
			M5GU I -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrel:
			M5GU G -1;
			Goto HDWeapon::Spawn;

		NoneBarrel:
			M5GU E -1;
			Goto HDWeapon::Spawn;

		NoneMisc:
			M5GU C -1;
			Goto HDWeapon::Spawn;




		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (!(invoker.scopeClass is "BaseHoloSight") && !(invoker.scopeClass is "BaseCompactDotSight")) {
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
			M5GU B -1;
			Goto HDWeapon::Spawn;


		HighMiscBarrelEmpty:
			M5GU X -1;
			Goto HDWeapon::Spawn;

		HighBarrelEmpty:
			M5GU V -1;
			Goto HDWeapon::Spawn;

		HighMiscEmpty:
			M5GU T -1;
			Goto HDWeapon::Spawn;

		HighEmpty:
			M5GU R -1;
			Goto HDWeapon::Spawn;

		LowMiscBarrelEmpty:
			M5GU P -1;
			Goto HDWeapon::Spawn;

		LowBarrelEmpty:
			M5GU N -1;
			Goto HDWeapon::Spawn;

		LowMiscEmpty:
			M5GU L -1;
			Goto HDWeapon::Spawn;

		LowEmpty:
			M5GU J -1;
			Goto HDWeapon::Spawn;

		NoneMiscBarrelEmpty:
			M5GU H -1;
			Goto HDWeapon::Spawn;

		NoneBarrelEmpty:
			M5GU F -1;
			Goto HDWeapon::Spawn;

		NoneMiscEmpty:
			M5GU D -1;
			Goto HDWeapon::Spawn;





		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				if (invoker.weaponstatus[I_FLAGS] & F_GL_MODE && invoker.weaponStatus[I_FLAGS] & I_GRENADE) {
					return ResolveState("UnloadAlt");
				}
				else if (invoker.weaponstatus[I_FLAGS] & F_GL_MODE) {
					return ResolveState("Nope");
				}	
				
				if (invoker.magazineGetAmmo() >= 0) {
					invoker.boltIsBack = true;
					return ResolveState("UnloadMag");
				}
				else {
					return ResolveState("Nope");
				}
			}

		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				bool nomags=HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass);

				if (invoker.weaponstatus[I_FLAGS] & F_CHAMBER_BROKE) {
					return ResolveState("UnloadChamber");
				}
				else if (!invoker.chambered() && invoker.weaponStatus[I_MAG] < 1 && (pressingUse() || nomags)) {
					return ResolveState("LoadChamber");
				}
				if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 30 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() == invoker.bMagazineCapacity - 1) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					return ResolveState("UnloadChamber");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass)) {
					return ResolveState("UnloadMag");
				}
				return ResolveState("Nope");
			}






		LayerGun:
			MP5G H 1;
			Loop;

		LayerGunBack:
			MP5G I 1 {
				if (invoker.scopeClass is "B_Scope_10x") {
					invoker.bLayerSight = 999;
				}
				else {
					invoker.bLayerSight = 105;
				}
			}
			Loop;

		NoHandsFront:
			MP5G L 12;
			Goto LayerGun; 

		NoHandsBack:
			MP5G M 12;
			Goto LayerGunBack; 

		LayerGunFire:
			MP5G H 1;
			Goto LayerGun;

		LayerGunBolt:
			MP5G B 3;
			Goto LayerGun;

		LayerReloadHands:
			TNT1 A 6;
			MP5H C 9;
			MP5H A 3;
			Stop;
			
		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadMag:
			TNT1 A 0 {
				A_Overlay(invoker.BLayerRHand, "HandDisengageBolt");
				A_Overlay(invoker.BLayerGun, "UnloadFront");
				A_Overlay(invoker.BLayerGunBack, "UnloadBack");
				A_StartSound(invoker.bloadSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 1 Offset(0, 33);
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-8, 37);
			#### A 2 Offset(-11, 39) {

				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(-12, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			}
			#### A 20 offset(-14, 44) {

				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
				if (invoker.chambered()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
				}
				invoker.unchamber();
				

				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON);
				}
				return ResolveState("MagOut");
			}


















		UnloadFront:
			MP5G K 4;

		UnloadFrontWait:
			MP5G L 1;
			Loop;

		UnloadBack:
			MP5G M 1;
			Loop;

		HandDisengageBolt:
			MP5H AB 2;
			MP5H C 2 {
				A_StartSound(invoker.BBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			Stop;

		HandSlapBolt:
			TNT1 A 9;
			MP5H C 2 {
				A_StartSound(invoker.BBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);

			}
			MP5H A 2;
			Stop;

		Front:
			MP5H H 4;
			MP5H J 2;

		BoltBackHands:
			MP5H A 2;
			MP5H B 2;
			MP5H C 4;
			Stop;

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0 {
				A_Overlay(invoker.bLayerRHand, "HandSlapBolt");
				invoker.boltIsBack = false;
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 3 Offset(-1, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 100 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = 29;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}

					//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
					invoker.setChamber();
					BrokenRound();
					return ResolveState(NULL);
				}
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				//A_Overlay(invoker.bLayerRHand, "HandSlapBolt");
				//A_Overlay(invoker.bLayerGunBack, "UnloadBack");
			}
			#### D 3 offset(0, 36) {
				//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}

		Dummy:
			MPFL A -1;
			MPFL B -1;
			MPFL C -1;
			MPFL D -1;
			Stop;

		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37); //A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				//console.printf("I'm here");
				if (invoker.brokenChamber()) {
					//console.printf("nahing out");
					return ResolveState("Nope");
				}
				return ResolveState("Chamber_Manual");
			}

	}	

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			if (scopeClass) {
				if (!(scopeClass is "BaseHoloSight") && !(scopeClass is "BaseCompactDotSight")) {
					if (barrelClass && miscClass) {
						return "M5GUW0", 1.;
					}
					else if (barrelClass) {
						return "M5GUU0", 1.;
					}
					else if (miscClass) {
						return "M5GUS0", 1.;
					}
					return "M5GUQ0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M5GUO0", 1.;
					}
					else if (barrelClass) {
						return "M5GUM0", 1.;
					}
					else if (miscClass) {
						return "M5GUK0", 1.;
					}
					return "M5GUI0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "M5GUG0", 1.;
				}
				else if (barrelClass) {
					return "M5GUE0", 1.;
				}
				else if (miscClass) {
					return "M5GUC0", 1.;
				}
				return "M5GUA0", 1.;
			}
		}
		else {
			if (scopeClass) {
				if (!(scopeClass is "BaseHoloSight") && !(scopeClass is "BaseCompactDotSight")) {
					if (barrelClass && miscClass) {
						return "M5GUX0", 1.;
					}
					else if (barrelClass) {
						return "M5GUV0", 1.;
					}
					else if (miscClass) {
						return "M5GUT0", 1.;
					}
					return "M5GUR0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M5GUP0", 1.;
					}
					else if (barrelClass) {
						return "M5GUN0", 1.;
					}
					else if (miscClass) {
						return "M5GUL0", 1.;
					}
					return "M5GUJ0", 1.;
				}
			}
			else {
				if (barrelClass && miscClass) {
					return "M5GUH0", 1.;
				}
				else if (barrelClass) {
					return "M5GUF0", 1.;
				}
				else if (miscClass) {
					return "M5GUD0", 1.;
				}
				return "M5GUB0", 1.;
			}
		}
	}

}

class Mp5M20310xScopeOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5_M203";
		Offset.WeaponOverlay "B_Scope_10x";
		Offset.WeaponOverlay "B_Scope_10x";
		Offset.OffY 10;
		Offset.OffX 0;
	}
}

class Mp5M203FlashLightOffset : MiscOffset {
	default {
		Offset.WeaponClass "B_MP5_M203";
		Offset.WeaponOverlay "B_M16_Flashlight";
		Offset.OffX -5;
		offset.OffY 4;
	}
}

class Mp5M203SilencerOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_MP5_M203";
		Offset.WeaponOverlay "GlockSilencer";
		Offset.OffX -0.5;
		Offset.OffY 9;
	}
}

class Mp5M203ReflexRedOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5_M203";
		Offset.WeaponOverlay "B_Reflex_Red";
		Offset.OffY 5;
	}
}




