
class AiAkmBubble : AiBubble {
	states {
		spawn:
			AKMP A -1;
			Stop;
		empty:
			AKMP B -1;
			Stop;
	}
}

class AiAksBubble : AiBubble {
	states {
		spawn:
			AK7P A -1;
			Stop;
		empty:
			AK7P B -1;
			Stop;
	}
}

class ru_vsr_base : ai_with_bubble_base {
	default {
		species "ru_vsr_base";
	}
	states {
		spawn:
			VSRA A 0 NoDelay {
				if (!gunInst) {
					gunInst = getGun();
				}
			}
			Goto Super::Spawn2;
	}
}

class ru_emr_base : ai_with_bubble_base {
	states {
		spawn:
			EMRA A 0 NoDelay {
				if (!gunInst) {
					gunInst = getGun();
				}
				translation = 0;
			}
			Goto Super::Spawn2;
	}
}

class ru_vsr_akm : ru_vsr_base {
	default {
		HumanoidBase.hWeaponClass     "B_AKM";
		HumanoidBase.hBulletClass     "HDB_762sov";
		HumanoidBase.hMaxMag          30;
		HumanoidBase.hMagazineClass   "BAKM_762Mag";
		HumanoidBase.hSpentClass      "B762SovSpent";
		HumanoidBase.hFireSound       "weapons/akm/fire";
	}
	override AiBubble getGun() {
		AiBubble hoverGun = AiBubble(Actor.Spawn("AiAkmBubble"));
		hoverGun.host = self;
		return hoverGun;
	}
}

class ru_vsr_aks : ru_vsr_base {
	default {
		HumanoidBase.hWeaponClass     "B_AKS74U";
		HumanoidBase.hBulletClass     "HDB_545";
		HumanoidBase.hMaxMag          30;
		HumanoidBase.hMagazineClass   "BAK_545Mag";
		HumanoidBase.hSpentClass      "B545Spent";
		HumanoidBase.hFireSound       "weapons/akm/fire";
	}
	override AiBubble getGun() {
		AiBubble hoverGun = AiBubble(Actor.Spawn("AiAksBubble"));
		hoverGun.host = self;
		return hoverGun;
	}
}

class ru_akm : randomspawner {
	default {
		dropitem "ru_vsr_akm";
		dropitem "ru_emr_akm";
	}
}

class ru_aks : randomspawner {
	default {
		dropitem "ru_vsr_aks";
		dropitem "ru_emr_aks";
	}
}

class ru_emr_akm : ru_emr_base {
	default {
		HumanoidBase.hWeaponClass     "B_AKM";
		HumanoidBase.hBulletClass     "HDB_762sov";
		HumanoidBase.hMaxMag          30;
		HumanoidBase.hMagazineClass   "BAKM_762Mag";
		HumanoidBase.hSpentClass      "B762SovSpent";
		HumanoidBase.hFireSound       "weapons/akm/fire";
	}
	override AiBubble getGun() {
		AiBubble hoverGun = AiBubble(Actor.Spawn("AiAkmBubble"));
		hoverGun.host = self;
		return hoverGun;
	}
}

class ru_emr_aks : ru_emr_base {
	default {
		HumanoidBase.hWeaponClass     "B_AKS74U";
		HumanoidBase.hBulletClass     "HDB_545";
		HumanoidBase.hMaxMag          30;
		HumanoidBase.hMagazineClass   "BAK_545Mag";
		HumanoidBase.hSpentClass      "B545Spent";
		HumanoidBase.hFireSound       "weapons/akm/fire";
	}
	override AiBubble getGun() {
		AiBubble hoverGun = AiBubble(Actor.Spawn("AiAksBubble"));
		hoverGun.host = self;
		return hoverGun;
	}
}