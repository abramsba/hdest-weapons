const UAS_HDLD_556BOX="5nb";
const UAS_HDLD_762BOX="7nb";
const UAS_HDLD_545BOX="5rb";
const UAS_HDLD_762sovBOX="7rb";
const UAS_HDLD_50BMGBOX="50b";
///const UAS_HDLD_RPGBOX="rpb";

class UaS_Bryans_AmmoBox : HDMagAmmo {
	default {
		HDMagAmmo.extracttime 1;
		HDMagAmmo.inserttime 2;
		HDMagAmmo.MagBulk 2;
	}
}

class UaS_556Box : UaS_Bryans_AmmoBox {
	default {
		scale 0.5;
		HDMagAmmo.MaxPerUnit 100;
		HDMagAmmo.RoundType "B556Ammo";
		HDMagAmmo.RoundBulk c_556_load_bulk;
		tag "Reusable box 5.56x45mm box";
		Inventory.PickupMessage "Picked up a box of 5.56x45mm rounds.";
		HDPickup.refid UAS_HDLD_556BOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "AB56A0","BS56A0","B556Ammo",0.6;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M4");
		itemsthatusethis.push("B_M4_M203");
		itemsthatusethis.push("B_M249");
		itemsthatusethis.push("B556Mag");
	}
	States {
		Spawn:
			 AB56 A -1;
	}
}

class UaS_762Box : UaS_Bryans_AmmoBox {
	default {
		scale 0.5;
		HDMagAmmo.MaxPerUnit 50;
		HDMagAmmo.RoundType "B762x51Ammo";
		HDMagAmmo.RoundBulk c_762_load_bulk;
		tag "Reusable box 7.62x51mm box";
		Inventory.PickupMessage "Picked up a box of 7.62x51mm rounds.";
		HDPickup.refid UAS_HDLD_762BOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "AB76A0","BS76A0","B762x51Ammo",0.6;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M14");
		itemsthatusethis.push("b762_m14_mag");
	}
	States {
		Spawn:
			 AB76 A -1;
	}
}

class UaS_545Box : UaS_Bryans_AmmoBox {
	default {
		scale 0.5;
		HDMagAmmo.MaxPerUnit 100;
		HDMagAmmo.RoundType "B545Ammo";
		HDMagAmmo.RoundBulk c_545_load_bulk;
		tag "Reusable box 5.45x39mm box";
		Inventory.PickupMessage "Picked up a box of 5.45x39mm rounds.";
		HDPickup.refid UAS_HDLD_545BOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "AB54A0","B54SA0","B545Ammo",0.6;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_AKS74U");
	}
	States {
		Spawn:
			 AB54 A -1;
	}
}

class UaS_762sovBox : UaS_Bryans_AmmoBox {
	default {
		scale 0.5;
		HDMagAmmo.MaxPerUnit 50;
		HDMagAmmo.RoundType "B762SovAmmo";
		HDMagAmmo.RoundBulk c_762_sov_load_bulk;
		tag "Reusable box 7.62x39mm box";
		Inventory.PickupMessage "Picked up a box of 7.62x39mm rounds.";
		HDPickup.refid UAS_HDLD_762sovBOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "AB7SA0","B7SSA0","B762SovAmmo",0.6;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_AKM");
	}
	States {
		Spawn:
			 AB7S A -1;
	}
}

class UaS_50bmgBox : UaS_Bryans_AmmoBox {
	default {
		scale 0.8;
		HDMagAmmo.MaxPerUnit 50;
		HDMagAmmo.RoundType "B50BMGAmmo";
		HDMagAmmo.RoundBulk c_van_9mm_bulk; // Why?
		tag "Reusable .50BMG box";
		Inventory.PickupMessage "Picked up a box of .50 BMG rounds.";
		HDPickup.refid UAS_HDLD_50BMGBOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "AB50A0","BX50A0","B50BMGAmmo",1.0;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_m107");
		itemsthatusethis.push("M107Magazine");
	}

	States {
		Spawn:
			 AB50 A -1;
	}
}

/* class UaS_RPGBox : UaS_Bryans_AmmoBox {
	default {
		scale 0.5;
		HDMagAmmo.MaxPerUnit 5;
		HDMagAmmo.RoundType "BRpgRocket";
		HDMagAmmo.RoundBulk ENC_556; // Why?
		tag "Reusable RPG box";
		Inventory.PickupMessage "Picked up a box of RPG rockets.";
		HDPickup.refid UAS_HDLD_RPGBOX;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "RBOXA0","RPGRA6A4","BRPGRocket",0.6;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_RPGLauncher");
	}

	States {
		Spawn:
			 RBOX A -1;
	}
} */

class UAS_Bryan_Ammo_Spawner : EventHandler {
	void BryansAmmoBoxSpawns(worldevent e) {
		CVar ReplaceAmmoboxes = CVar.GetCVar("UaS_ReplaceAmmoboxes");
		if (!ReplaceAmmoboxes) return;

		if (e.Thing is "B_556_Box") {
			B556Ammo p = B556Ammo(actor.spawn("B556Ammo",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(10,int.max,"B_556_Box","BS56A0","BB56A7A3");
			e.thing.destroy();
			return;
		}

		if (e.Thing is "B_762_Box") {
			B762x51Ammo p = B762x51Ammo(actor.spawn("B762x51Ammo",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(10,int.max,"B_762_Box","BS76A0","BF76A3A7");
			e.thing.destroy();
			return;
		}

		if (e.Thing is "B_545_Box") {
			B545Ammo p = B545Ammo(actor.spawn("B545Ammo",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(10, int.max, "B_545_Box", "B54SA0", "B54BA7A3");
			e.thing.destroy();
			return;
		}

		if (e.Thing is "B_762sov_Box") {
			B762SovAmmo p = B762SovAmmo(actor.spawn("B762SovAmmo",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(10, int.max, "B_762sov_Box", "B7SSA0", "B7SBA7A3");
			e.thing.destroy();
			return;
		}

		if (e.Thing is "B_50BMG_Box") {
			B50BMGAmmo p = B50BMGAmmo(actor.spawn("B50BMGAmmo",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(10, int.max, "B_50BMG_Box", "BX50A0", "BG50A7A3");
			e.thing.destroy();
			return;
		}

/*		if (e.Thing is "BRocketPickup") {  // Rockets are handled as magazines, so this won't work.
			BRpgRocket p = BRpgRocket(actor.spawn("BRpgRocket",e.thing.pos));
			p.amount = HDUPK(e.Thing).amount;
			p.vel = e.thing.vel;
			p.SplitPickupBoxableRound(1,int.max,"BRocketPickup","RPGRA0","RPGRA6A4");
			e.thing.destroy();
			return;
		}
*/
	}
/*
	override void CheckReplacement(ReplaceEvent e) {
		CVar ReplaceAmmoboxes = CVar.GetCVar("UaS_ReplaceAmmoboxes");
		if (!ReplaceAmmoboxes) return;
		if (e.Replacee is "B_556_Box") { e.Replacement = "UaS_556Box"; return; }
		if (e.Replacee is "B_762_Box") { e.Replacement = "UaS_762Box"; return; }
		if (e.Replacee is "B_545_Box") { e.Replacement = "UaS_545Box"; return; }
		if (e.Replacee is "B_762sov_Box") { e.Replacement = "UaS_762SovBox"; return; }
		if (e.Replacee is "B_50BMG_Box") { e.Replacement = "UaS_50BMGBox"; return; }
		if (e.Replacee is "BRocketPickup") { e.Replacement = "UaS_RPGBox"; return; }
	}*/
}