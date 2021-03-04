
/* Copy class of zombieman, but with parameters to change weapons and such */

class HumanoidBase : ZombieStormtrooper {
	
	property hWeaponClass: hWeaponClass;
	string hWeaponClass;

	property hBulletClass: hBulletClass;
	string hBulletClass;

	property hMaxMag: hMaxMag;
	int hMaxMag;

	property hMagazineClass: hMagazineClass;
	string hMagazineClass;

	property hSpentClass: hSpentClass;
	string hSpentClass;

	property hFireSound: hFireSound;
	string hFireSound;

	property hSilentFireSound : hSilentFireSound;
	string hSilentFireSound;

	default {
		//Translation "";
	}

	AttachmentManager mgr;

	bool silenced;
	bool scoped;
	bool shooting;

	int silId;
	Class<BaseBarrelAttachment> silClass;

	int sightId;
	Class<BaseSightAttachment> sightClass;

	override void postbeginplay(){
		HDMobMan.postbeginplay();
		mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		silenced = random(0, 2);
		scoped = random(0, 2);
		mag = hMaxMag;
		initializeAttachments();
		hdmobster.spawnmobster(self);
	}

	virtual void initializeAttachments() {}
	virtual void reloadStart() {
		magIsOut = true;
	}
	virtual void reloadFinish() {
		magIsOut = false;
	}
	bool magIsOut;

	override void deathdrop(){
		HDWeapon wp = HDWeapon(Spawn(hWeaponClass, pos));
		if (wp is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(wp);
			// Attach Silencer to weapon drop
			if (silId && silClass) {
				wep.setBarrelSerialId(silId);
				wep.barrelClass = silClass;
			}

			if (sightId && sightClass) {
				wep.setScopeSerialId(sightId);
				wep.scopeClass = sightClass;
			}
		}
		if (magIsOut) {
			wp.weaponStatus[I_MAG] = -1;
		}
		else {
			wp.weaponStatus[I_MAG] = mag;
		}
		wp.bdropped = true;
		wp.addz(40);
		wp.vel = vel + (frandom(-2,2),frandom(-2,2),1);
	}

	states {
		Spawn2:
			#### A 0 {
				A_Look();
				A_Recoil(frandom(-0.1, 0.1));
			}
			#### EEE 1 {
				A_SetTics(random(5, 17));
				A_Look();
			}
			#### E 1 {
				A_Recoil(frandom(-0.1, 0.1));
				A_SetTics(random(10, 40));
			}
			#### B 0 A_Jump(28, "SpawnGrunt");
			#### B 0 A_Jump(132, "SpawnSwitch");
			#### B 8 A_Recoil(frandom(-0.2, 0.2));
			Loop;

		SpawnGrunt:
			#### G 1{
				A_Recoil(frandom(-0.4, 0.4));
				A_SetTics(random(30, 80));
				if(!random(0, 7)) {
					A_StartSound(activesound,CHAN_VOICE);
				}
			}
			#### A 0 A_Jump(256,"Spawn2");

		SpawnSwitch:
			#### A 0 A_JumpIf(bAmbush, "spawnstill");
			#### A 0 A_Jump(256, "SpawnWander");

		SpawnStill:
			#### A 0 A_Look();
			#### A 0 A_Recoil(random(-1, 1) * 0.4);
			#### CD 5 A_SetAngle(angle + random(-4, 4));
			#### A 0 {
				A_Look();
				if(!random(0, 127)) {
					A_StartSound(activeSound, CHAN_VOICE);
				}
			}

		SpawnWander:
			#### CDAB 5 {
				HDMobAI.Wander(self, false);
			}
			#### A 0 {
				if (!random(0, 127)) {
					A_StartSound(activesound, CHAN_VOICE);
				}
			}
			#### A 0 A_Jump(64, "Spawn2");
			Loop;

		Missile:
			#### A 0 {
				if(!target) {
					return ResolveState("Spawn2");
				}

				double dt = distance3d(target);
				if(firemode==-2 && target && !random(0,39) && dt > 200 && dt < 1000) {
					return ResolveState("Frag");
				}
				return ResolveState(NULL);
			}
			#### A 0 A_JumpIf(mag < 1, "reload");
			#### A 0 A_JumpIfTargetInLOS(3, 120);
			#### CD 2 A_FaceTarget(90);
			#### E 1 A_SetTics(random(4,10)); //when they just start to aim,not for followup shots!
			#### A 0 A_JumpIfTargetInLOS("missile2");
			#### A 0 A_CheckLOF("see",
				CLOFF_JUMPNONHOSTILE | CLOFF_SKIPTARGET | CLOFF_JUMPOBJECT | CLOFF_MUSTBESOLID | CLOFF_SKIPENEMY,
				0,
				0,
				0,
				0,
				44,
				0);
			#### A 0 A_Jump(256, "Missile2");

		Missile2:
			#### A 0 {
				if (!target) {
					return ResolveState("Spawn2");
				}

				double enemydist = distance3d(target);
				if (enemydist < 200) {
					turnamount=50;
				}
				else if (enemydist<600) {
					turnamount=30;
				}
				else {
					turnamount=10;
				}
				return ResolveState(NULL);
			}
			#### A 0 A_Jump(256, "TurnToAim");

		TurnToAim:
			#### E 0 {
				shooting = true;
			}
			#### E 2 A_FaceTarget(turnAmount, turnAmount);
			#### A 0 A_JumpIfTargetInLOS(2);
			#### A 0 A_Jump(256, "See");
			#### A 0 A_JumpIfTargetInLOS(1, 10);
			Loop;
			#### E 1 {
				A_FaceTarget(turnAmount, turnAmount);
				A_SetTics(random(1, int(120 / clamp(turnAmount, 1, turnAmount + 1) + 4)));
				spread = frandom(0.12,0.27) * turnAmount;
			}
			#### A 0 A_Jump(256, "Shoot");

		Shoot:
			#### F 0 {
				shooting = true;
			}
			#### F 0 A_JumpIf(jammed, "jammed");
			#### F 1 Bright Light("SHOT") {
				if (mag < 1) {
					return ResolveState("OhForFucksSake");
				}
			
				pitch += frandom(0, spread) - frandom(0, spread);
				angle += frandom(0, spread) - frandom(0, spread);
				if (invoker.silenced && invoker.silClass) {
					A_StartSound(invoker.hSilentFireSound);
				}
				else {
					A_StartSound(invoker.hFireSound);
				}

				HDBulletActor.FireBullet(self, invoker.hBulletClass, speedfactor:1.0);
				A_SpawnItemEx(invoker.hSpentClass,
					cos(pitch) * 10,
					0,
					height - 8 - sin(pitch) * 10,
					vel.x,
					vel.y,
					vel.z,
					0,
					SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				mag--;
				return ResolveState(NULL);
			}

			#### E 2 {
				if (!fireMode || fireMode == -1 || fireMode > 3 || mag < 1) {
					if (fireMode > 2) {
						fireMode = 2;
						return ResolveState("PostShot");
					}
					else if (fireMode >= 2) {
						fireMode++;
						return ResolveState("Shoot");
					}
					spread++;
				}
				return ResolveState(NULL);
			}
			#### A 0 A_Jump(120, "Shoot");
			#### A 0 A_Jump(256, "PostShot");

		PostShot:
			#### F 0 {
				shooting = false;
			}
			#### E 5 {
				if (!random(0, 127)) {
					A_StartSound(activeSound, CHAN_VOICE);
					if (mag < 1) {
						return ResolveState("Reload");
					}

					spread = max(0, spread - 1);
					A_SetTics(random(2, 6));
				}
				return ResolveState(NULL);
			}
			#### E 3;
			#### E 0 A_JumpIfTargetInLOS(1);
			#### E 0 A_Jump(25, "CoverFire");
			#### E 0 A_FaceTarget(10, 10);
			#### E 0 A_Jump(30, "See");
			#### E 0 A_Jump(25, "CoverFire");

		CoverFire:
			#### E 1 A_SetTics(random(2, 12));
			#### E 0 {
				spread = 2;
			}
			#### E 0 A_Jump(90, "roam");
			#### E 0 A_JumpIfTargetInLOS("missile2");
			#### E 0 A_Jump(216, "Shoot");
			Loop;

		Frag:
			#### A 10 A_StartSound(seeSound, CHAN_VOICE);
			#### A 20 {
				A_StartSound("weapons/pocket", CHAN_WEAPON);
				A_FaceTarget(0, 0);
				pitch -= random(10, 50);
			}
			#### A 10 {
				A_SpawnItemEx(
					"HDFragSpoon",
					cos(pitch) * 4,
					-1,
					height - 6 - sin(pitch) * 4,
					cos(pitch) * cos(angle) * 4 + vel.x,
					cos(pitch) * sin(angle) * 4 + vel.y,
					sin(-pitch) * 4 + vel.z,
					0,
					SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				A_ZomFrag();
			}
			#### A 0 A_JumpIf(mag < 1, "Reload");
			#### A 0 A_Jump(256, "See");

		Jammed:
			#### E 8;
			#### E 0 A_Jump(128, "See");
			#### E 4 A_StartSound(random(0, 2) ? seeSound : painSound, CHAN_VOICE);
			---- A 0 A_Jump(256, "See");

		OhForFucksSake:
			#### E 8;
			#### E 0 A_Jump(256, "Reload");

		Reload:
			#### A 4 {
				reloadStart();
				A_StartSound("weapons/rifleclick2");
				bFrightened = true;
			}
			#### AA 1 {
				HDMobAI.Chase(self, "Melee", null);
			}
			#### A 0 {
				A_StartSound("weapons/rifleload");
				Name emptymag = invoker.hMagazineClass;
				HDMagAmmo.SpawnMag(self, emptyMag, 0);
			}
			#### BCD 2 {
				HDMobAI.Chase(self, "melee", null);
			}
			#### E 12 A_StartSound("Weapons/pocket", 8);
			#### E 8 A_StartSound("weapons/rifleload", 9);
			#### E 2 {
				A_StartSound("weapons/rifleclick2", 8);
				mag = invoker.hMaxMag;
				bFrightened = false;
				reloadFinish();
			}
			#### CCBB 2 {
				HDMobAI.wander(self, true);
			}
			#### A 0 A_Jump(256, "See");

		See:
			#### A 0 { 
				if (firemode >= 0) {
					fireMode = random(0, 2);
				}
			}
			#### A 0 A_Jump(256, "See2");

		See2:
			#### A 0 {
				if (mag < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(NULL);
			}
			#### AABBCCDD 2 {
				HDMobAI.chase(self);
			}
			#### A 0 {
				spread = 2;
			}
			#### A 0 A_JumpIfTargetInLOS("see");
			#### A 0 A_Jump(24, "roam");
			Loop;

		Roam:
			#### E 3 A_Jump(60, "roam2");
			#### E 0 { 
				spread = 1;
			}
			#### EEEE 1 A_Chase("Melee", "turnAround", CHF_DONTMOVE);
			#### E 0 {
				spread = 0;
			}
			#### EEEEEEEEEEEEE 1 A_Chase("melee", "turnAround", CHF_DONTMOVE);
			#### A 0 A_Jump(60, "Roam");
			#### A 0 A_Jump(256, "Roam2");

		Roam2:
			#### A 0 A_Jump(8, "see");
			#### A 5 {
				HDMobAi.chase(self);
			}
			#### BC 5 {
				HDMobAI.wander(self, true);
			}
			#### D 5 {
				HDMobAI.chase(self);
			}
			#### A 0 A_Jump(140, "Roam");
			#### A 0 A_AlertMonsters();
			#### A 0 A_JumpIfTargetInLOS("see");
			Loop;

		TurnAround:
			#### A 0 A_FaceTarget(15, 0);
			#### E 2 A_JumpIfTargetInLOS("missile2", 40);
			#### E 0 {
				spread = 3;
			}
			#### A 0 A_FaceTarget(15, 0);
			#### E 0 {
				spread = 6;
			}
			#### E 2 A_JumpIfTargetInLOS("missile2", 40);
			#### E 0 {
				spread = 4;
			}
			#### ABCD 3 { 
				HDMobAI.chase(self); 
			}
			#### A 0 A_Jump(256, "See");

		Melee:
			#### C 8 A_FaceTarget();
			#### D 4;
			#### E 4 {
				A_CustomMeleeAttack(random(3, 20), "weapons/smack", "", "none", randompick(0, 0, 0, 1));
				if (jammed && !random(0, 32)) {
					if (!random(0, 5)) {
						A_SpawnItemEx(
							"HDSmokeChunk",
							12,
							0,
							height - 12,
							4,
							frandom(-2,2),
							frandom(2,4));
					}
				}
			}
			#### E 3 A_JumpIfCloser(64, 2);
			#### E 4 A_FaceTarget(10, 10);
			#### A 0 A_Jump(256, "Missile2");
			#### A 4;
			#### A 0 A_Jump(256, "See");

		Pain:
			#### G 2;
			#### G 3 {
				A_Pain();
				if (!random(0, 10)) {
					A_AlertMonsters();
				}
			}
			#### G 0 {
				if (target && distance3d(target) < 100) {
					return ResolveState("See");
				}
				bFrightened = true;
				return ResolveState(NULL);
			}
			#### ABCD 2 {
				HDMobAI.Chase(self);
			}
			#### G 0 {
				bFrightened = false;
			}
			#### A 0 A_Jump(2566, "See");

		Death:
			#### H 5;
			#### I 5 A_Scream();
			#### JK 5;

		Dead:
			#### K 3 canraise { 
				if(abs(vel.z) < 2.) frame++; 
			}
			#### L 5 canraise { 
				if(abs(vel.z) >=2.) 
					return ResolveState("Dead");
				return ResolveState(NULL);
			}
			#### MN 5;
			Wait;

		XXXDeath:
			#### O 5;
			#### P 5 A_XScream();
			#### QRSTUV 5;
			#### W 0 A_Jump(256, "Xdead");

		XDeath:
			#### O 5;
			#### P 5{
				spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
				A_XScream();
			}
			#### QR 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			#### STUV 5;
			#### W 0 A_Jump(256, "XDead");

		xdead:
			#### V 3 canraise A_JumpIf(abs(vel.z) < 2., 1);
			#### W 5 canraise A_JumpIf(abs(vel.z) >= 2., "xdead");
			wait;

		raise:
			#### L 4 {
				jammed=false;
			}
			#### LK 6;
			#### JIH 4;
			#### H 0 A_Jump(256, "checkraise");

		ungib:
			#### U 12;
			#### T 8;
			#### SRQ 6;
			#### PONM 4;
			#### M 0 A_Jump(256, "checkraise");

	}

}

class ShotgunHumanoidBase : HumanoidBase {

	states {

		See:
			#### A 0 { 
				firemode = 0;
			}
			#### A 0 A_Jump(256, "See2");

		Shoot:
			#### F 0 A_JumpIf(jammed, "jammed");
			#### F 1 Bright Light("SHOT") {
				if (mag < 1) {
					return ResolveState("OhForFucksSake");
				}
			
				pitch += frandom(0, spread) - frandom(0, spread);
				angle += frandom(0, spread) - frandom(0, spread);
				A_StartSound(invoker.hFireSound);
				HDBulletActor.FireBullet(self, "HDB_wad");
				HDBulletActor.FireBullet(self, 
					invoker.hBulletClass, 
					spread: 6, 
					speedfactor: 1.0, 
					amount: 10);
				A_SpawnItemEx(invoker.hSpentClass,
					cos(pitch) * 10,
					0,
					height - 8 - sin(pitch) * 10,
					vel.x,
					vel.y,
					vel.z,
					0,
					SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				mag--;
				return ResolveState(NULL);
			}

			#### E 2 {
				spread++;
				return ResolveState("PostShot");
			}
			#### A 0 A_Jump(120, "Shoot");
			#### A 0 A_Jump(256, "PostShot");
	}
}