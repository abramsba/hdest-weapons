
class b_Glock : BasePistol {
	
	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            2;
		weapon.slotpriority          1;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the Glock.";
		scale                        0.7;
		weapon.bobrangex 0.1;
		weapon.bobrangey 0.6;
		obituary                     "%o was assaulted by %k.";
		tag                          "Glock";
		inventory.icon               "GLKPA0";
		BHDWeapon.BFlashSprite       "GLFLA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_9";
		BHDWeapon.BAmmoClass         "HDPistolAmmo";
		BHDWeapon.BMagazineClass     "GlockMagazine";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "GLKPA0";
		BHDWeapon.BSpriteWithoutMag  "GLKPB0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "GLKCA0";
		BHDWeapon.BWeaponBulk        c_glock_bulk;
		BHDWeapon.BMagazineBulk      c_glock_mag_bulk;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  15;
		BHDWeapon.BarrelLength       10;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;

		BHDWeapon.BFireSound         "weapons/glock/fire";
		BHDWeapon.BSFireSound        "weapons/glock/silentfire";
		BHDWeapon.BChamberSound      "weapons/glock/chamber";
		BHDWeapon.BBoltBackwardSound  "weapons/glock/boltback";
		BHDWeapon.BBoltForwardSound "weapons/glock/boltforward";
		BHDWeapon.BClickSound        "weapons/glock/click";
		BHDWeapon.BLoadSound         "weapons/glock/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/glock/clipeject";

		BHDWeapon.BROF               0;
		BHDWeapon.BBackSightImage    "glckbk";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       1;
		BHDWeapon.BFrontSightImage   "glckfr";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      1;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "9MM_GLOCK";
		BHDWeapon.bMiscMount         "NOT_ANYMORE";
		BHDWeapon.EjectShellClass    "HDSpent9mm";
		hdweapon.refid               B_GLOCK_REFID;
		BHDWeapon.bIronThreshold 	5;

		BHDWeapon.BAltFrontSightImage "alt_glf";
		BHDWeapon.BAltBackSightImage "alt_glb";

		BHDWeapon.BLayerSight  104;
		BHDWeapon.bLayerRHand  105;
		BHDWeapon.bLayerGunBack -99;

		BHDWeapon.BRecoilXLow -1.2;
		BHDWeapon.BRecoilXHigh 1.2;
		BHDWeapon.BRecoilYLow  1.1;
		BHDWeapon.BRecoilYHigh 2.1;	
	}

	states {
		Spawn:
			GLKP A 0 GetMagStatePistol();
			Goto Super::Spawn; 
		
		SpawnMag:
			GLKU A 0 {
				if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("SpawnBarrelMisc");
				}
				else if (invoker.barrelClass) {
					return ResolveState("SpawnBarrel");
				}
				else if (invoker.miscClass) {
					return ResolveState("SpawnMisc");
				}
				return ResolveState(NULL);
			}
			#### # -1;
			goto HDWeapon::Spawn;

		SpawnBarrelMisc:
			GLKU G -1;
			goto HDWeapon::Spawn;

		SpawnBarrel:
			GLKU E -1;
			goto HDWeapon::Spawn;

		SpawnMisc:
			GLKU C -1;
			goto HDWeapon::Spawn;

		Firemode:
			goto nope;

		SpawnNoMag:
			GLKU B 0 {
				if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("SpawnBarrelMiscEmpty");
				}
				else if (invoker.barrelClass) {
					return ResolveState("SpawnBarrelEmpty");
				}
				else if (invoker.miscClass) {
					return ResolveState("SpawnMiscEmpty");
				}
				return ResolveState(NULL);
			}
			#### # -1;
			goto HDWeapon::Spawn;

		SpawnBarrelMiscEmpty:
			GLKU H -1;
			goto HDWeapon::Spawn;

		SpawnBarrelEmpty:
			GLKU F -1;
			goto HDWeapon::Spawn;

		SpawnMiscEmpty:
			GLKU D -1;
			goto HDWeapon::Spawn;

		LayerGun:
			TNT1 A 0 {
				if (invoker.weaponStatus[I_FLAGS] & F_CHAMBER) {
					return ResolveState(NULL);
				}
				return ResolveState("NoMagOverlay");
			}
			GLKG F 1;
			Loop;

		NoMagOverlay:
			GLKG G 1;
			Loop;

		LayerGunBack:
			TNT1 A 1;
			Loop;

		NoHandsBack:
			Stop;

		LayerGunFire:
			GLKG G 2;
			Goto LayerGun;

		LayerGunBolt:
			GLKG I 3;
			Goto LayerGun;

		LayerReloadHands:
			TNT1 A 0;
			Goto Super::LayerReloadHands;
			
		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadMag:
			TNT1 A 0 {
				//A_Overlay(invoker.bLayerGun, "HandMagAnim");
			}
			Goto Super::UnloadMag;

		HandMagAnim:
			GLKG GH 2;
			Goto HandMagWait;

		HandMagWait:
			GLKG I 1;
			Loop;

		GunDummy:
			GLKU A -1;
			GLKU B -1;
			GLKU C -1;
			GLKU D -1;
			GLKU E -1;
			GLKU F -1;
			GLKU G -1;
			GLKU H -1;
			Stop;

		FlashDummy:
			GLFL A -1;
			GLFL B -1;
			GLFL C -1;
			GLFL D -1;
			Stop;


	}

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > 0) {
			if (barrelClass && miscClass) {
				return "GLKUG0", 1.;
			}
			else if (barrelClass) {
				return "GLKUE0", 1.;
			}
			else if (miscClass) {
				return "GLKUC0", 1.;
			}
			return "GLKUA0", 1.;
			//return bSpriteWithMag, 1.;
		}
		else {
			if (barrelClass && miscClass) {
				return "GLKUH0", 1.;
			}
			else if (barrelClass) {
				return "GLKUF0", 1.;
			}
			else if (miscClass) {
				return "GLKUD0", 1.;
			}
			return "GLKUB0", 1.;
			//return bSpriteWithoutMag, 1.;
		}
	}


}

class GlockLightOffset : MiscOffset {
	default {
		Offset.WeaponClass "Glock";
		Offset.WeaponOverlay "B_M16_Flashlight";
		Offset.OffX -6;
	}
}
