
class B_BallCrafter : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the ball crafter.";
		scale 0.5;
		hdweapon.refid "bcr";
		tag "Ball crafter";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "CFBNC0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Ball crafter", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int leadNeeded = 2;
		int brassNeeded = 1;

		if (mode == 0) {
			sb.drawString(sb.psmallfont, "Mode: 5.56mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}
		else if (mode == 1) {
			sb.drawString(sb.psmallfont, "Mode: 7.62mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
			leadNeeded = 3;
			brassNeeded = 2;
		}
		else if (mode == 2) {
			sb.drawString(sb.psmallfont, "Mode: .50 BMG", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_CYAN);
			leadNeeded = 25;
			brassNeeded = 10;
		}

		let leadCount = hpl.CountInv("B_Lead");
		let brassCount = hpl.CountInv("B_Brass");

		sb.drawString(sb.psmallfont, ""..leadNeeded, (-25, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, ""..brassNeeded, (15, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);

		sb.drawImage("BBBGC0", (-20, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawImage("BBBGE0", (20, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		sb.drawString(sb.psmallfont, ""..leadCount, (-25, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, leadCount >= leadNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..brassCount, (15, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, brassCount >= brassNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);

	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."     Create ball\n"
		..WEPHELP_RELOAD.."   (Hold) Place into inventory\n"
		..WEPHELP_ALTFIRE.."  Switch ball type\n";
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {
				int leadNeeded = 2;
				int brassNeeded = 1;
				string ballClass = "B_556Ball";
				if (invoker.mode == 1) {
					leadNeeded = 3;
					brassNeeded = 2;
					ballClass = "B_762Ball";
				}
				else if (invoker.mode == 2) {
					leadNeeded = 25;
					brassNeeded = 10;
					ballClass = "B_50BmgBall";
				}

				int leadCount = invoker.owner.CountInv("B_Lead");
				int brassCount = invoker.owner.CountInv("B_Brass");
				if (leadCount >= leadNeeded && brassCount >= brassNeeded) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					if (PressingReload()) {
						invoker.owner.GiveInventory(ballClass, 1);
					}
					else {
						A_SpawnItemEx(ballClass, 10, 0, height - 12, 0, 0, 0);
					}
					invoker.owner.TakeInventory("B_Lead", leadNeeded);
					invoker.owner.TakeInventory("B_Brass", brassNeeded);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode += 1;
				if (invoker.mode > 2) {
					invoker.mode = 0;
				}
				//invoker.mode = invoker.mode == 0 ? 1 : 0;
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			CFBN C -1;
			Stop;
	}

}



class B_CaseCrafter : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the case crafter.";
		scale 0.5;
		hdweapon.refid "ccr";
		tag "Case crafter";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "CFBNB0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Case crafter", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int brassNeeded = 2;
		if (mode == 0) {
			sb.drawString(sb.psmallfont, "Mode: 5.56x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}
		else if (mode == 1) {
			sb.drawString(sb.psmallfont, "Mode: 7.62x51mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
			brassNeeded = 3;
		}
		else if (mode == 2) {
			sb.drawString(sb.psmallfont, "Mode: .50 BMG", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_CYAN);
			brassNeeded = 15;
		}

		let brassCount = hpl.CountInv("B_Brass");

		sb.drawString(sb.psmallfont, ""..brassNeeded, (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawImage("BBBGE0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawString(sb.psmallfont, ""..brassCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, brassCount >= brassNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);

	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."     Create case\n"
		..WEPHELP_RELOAD.."   (Hold) Place into inventory\n"
		..WEPHELP_ALTFIRE.."  Switch case type\n";
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {
				int brassNeeded = 2;
				string caseClass = "B556Brass";
				if (invoker.mode == 1) {
					brassNeeded = 3;
					caseClass = "B762x51Brass";
				}
				else if (invoker.mode == 2) {
					brassNeeded = 15;
					caseClass = "B50BMGBrass";
				}

				int brassCount = invoker.owner.CountInv("B_Brass");
				if (brassCount >= brassNeeded) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					if (PressingReload()) {
						invoker.owner.GiveInventory(caseClass, 1);
					}
					else {
						A_SpawnItemEx(caseClass, 10, 0, height - 12, 0, 0, 0);
					}

					invoker.owner.TakeInventory("B_Brass", brassNeeded);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode += 1;
				if (invoker.mode > 2) {
					invoker.mode = 0;
				}
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			CFBN B -1;
			Stop;
	}

}


class B_BulletAssembler : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the bullet assembler.";
		scale 0.5;
		hdweapon.refid "asm";
		tag "Bullet Assembler";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "CFBND0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Bullet Assembler", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int powderRequired = 2;

		int powderCount = hpl.countinv("B_GunPowder");
		int cases = 0;
		int balls = 0;
		string caseClass = "B556Brass";
		string ballClass = "B_556Ball";
		string caseSprite = "BF56A7A3";
		string ballSprite = "B56TA0";


		if (mode == 1) {
			powderRequired = 3;
			caseClass = "B762x51Brass";
			caseSprite = "BB76A3A7";
			ballClass = "B_762Ball";
			ballSprite = "B76TA0";
			sb.drawString(sb.psmallfont, "Mode: 7.62x51mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
		}
		else if (mode == 2) {
			powderRequired = 15;
			caseClass = "B50BMGBrass";
			caseSprite = "BC50A7A3";
			ballClass = "B_50BmgBall";
			ballSprite = "B50TA0";
			sb.drawString(sb.psmallfont, "Mode: .50 BMG", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_CYAN);
		}
		else if (mode == 0) {
			sb.drawString(sb.psmallfont, "Mode: 5.56x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}

		sb.drawString(sb.psmallfont, "1", (-30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, ""..powderRequired, (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, "1", (30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		
		sb.drawImage(caseSprite, (-30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (3, 3));
		sb.drawImage("BBBGA0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawImage(ballSprite, (30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		int caseCount = hpl.countinv(caseClass);
		int ballCount = hpl.countinv(ballClass);

		sb.drawString(sb.psmallfont, ""..caseCount, (-30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..powderCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..ballCount, (30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."     Assemble round\n"
		..WEPHELP_RELOAD.."   (Hold) Place into inventory\n"
		..WEPHELP_ALTFIRE.."  Switch round type\n";
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {

				int powderRequired = 2;
				int powderCount = invoker.owner.countinv("B_GunPowder");
				int cases = 0;
				int balls = 0;
				string caseClass = "B556Brass";
				string ballClass = "B_556Ball";
				string caseSprite = "BF56A7A3";
				string ballSprite = "B56TA0";
				string bulletClass = "B556Ammo";
				if (invoker.mode == 1) {
					powderRequired = 3;
					caseClass = "B762x51Brass";
					caseSprite = "BB76A3A7";
					ballClass = "B_762Ball";
					ballSprite = "B76TA0";
					bulletClass = "B762x51Ammo";
				}
				else if (invoker.mode == 2) {
					powderRequired = 15;
					caseClass = "B50BMGBrass";
					caseSprite = "BC50A7A3";
					ballClass = "B_50BmgBall";
					ballSprite = "B50TA0";
					bulletClass = "B50BMGAmmo";
				}

				int caseCount = invoker.owner.countinv(caseClass);
				int ballCount = invoker.owner.countinv(ballClass);

				if (caseCount >= 1 && ballCount >= 1 && powderCount >= powderRequired) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					if (PressingReload()) {
						invoker.owner.GiveInventory(bulletClass, 1);
					}
					else {
						A_SpawnItemEx(bulletClass, 10, 0, height - 12, 0, 0, 0);
					}
					invoker.owner.TakeInventory(caseClass, 1);
					invoker.owner.TakeInventory(ballClass, 1);
					invoker.owner.TakeInventory("B_GunPowder", powderRequired);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode += 1;
				if (invoker.mode > 2) {
					invoker.mode = 0;
				}
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			CFBN D -1;
			Stop;
	}

}

class B_RocketAssembler : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the rocket assembler.";
		scale 0.5;
		hdweapon.refid "rsm";
		tag "Rocket Assembler";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "CFBNA0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Rocket Assembler", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int powderCount  = hpl.countInv("B_GunPowder");
		int leadCount    = hpl.countInv("B_Lead");
		int grenadeCount = hpl.countInv("HDFragGrenadeAmmo"); // FRAGA0

		int powderRequired  = 5;
		int leadRequired    = 2;

		if (mode == 1) {
			sb.drawString(sb.psmallfont, "Mode: Rocket Grenade", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, FONT.CR_RED);
			sb.drawString(sb.psmallfont, "5", (-30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE); // powder
			sb.drawString(sb.psmallfont, "2", (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);   // lead
			sb.drawString(sb.psmallfont, "1", (30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);  // grenade
			sb.drawImage("BBBGA0", (-30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (2, 2));
			sb.drawImage("BBBGC0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (3, 3));
			sb.drawImage("FRAGA0", (30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
			sb.drawString(sb.psmallfont, ""..powderCount, (-30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, powderCount >= 5 ? Font.CR_GREEN : Font.CR_DARKGRAY); // powder
			sb.drawString(sb.psmallfont, ""..leadCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, leadCount >= 2 ? Font.CR_GREEN : Font.CR_DARKGRAY);   // lead
			sb.drawString(sb.psmallfont, ""..grenadeCount, (30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, grenadeCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);  // grenade

		}
		else {
			sb.drawString(sb.psmallfont, "Mode: RPG HEAT Rocket", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, FONT.CR_GREEN);
			sb.drawString(sb.psmallfont, "20", (-15, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE); // powder
			sb.drawString(sb.psmallfont, "10", (15, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);  // lead
			sb.drawImage("BBBGA0", (-15, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (2, 2));
			sb.drawImage("BBBGC0", (15, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (3, 3));
			sb.drawString(sb.psmallfont, ""..powderCount, (-15, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, powderCount >= 20 ? Font.CR_GREEN : Font.CR_DARKGRAY); // powder
			sb.drawString(sb.psmallfont, ""..leadCount, (15, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, leadCount >= 10 ? Font.CR_GREEN : Font.CR_DARKGRAY);   // lead
		}
	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."     Assemble rocket\n"
		..WEPHELP_RELOAD.."   (Hold) Place into inventory\n"
		..WEPHELP_ALTFIRE.."  Switch rocket type\n";
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 0 {
				if (invoker.mode == 0) {
					return ResolveState("MakeHeat");
				}
				return ResolveState("MakeGrenade");
			}

		MakeHeat:
			TNT1 A 5;
			TNT1 A 1 {
				int powderCount = invoker.owner.countinv("B_GunPowder");
				int leadCount = invoker.owner.countinv("B_Lead");

				if (powderCount >= 20 && leadCount >= 10) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					invoker.owner.TakeInventory("B_GunPowder", 20);
					invoker.owner.TakeInventory("B_Lead", 10);
					return ResolveState(NULL);
				}
				else {
					return ResolveState("Ready");
				}
			}
			TNT1 A 20 {
				if (PressingReload()) {
					invoker.owner.GiveInventory("BRpgRocket", 1);
				}
				else {
					A_SpawnItemEx("BRpgRocket", 10, 0, height - 12, 0, 0, 0);
				}
			}
			TNT1 A 1 {
				A_StartSound("crafting/motor/ready", CHAN_WEAPON, CHANF_OVERLAP);
			}
			Goto Ready;


		MakeGrenade:
			TNT1 A 5;
			TNT1 A 1 {
				int powderCount = invoker.owner.countinv("B_GunPowder");
				int leadCount = invoker.owner.countinv("B_Lead");
				int grenadeCount = invoker.owner.countinv("HDFragGrenadeAmmo");

				if (powderCount >= 5 && leadCount >= 2 && grenadeCount >= 1) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					invoker.owner.TakeInventory("B_GunPowder", 5);
					invoker.owner.TakeInventory("B_Lead", 2);
					invoker.owner.TakeInventory("HDFragGrenadeAmmo", 1);
					return ResolveState(NULL);
				}
				else {
					return ResolveState("Ready");
				}
			}
			TNT1 A 5 {
				if (PressingReload()) {
					invoker.owner.GiveInventory("HDRocketAmmo", 1);
				}
				else {
					A_SpawnItemEx("HDRocketAmmo", 10, 0, height - 12, 0, 0, 0);
				}
			}
			TNT1 A 1 {
				A_StartSound("crafting/motor/ready", CHAN_WEAPON, CHANF_OVERLAP);
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode = invoker.mode == 0 ? 1 : 0;
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			CFBN A -1;
			Stop;
	}

}