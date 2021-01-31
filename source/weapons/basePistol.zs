
class BasePistol : BaseStandardRifle {

	action state GetMagStatePistol() {
		if (invoker.chambered()) {
			return ResolveState("SpawnMag");
		}
		return ResolveState("SpawnNoMag");
		
	}
	
	override void InitializeWepStats (bool idfa) {
		weaponStatus[I_MAG] = bMagazineCapacity - 1;
		weaponStatus[I_FLAGS] |= F_CHAMBER;
		weaponspecial=0;
		//console.printf("%s %i", getClassName(), getBarrelSerialID());
		//setchamber();
	}	

	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		BHDWeapon basicWep = BHDWeapon(hdw);
		if (sb.hudLevel == 1) {
			int nextMag = sb.GetNextLoadMag(HDMagAmmo(hpl.findInventory(basicWep.bMagazineClass)));
			sb.DrawImage(basicWep.bMagazineSprite, (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (basicWep.BAmmoHudScale, basicWep.BAmmoHudScale));
			sb.DrawNum(hpl.CountInv(basicWep.bMagazineClass), -43, -8, sb.DI_SCREEN_CENTER_BOTTOM);
		}
		int ammoBarAmt = clamp(basicWep.magazineGetAmmo() % 999, 0, basicWep.bMagazineCapacity);
		sb.DrawWepNum(ammoBarAmt, basicWep.bMagazineCapacity);
		if (basicWep.chambered()) {
			sb.DrawWepDot(-16, -10, (3, 1));
			//ammoBarAmt++;
		}
		//sb.DrawNum(ammoBarAmt, -16, -22, sb.DI_SCREEN_CENTER_BOTTOM | sb.DI_TEXT_ALIGN_RIGHT, Font.CR_RED);
	}

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {

		PlayerInfo info = players[hpl.playernumber()];
		BHDWeapon basicWep = BHDWeapon(hdw);

		vector2 scc;
		vector2 bobb=bob*1.6;
		double dotoff = max(abs(bob.x), abs(bob.y));
//BHDWeapon.BLayerGun    100;
		int cx,cy,cw,ch;
		[cx,cy,cw,ch]=screen.GetClipRect();

		BasePistol ref = BasePistol(hdw);

		//console.printf("%i", hpl.player.getpsprite(ref.BLayerGun).frame);
		if(hpl.player.getpsprite(ref.BLayerGun).frame == 6){
			sb.SetClipRect(-10 + bob.x, -5 + bob.y, 20, 14, sb.DI_SCREEN_CENTER );
			scc=(0.7,0.8);
			bobb.y=clamp(bobb.y*1.1-3,-10,10);
		}else{
			sb.SetClipRect(-8 + bob.x, -4 + bob.y, 16, 10, sb.DI_SCREEN_CENTER );
			scc=(0.6,0.6);
			bobb.y=clamp(bobb.y,-8,8);
		}


		sb.drawImage(getFrontSightImage(hpl), getFrontSightOffsets() + bobb, sb.DI_SCREEN_CENTER | sb.DI_ITEM_TOP, alpha: 0.9, scale: scc);

		sb.SetClipRect(cx,cy,cw,ch);
		sb.drawimage(getBackSightImage(hpl), getBackSightOffsets() + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_TOP, scale:scc);


		//sb.drawImage("calib", (0, 0), sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.3);
	}

	action void B_SwapHandguns(){
		let mwt=SpareWeapons(findinventory("SpareWeapons"));
		if(!mwt){
			//setweaponstate("whyareyousmiling");
			return;
		}
		int pistindex=mwt.weapontype.find(invoker.getclassname());
		if(pistindex==mwt.weapontype.size()){
			//setweaponstate("whyareyousmiling");
			return;
		}
		A_WeaponBusy();

		array<string> wepstat;
		string wepstat2="";
		mwt.weaponstatus[pistindex].split(wepstat,",");
		for(int i=0;i<wepstat.size();i++){
			if(i)wepstat2=wepstat2..",";
			wepstat2=wepstat2..invoker.weaponstatus[i];
			invoker.weaponstatus[i]=wepstat[i].toint();
		}
		mwt.weaponstatus[pistindex]=wepstat2;
	}


	states {
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
					A_Overlay(invoker.bLayerGun, "LayerGunFire");
					A_Overlay(-500, "Flash");
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1 Offset (0, 44);
			#### B 0 Offset (0, 40){
				return ResolveState("Chamber");
			}


		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) ;//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_StartSound(invoker.BboltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
					//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				else {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
				}
				return ResolveState("ReloadEnd");
			}








		UnloadMag:
			#### A 1 Offset(0, 33);
			#### A 1 Offset(0, 34);
			#### A 1 Offset(0, 37);
			#### A 2 Offset(0, 39) {
				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				A_StartSound(invoker.bUnloadSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(0, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				
			}
			#### A 20 offset(0, 44) {
				
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
					A_StartSound("weapons/pocket", CHAN_WEAPON,CHANF_OVERLAP);
				}
				return ResolveState("MagOut");
			}

		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}

				A_StartSound("weapons/pocket", CHAN_WEAPON,CHANF_OVERLAP);
				A_SetTics(10);
				return ResolveState(NULL);
			}
			#### A 8 Offset(0, 45);
			#### A 2 Offset(0, 44);
			#### A 2 Offset(0, 43);
			#### A 8 Offset(0, 35) A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
			#### A 2 Offset(0, 43);
			#### A 1 Offset(0, 44) {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
				}
				return ResolveState("ReloadEnd");
			}

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
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
					return ResolveState(NULL);
				}
				//console.printf("noping");
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				A_Overlay(invoker.bLayerGun, "LayerGunBolt");
			}
			#### D 3 offset(0, 36) {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}


		ReloadEnd:
			#### A 2 Offset(0, 39);
			#### A 1 Offset(0, 37); // A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(0, 34);
			#### A 0 {
				return ResolveState("Chamber_Manual");
			}

		user1:
		altreload:
		swappistols:
			---- A 0 B_SwapHandguns();
			#### A 1 Offset(1, 40);
			#### A 1 Offset(4, 60);
			#### A 1 Offset(7, 80);
			#### A 1 Offset(11, 100);
			#### A 1 Offset(14, 120);		
			TNT1 A 3;
			goto nope;

	}
	
}