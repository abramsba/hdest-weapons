class B_Uzi : BaseStandardRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            2;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the Uzi.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "Uzi";
		inventory.icon               "UZIPA0";
		BHDWeapon.BFlashSprite       "UZFLA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_9";
		BHDWeapon.BAmmoClass         "HDPistolAmmo";
		BHDWeapon.BMagazineClass     "UziMagazine";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "UZIPA0";
		BHDWeapon.BSpriteWithoutMag  "UZIPB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "UZICA0";
		BHDWeapon.BWeaponBulk        c_uzi_bulk;
		BHDWeapon.BMagazineBulk      c_uzi_mag_bulk;
		BHDWeapon.BBulletBulk        c_van_9mm_bulk;
		BHDWeapon.BMagazineCapacity  32;
		BHDWeapon.BarrelLength       10;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		
		BHDWeapon.BFireSound         "weapons/uzi/fire";
		BHDWeapon.BSFireSound        "weapons/mp5/silentfire";
		BHDWeapon.BChamberSound      "weapons/m4/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/m4/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/m4/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/m4/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/m4/clipeject";

		BHDWeapon.BROF               0.5;
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       4;
		BHDWeapon.BFrontSightImage   "uzifr";
		BHDWeapon.BBackSightImage    "uzibr";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      4;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "9MM_GLOCK";
		BHDWeapon.bScopeMount        "";
		BHDWeapon.bMiscMount         "";
		BHDWeapon.EjectShellClass    "HDSpent9mm";
		hdweapon.refid               B_UZI_REFID;

		BHDWeapon.BAltFrontSightImage "uzifr";
		BHDWeapon.BAltBackSightImage "uzibr";

		BHDWeapon.BLayerSight  104;
		BHDWeapon.bLayerRHand  105;
		BHDWeapon.bLayerGunBack -99;

		BHDWeapon.BRecoilXLow -1.2;
		BHDWeapon.BRecoilXHigh 1.2;
		BHDWeapon.BRecoilYLow  1.3;
		BHDWeapon.BRecoilYHigh 2.3;		
		BHDWeapon.bShowFireMode true;
	}

	states {
		Spawn:
			UZIP A 0 GetMagState();
			Goto Super::Spawn;

		Firemode:
			#### A 1 {
				invoker.weaponStatus[I_AUTO] = (invoker.weaponStatus[I_AUTO] == 1 ? 0 : 1);
				A_WeaponReady(WRF_NONE);
				return ResolveState("Nope");
			}

		SpawnMag:
			UZIP A -1;
			Goto HDWeapon::Spawn;

		SpawnNoMag:
			UZIP B -1;
			Goto HDWeapon::Spawn;

		LayerGunBack:
			TNT1 A 1;
			Loop;

		LayerGun:
			UZIG A 1;
			Loop;

		LayerGunFire:
			UZIG A 1;
			Goto LayerGun;

		LayerGunBolt:
			UZIG E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;

		LayerReloadHands:
			TNT1 A 0;
			Goto Super::LayerReloadHands;

		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadChamber:
			#### A 0 {
				A_Overlay(invoker.bLayerRHand, "PullBolt");
			}
			Goto Super::UnloadChamber;

		PullBolt:
			TNT1 A 2;
			TNT1 B 2;
			TNT1 A 0 {
				A_Overlay(invoker.bLayerGun, "GunPullBolt");
			}
			TNT1 C 3; //A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			TNT1 B 3; //A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			TNT1 A 3;
			Stop;

		ShootGun:
			#### A 0 {
				if (invoker.fireMode() > 0) {
					A_SetTics(invoker.bROF);
				}
			}
			#### A 0 {
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Chamber_Manual");
				}
				else {
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

		Reload:
			#### D 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				bool nomags=HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass);
				//console.printf("break the chamber r %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);

				if (invoker.weaponstatus[I_FLAGS] & F_CHAMBER_BROKE) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					//console.printf("break the chamber r2 %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);
					return ResolveState("UnloadChamber");
				}
				else if (!invoker.chambered() && invoker.weaponStatus[I_MAG] < 1 && (pressingUse() || nomags)) {
					return ResolveState("LoadChamber");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					return ResolveState("UnloadChamber");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass) && invoker.magazineGetAmmo() < invoker.bMagazineCapacity) {
					return ResolveState("UnloadMag");
				}
				else if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 999 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				return ResolveState("Nope");
			}

		LayerGunHandReturn:
			UZIG C 3;
			UZIG A -1;
			Stop;

		ReloadEnd:
			#### A 2 Offset(0, 39);
			#### A 1 Offset(0, 37); //A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(0, 34);
			#### A 0 {
				if (invoker.brokenChamber()) {
					return ResolveState("Nope");
				}
				return ResolveState("Chamber_Manual");
			}

		Empty:
			TNT1 A 1;
			Stop;

		LayerGunReloading:
			UZIG C 3;
			UZIG D -1;
			Stop;

		UnloadMag:
			#### A 3 Offset(0, 33);
			#### A 3 Offset(0, 34);
			#### A 1 Offset(0, 37);
			#### A 2 Offset(0, 39) {
				//console.printf("unload mag %i", invoker.magazineGetAmmo());
				if (invoker.magazineGetAmmo() < 0) {
					//console.printf("mag out %i", invoker.magazineGetAmmo());
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound(invoker.bUnloadSound, CHAN_WEAPON, CHANF_OVERLAP);
				return ResolveState(NULL);
			}
			#### A 4 Offset(0, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			}
			#### A 120 offset(0, 44) {

				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("MagOut");
			}

		MagOut:
			#### A 4;
			#### A 8 {
				if (invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY || !CountInv(invoker.bMagazineClass)) {
					return ResolveState("ReloadEnd");
				}
				return ResolveState("LoadMag");
			}

		GunPullBolt:
			TNT1 E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;

		Chamber_Anim:
			UZIG B 3;
			UZIG C 3;
			UZIG D 5 {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			}
			UZIG C 5 {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			}
			UZIG E 3;
			Stop;

		Chamber_Manual:
			#### A 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### A 3 Offset(0, 36) {
				A_WeaponBusy();
				A_Overlay(invoker.bLayerGun, "Chamber_Anim");
			}
			#### A 3;
			#### A 3 Offset(0, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 999 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity - 1;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}

					//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
					invoker.setChamber();
					//BrokenRound();
					//return ResolveState(NULL);
				}
				//console.printf("noping");
				//return ResolveState("Nope");
			}
			#### A 3 offset(0, 46) {
				//A_Overlay(invoker.bLayerGun, "LayerGunBolt");
			}
			#### A 3 offset(0, 36) {
				//A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			}
			#### A 3;
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
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
			#### A 8 Offset(0, 45);
			#### A 1 Offset(0, 46);
			#### A 1 Offset(0, 47) A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 10 Offset(0, 42);
			#### A 1 Offset(0, 47);
			#### A 1 Offset(0, 45);
			#### A 1 Offset(0, 44) {
				//A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
					//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("ReloadEnd");
			}

		DUMMY:
			UZFL ABCD -1;
			Stop;


	}

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			return "UZIPA0", 1.;
		}
		else {
			return "UZIPB0", 1.;
		}
	}	
}

class UziSilencerOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_UZI";
		Offset.WeaponOverlay "GlockSilencer";
		Offset.OffY 25;
		Offset.OffX 0;
	}
}