
class Rpg_Random_Giver : BWeaponGiver {
	override String getWeaponClass() {
		return "B_RpgLauncher";
	}
	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("BRpgRocket", randomPos);
		}
	}
}

class Rpg_Noammo_Giver : Rpg_Random_Giver {
	override void SpawnMagazines() {}
}

class Glock_Random_Giver : BWeaponGiver {
	override String getWeaponClass() {
		return "B_Glock";
	}
	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return "";
		}
		String config_args = "";
		bool hasSilencer = (random(0, 100)) > 50;
		if (hasSilencer) {
			config_args = "ba3";
		}
		return config_args;
	}
	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("GlockMagazine", randomPos);
		}
	}
}

class Glock_Random_Noammo_Giver : Glock_Random_Giver {
	override void SpawnMagazines() {}
}

class Glock_Random_Noammo_Noatta_Giver : Glock_Random_Noammo_Giver {
	override string getConfigLine() {
		return "";
	}
}

class Fauxtech_Random_Giver : BWeaponGiver {
	static const int sight_ids[] = { 3, 4, 5, 6, 7 };
	override String getWeaponClass() {
		return "B_FauxtechOrigin";
	}
	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return "bs3";
		}

		bool hasSilencer = (random(0, 100)) > 50;
		bool hasLight = (random(0, 100)) > 50;
		let config_args = string.format("bs%i", sight_ids[random(0, 4)]);
		if (hasSilencer) {
			config_args = string.format("%s ba1", config_args);
		}
		if (hasLight) {
			config_args = string.format("%s bm1", config_args);
		}
		return config_args;
	}
	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("BFauxDrum", randomPos);
		}
	}
}

class fauxtech_random_noammo_giver : Fauxtech_Random_Giver {
	override void SpawnMagazines() {
		
	}
}

class Fauxtech_noammo_noatta_giver : fauxtech_random_noammo_giver {
	override string getConfigLine() { return "bs3"; }	
}

class M4_Random_Giver : BWeaponGiver {
	static const int sight_ids[] = { 1, 2 };
	int isGl;

	override String getWeaponClass() {
		isGl = random(0, 100) > 50;
		if (isGl) {
			return "B_M4_M203";
		}
		return "B_M4";
	}

	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return string.format("bs%i", sight_ids[random(0, 1)]);
		}

		bool hasSilencer = (random(0, 100)) > 50;
		bool hasLight = (random(0, 100)) > 50;
		let config_args = string.format("bs%i", sight_ids[random(0, 1)]);
		if (hasSilencer) {
			config_args = string.format("%s ba1", config_args);
		}
		if (hasLight) {
			config_args = string.format("%s bm1", config_args);
		}
		return config_args;
	}

	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("B556Mag", randomPos);
		}
		if (isGl) {
			amt = random(0, 3);
			for (int i = 0; i < amt; i++) {
				let randomPos = pos + (random(-8, 8), random(-8, 8));
				Spawn("HDRocketAmmo", randomPos);
			}
		}
	}

}

class M4_Random_Noammo_Giver : M4_Random_Giver {
	override void SpawnMagazines() {}
}

class M4_noammo_atta_giver : M4_Random_Noammo_Giver {
	override string getconfigline() { 
		return (random(0, 100) >= 50) ? "bs2" : "bs1";
	}
}

class m4_replacer : hdweapon {
	static const int sight_ids[] = { 1, 2, 4, 5, 6, 7 };
	states {
		spawn:
			TNT1 A 0 NoDelay {
				int rng2 = 0;
				bool rng = random(0, 100) > 50;
				let gun = BHDWeapon(Actor.Spawn(rng ? "B_m4" : "B_M4_m203", invoker.pos, ALLOW_REPLACE));
				AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
				if (b_attach_spawn_mode == 2) {

					rng2 = random(1, 2);
					gun.setScopeSerialId(rng2);
					gun.scopeClass = mgr.getScopeClass(rng2);

					rng = random(0, 100) > 50;
					if (rng) {
						gun.setMiscSerialId(B_FLASHLIGHT_ID);
						gun.miscClass = mgr.getMiscClass(B_FLASHLIGHT_ID);
					}
					rng = random(0, 100) > 50;
					if (rng) {
						gun.setBarrelSerialId(B_556_SILENCER_ID);
						gun.barrelClass = mgr.getBarrelClass(B_556_SILENCER_ID);
					}
				}
				else {
					rng2 = random(1, 2);
					gun.setScopeSerialId(rng2);
					gun.scopeClass = mgr.getScopeClass(rng2);
				}
				
			}
			Stop;
	}
}

class glock_replacer : hdweapon {
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let gun = BHDWeapon(Actor.Spawn("B_Glock", invoker.pos, ALLOW_REPLACE));
				if (b_attach_spawn_mode == 2) {
					AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
					int rng = random(0, 100) > 50;
					if (rng) {
						gun.setBarrelSerialId(B_9MM_SILENCER_ID);
						gun.barrelClass = mgr.getBarrelClass(B_9MM_SILENCER_ID);
					}
				}
			}
			Stop;
	}
}

class mp5_replacer : hdweapon {
	static const int sight_ids[] = { 4, 5, 6, 7 };
	states {
		spawn:
			TNT1 A 0 NoDelay {
				int rng = random(0, 100) > 50;
				let gun = BHDWeapon(Actor.Spawn(rng ? "B_mp5" : "B_mp5_m203", invoker.pos, ALLOW_REPLACE));
				if (b_attach_spawn_mode == 2) {
					AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
					rng = random(0, 100) > 50;
					if (rng) {
						int scopeId = invoker.sight_ids[random(0, invoker.sight_ids.size() - 1)];
						gun.setScopeSerialId(invoker.sight_ids[random(0, invoker.sight_ids.size() - 1)]);
						gun.scopeClass = mgr.getScopeClass(scopeId);
					}
					rng = random(0, 100) > 50;
					if (rng) {
						gun.setMiscSerialId(B_FLASHLIGHT_ID);
						gun.miscClass = mgr.getMiscClass(B_FLASHLIGHT_ID);
					}
					rng = random(0, 100) > 50;
					if (rng) {
						gun.setBarrelSerialId(B_9MM_SILENCER_ID);
						gun.barrelClass = mgr.getBarrelClass(B_9MM_SILENCER_ID);
					}
				}
			}
			Stop;
	}
}

class M14_Random_Giver : BWeaponGiver {
	static const int sight_ids[] = { 0, 4, 5, 6, 7 };
	override String getWeaponClass() {
		return "B_M14";
	}
	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return "";
		}
		bool hasSilencer = (random(0, 100)) > 50;
		bool hasLight = (random(0, 100)) > 50;
		int sight_id = sight_ids[random(0, 4)];
		let config_args = "";
		if (sight_id > 0) {
			config_args = string.format("bs%i", sight_id);
		}

		if (hasSilencer) {
			config_args = string.format("%s ba4", config_args);
		}
		if (hasLight) {
			config_args = string.format("%s bm1", config_args);
		}
		return config_args;
	}
	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("b762_m14_mag", randomPos);
		}
	}
}

class M14_random_noammo_giver : M14_Random_Giver {
	override void SpawnMagazines() {}
}

class m14_noammo_noatta_giver : M14_random_noammo_giver {
	override string getConfigLine() { return ""; }
}

class m107_with_scope : BWeaponGiver {
	override String getWeaponClass() {
		return "B_M107";
	}
	override String getConfigLine() {
		return string.format("bs8");
	}
}


class m107_with_acog : BWeaponGiver {
	override String getWeaponClass() {
		return "B_M107";
	}
	override String getConfigLine() {
		return string.format("bs4");
	}
}

class M249_Random_Giver : BWeaponGiver {
	static const int sight_ids[] = { 0, 4, 5, 6, 7 };
	override String getWeaponClass() {
		return "B_M249";
	}
	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return "";
		}
		bool hasSilencer = (random(0, 100)) > 50;
		bool hasLight = (random(0, 100)) > 50;
		int sight_id = sight_ids[random(0, 4)];
		let config_args = "";
		if (sight_id > 0) {
			config_args = string.format("bs%i", sight_id);
		}
		
		if (hasSilencer) {
			config_args = string.format("%s ba4", config_args);
		}
		if (hasLight) {
			config_args = string.format("%s bm1", config_args);
		}
		return config_args;
	}
	override void SpawnMagazines() {
	}
}

class M249_random_noammo_giver : M249_Random_Giver {
}

class M249_noammo_noatta_giver : M249_Random_Giver {
	override void SpawnMagazines() {}
	override String getConfigLine() { return ""; }
}


class MP5_Random_Giver : BWeaponGiver {
	static const int sight_ids[] = { 0, 4, 5, 6, 7 };
	bool isGl;
	override String getWeaponClass() {
		isGl = (random(0, 100)) > 50;
		if (isGl) {
			return "B_MP5_M203";
		}
		return "B_MP5";
	}
	override String getConfigLine() {
		if (b_attach_spawn_mode == 1) {
			return "";
		}
		bool hasSilencer = (random(0, 100)) > 50;
		bool hasLight = (random(0, 100)) > 50;
		int sight_id = sight_ids[random(0, 4)];
		let config_args = "";
		if (sight_id > 0) {
			config_args = string.format("bs%i", sight_id);
		}
		if (hasSilencer) {
			config_args = string.format("%s ba1", config_args);
		}
		if (hasLight) {
			config_args = string.format("%s bm1", config_args);
		}
		return config_args;
	}

	override void SpawnMagazines() {
		int amt = random(0, 3);
		for (int i = 0; i < amt; i++) {
			let randomPos = pos + (random(-8, 8), random(-8, 8));
			Spawn("B9mm_MP5K_MAG", randomPos);
		}
		if (isGl) {
			amt = random(0, 3);
			for (int i = 0; i < amt; i++) {
				let randomPos = pos + (random(-8, 8), random(-8, 8));
				Spawn("HDRocketAmmo", randomPos);
			}
		}
	}	
}

class mp5_random_noammo_giver : mp5_random_giver {
	override void SpawnMagazines() {}
}

class mp5_noammo_noatta_giver : mp5_random_noammo_giver {
	override String getConfigLine() {
		return "";
	}
}

class RandomBryanPickup : HDInvRandomSpawner {
	default {
		dropitem "RandomMagPickup", 256, 1;
		dropitem "RandomAmmoPickup", 256, 1;
	}
}

class RandomMagPickup : HDInvRandomSpawner {
	default {
		dropitem "B556Mag",256,1;
		dropitem "GlockMagazine",256,1;
		dropitem "B9mm_MP5K_MAG",256,1;
		dropitem "BFauxDrum",256,1;
		dropitem "b762_m14_mag",256,1;
		dropitem "BM249Mag",256,1;
		dropitem "BAKM_762Mag",256,1;
		dropitem "BAK_545Mag",256,1;
	}
}

class RandomAmmoPickup : HDInvRandomSpawner {
	default {
		dropitem "B_556_Box",256,1;
		dropitem "B_762_Box",256,1;
		dropitem "B_545_Box",256,1;
		dropitem "B_762sov_Box",256,1;
		dropitem "HD9mBoxPickup",256,1;
		dropitem "ShellBoxPickup",256,1;
	}
}

class RandomAttachmentPickup : HDInvRandomSpawner {
	default {
		dropitem "B_M4_RearSight", 256, 1;
		dropitem "B_M4_CarrySight", 256, 1;
		dropitem "B_Faux_Sight", 256, 1;
		dropitem "B_ACOG_Red", 256, 1;
		dropitem "B_Sight_CRdot", 256, 1;
		dropitem "B_Sight_Holo_Red", 256, 1;
		dropitem "B_Reflex_Red", 256, 1;
	}
}

class RandomWeaponPickup : HDInvRandomSpawner {
	default {
		dropitem "M4_Random_Giver", 256, 1;
		dropitem "M14_Random_Giver", 256, 1;
		dropitem "MP5_Random_Giver", 256, 1;
		dropitem "Glock_Random_Giver", 256, 1;
		dropItem "M249_Random_Giver", 256, 1;
		dropItem "Rpg_Random_Giver", 256, 1;
		dropItem "B_AKM", 256, 1;
		dropItem "B_AKS74U", 256, 1;
	}
}

class RandomEmptyWeaponPickup : HDInvRandomSpawner {
	default {
		dropitem "B_Glock_Empty", 256, 1;
		dropitem "B_MP5_Empty", 256, 1;
		dropitem "B_M4_Empty", 256, 1;
		dropitem "B_M14_Empty", 256, 1;
		dropitem "B_M249_Empty", 256, 1;
		dropitem "B_RPG_Empty", 256, 1;
	}
}

class RandomResourcePickup : HDInvRandomSpawner {
	default {
		dropitem "B_GunPowderBag", 256, 1;
		dropitem "B_LeadRock", 256, 1;
		dropitem "B_BrassSheets", 256, 1;
	}
}

class RandomSmallResourcePickup : HDInvRandomSpawner {
	default {
		dropitem "B_GunPowder", 256, 1;
		dropitem "B_Lead", 256, 1;
		dropitem "B_Brass", 256, 1;
	}
}

class RandomCraftingBench : HDInvRandomSpawner {
	default {
		dropitem "B_BallCrafter", 256, 1;
		dropitem "B_CaseCrafter", 256, 1;
		dropitem "B_BulletAssembler", 256, 1;
		dropitem "B_RocketAssembler", 256, 1;
	}
}

class EmptySpawner : IdleDummy {
	virtual string getGun() { return ""; }
	virtual int magLim() { return 0; }
	virtual int topLim() { return 0; }
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let gun = BHDWeapon(Spawn(invoker.getGun(), pos, ALLOW_REPLACE));
				if (!gun) {
					return;
				}

				bool emptyRng = random(0, 100) > 50;
				if (!emptyRng) {
					gun.spawnEmpty = true;
					gun.weaponStatus[I_MAG] = invoker.magLim();
				}
				else {
					gun.weaponStatus[I_MAG] = random(1, invoker.topLim());
				}
			}
			stop;
	}
}

class B_Glock_Empty : EmptySpawner {
	override string getGun() { return "B_Glock"; }
	override int topLim() { return 15; }
}

class B_MP5_Empty : EmptySpawner {
	override string getGun() { 
		return random(0, 100) > 50 ? "B_MP5_M203" : "B_MP5"; 
	}
	override int topLim() { return 30; }
}

class B_M4_Empty : B_M4 {
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let gun = B_M4(Spawn("B_m4", pos, ALLOW_REPLACE));
				if (!gun) {
					return;
				}

				bool emptyRng = random(0, 100) > 50;
				if (!emptyRng) {
					gun.spawnEmpty = true;
					gun.weaponStatus[I_MAG] = 0;
				}
				else {
					gun.weaponStatus[I_MAG] = random(1, 30);
				}



				gun.setStateLabel("Spawn");

			}
			stop;
	}
}

class B_Fauxtech_Empty : EmptySpawner {
	override string getGun() { return "B_FauxtechOrigin"; }
	override int topLim() { return 20; }
}

class B_M14_Empty : EmptySpawner {
	override string getGun() { return "B_M14"; }
	override int topLim() { return 20; }
}

class B_M249_Empty : EmptySpawner {
	override string getGun() { 
		return "B_M249"; 
	}
	override int topLim() { return 200; }
}

class B_RPG_Empty : EmptySpawner {
	override string getGun() { return "B_RPGLauncher"; }
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let gun = B_RPGLauncher(Spawn(invoker.getGun(), pos, ALLOW_REPLACE));
				gun.setStateLabel("Spawn");
				if (!gun) {
					return;
				}
				if (gun is "BaseAltRifle") {
					//console.printf("Remove Grenade");
				}
				gun.spawnEmpty = true;
				gun.weaponStatus[I_MAG] = invoker.magLim();
			}
			stop;
	}
}




class BAttachmentBox : HDUPK {

	default {
		+shootable
		+noblood
		+nopain
		+ghost
		+lookallaround
		+nofear
		scale 0.6;
		height 8;
		radius 12;
		health 100;
		mass 120;
		meleerange 42;
		radiusdamagefactor 0.5;
		obituary "%o has seen the true power of the level 1 warrior.";
		tag "Bryan's Resource Box";
	}

	static const string classNames[] = {
		"B_M16_Silencer",
		"B_M14_Silencer",
		"GlockSilencer",
		"FosSilencer",
		"FosImprovedChoke",
		"FosModifiedChoke",
		"FosFullChoke",
		"B_M16_Flashlight",
		"B_M4_RearSight",
		"B_M4_CarrySight",
		"B_Faux_Sight",
		"B_ACOG_Red",
		"B_Sight_CRdot",
		"B_Sight_Holo_Red",
		"B_Reflex_Red",
		"B_Scope_10x"
	};

	override bool OnGrab(actor grabber){
		setstatelabel("tap");
		return false;
	}

	states {
		spawn:
			BBOX D -1;
			stop;
		tap:
			---- A 0 {
				invoker.vel += (0, 0, 4);
			}
			---- A 10;
			---- A 0 {
				int rng_count = random(1, 3);
				for (int i = 0; i < rng_count; i++) {
					string clsname = classNames[random(0, 15)];
					let mag = Actor.Spawn(clsname, invoker.pos);
					mag.vel += (random(-2, 2), random(-2, 2), random(4, 8));
				}

			}
			stop;
	}

}