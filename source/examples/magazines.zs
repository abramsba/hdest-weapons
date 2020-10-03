


class B556Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk c_556_load_bulk;
		hdmagammo.magbulk c_m4_mag_bulk;
		hdpickup.refid B_556_MAG_REFID;
		tag "5.56x45mm magazine";
		inventory.pickupmessage "Picked up a 5.56x45mm NATO STANAG magazine.";
		Inventory.Icon "M4RCA0";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "M4RCA0", "BB56A7A3", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M4");
		itemsthatusethis.push("B_M4_M203");
	}

	states{
		spawn:
			M4RC A -1;
			stop;
		spawnempty:
			M4RC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B556MagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"B556Mag",0);
		destroy();
	}
}

class B556MagEmpty2 : B556Mag {
	default { -hdpickup.fitsinbackpack }
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let mag = B556Mag(Spawn("B556mag", pos, ALLOW_REPLACE));
				if (!mag) {
					return;
				}
				mag.SyncAmount();
				mag.mags[0] = 0;
			}
			stop;
	}
}

class BM249Mag : HDMagAmmo {
	default{
		hdmagammo.maxperunit 200;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk c_556_load_bulk;
		hdmagammo.magbulk c_m249_pouch_bulk;
		hdpickup.refid B_MF249_MAG_REFID;
		tag "5.56x45mm 200 round pouch";
		inventory.icon "M24CA0";
		inventory.pickupmessage "Picked up a 5.56x45mm 200 Round NATO STANAG magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M24CA0", "BB56A7A3", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M249");
	}

	states{
		spawn:
			M24C A -1;
			stop;
		spawnempty:
			M24C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class BM249MagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"BM249Mag",0);
		destroy();
	}
}

class B9mm_MP5K_MAG : HDMagAmmo {
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "HDPistolAmmo";
		hdmagammo.roundbulk c_9mm_load_bulk;
		hdmagammo.magbulk c_mp5_mag_bulk;
		hdpickup.refid B_MP5_MAG_REFID;
		tag "MP5 Magazine";
		inventory.icon "MP5CA0";
		inventory.pickupmessage "Picked up a MP5 magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "MP5CA0", "PBRSA0", "HDPistolAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_MP5");
		itemsthatusethis.push("B_MP5_M203");
	}

	states{
		spawn:
			MP5C A -1;
			stop;
		spawnempty:
			MP5C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}


class BMp5MagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"B9mm_MP5K_MAG",0);
		destroy();
	}
}

class BMp5MagEmpty2 : B9mm_MP5K_MAG {
	default {
		-hdpickup.fitsinbackpack
	}
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let mag = B9mm_MP5K_MAG(Spawn("B9mm_MP5K_MAG", pos, ALLOW_REPLACE));
				if (!mag) {
					return;
				}
				mag.SyncAmount();
				mag.mags[0] = 0;
			}
			stop;
	}
}

class BFauxDrum : HDMagAmmo {
	default {
		hdmagammo.maxperunit 20;
		hdmagammo.roundtype "HDShellAmmo";
		hdmagammo.roundbulk c_shell_load_bulk;
		hdmagammo.magbulk c_faux_drum_bulk;
		hdpickup.refid B_FAUX_DRUM_REFID;
		tag "Fauxtech Origin 12 Drum";
		inventory.icon "FOSCA0";
		inventory.pickupmessage "Picked up a Fauxtech Origin 12 drum.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "FOSCA0", "SHL1A0", "HDShellAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_FauxtechOrigin");
	}

	states{
		spawn:
			FOSC A -1;
			stop;
		spawnempty:
			FOSC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}

}

class BFauxDrumEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"BFauxDrum",0);
		destroy();
	}
}



class b762_m14_mag : HDMagAmmo {
	default {
		HDMagAmmo.MaxPerUnit 20;
		HDMagAmmo.RoundType "B762x51Ammo";
		HDMagAmmo.RoundBulk c_762_load_bulk;
		HDMagAmmo.MagBulk c_m14_mag_bulk;
		tag "7.62x51mm magazine";
		hdpickup.refid B_M14_MAG_REFID;
		Inventory.Icon "M14CA0";
		inventory.pickupmessage "Picked up a 7.62x51mm NATO magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M14CA0", "BF76A3A7", "B762x51Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_m14");
	}

	states{
		spawn:
			M14C A -1;
			stop;
		spawnempty:
			M14C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B762MagEmpty2 : b762_m14_mag {
	default {
		-hdpickup.fitsinbackpack
	}
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let mag = B762MagEmpty2(Spawn("B762MagEmpty2", pos, ALLOW_REPLACE));
				if (!mag) {
					return;
				}
				mag.SyncAmount();
				mag.mags[0] = 0;
			}
			stop;
	}
}


class B762MagEmpty:IdleDummy{

	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"b762_m14_mag",0);
		destroy();
	}
}


class GlockMagazine : HDMagAmmo {
	default{
		hdmagammo.maxperunit 15;
		hdmagammo.roundtype "HDPistolAmmo";
		hdmagammo.roundbulk c_van_9mm_bulk;
		hdmagammo.magbulk c_glock_mag_bulk;
		hdpickup.refid B_GLOCK_MAG_REFID;
		tag "Glock magazine";
		inventory.icon "GLKCA0";
		inventory.pickupmessage "Picked up a Glock magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "GLKCA0", "PBRSA0", "HDPistolAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_Glock");
	}

	states{
		spawn:
			GLKC A -1;
			stop;
		spawnempty:
			GLKC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class BGlockMagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"GlockMagazine",0);
		destroy();
	}
}

class BGlockMagEmpty2 : GlockMagazine {
	default {
		-hdpickup.fitsinbackpack
	}
	states {
		spawn:
			TNT1 A 0 NoDelay {
				let mag = GlockMagazine(Spawn("GlockMagazine", pos, ALLOW_REPLACE));
				if (!mag) {
					return;
				}
				mag.SyncAmount();
				mag.mags[0] = 0;
			}
			stop;
	}
}


class M107Magazine : HDMagAmmo {
	default{
		hdmagammo.maxperunit 10;
		hdmagammo.roundtype "B50BMGAmmo";
		hdmagammo.roundbulk c_van_9mm_bulk;
		hdmagammo.magbulk c_m107_mag_bulk;
		hdpickup.refid B_M107_MAG_REFID;
		tag "M107 magazine";
		inventory.icon "M17MA0";
		inventory.pickupmessage "Picked up a M107 magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M17MA0", "BG50A7A3", "B50BMGAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_m107");
	}

	states{
		spawn:
			M17M A -1;
			stop;
		spawnempty:
			M17M B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}



class BRpgRocket : HDMagAmmo {
	default{
		+hdpickup.fitsinbackpack
		hdmagammo.maxperunit 1;
		hdmagammo.roundtype "HEATAmmo";
		hdmagammo.roundbulk c_rpg_charge_bulk;
		hdmagammo.magbulk c_rpg_case_bulk;
		hdpickup.refid B_RPG_ROCKET_REFID;
		tag "RPG Rocket";
		inventory.pickupmessage "Picked up a RPG rocket.";
		Inventory.Icon "RPGRA0";
		scale 0.3;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "RPGRA6A4", "ROCKA0", "HEATAmmo", 0.8;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_RPGLauncher");
	}

	states{
		spawn:
			RPGR A -1;
			stop;
		spawnempty:
			RPGR B -1;
			stop;
	}
}











class BMagazineBox : HDUPK {

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
		"B556Mag",
		"BM249Mag",
		"B9mm_MP5K_MAG",
		"BFauxDrum",
		"b762_m14_mag",
		"GlockMagazine"
	};

	states {
		spawn:
			BBOX C -1;
			stop;
		grab:
		tap:
			---- A 0 {
				invoker.vel += (0, 0, 4);
			}
			---- A 10;
			---- A 0 {
				int rng_count = random(1, 5);
				for (int i = 0; i < rng_count; i++) {
					string clsname = classNames[random(0, 5)];
					let mag = HDMagAmmo(Actor.Spawn(clsname, invoker.pos));
					mag.vel += (random(-2, 2), random(-2, 2), random(4, 8));
					if (b_spawn_no_ammo || mag is "BM249Mag" || mag is "BFauxDrum") {
						mag.SyncAmount();
						mag.mags[0] = 0;
					}
				}

			}
			stop;
	}

}