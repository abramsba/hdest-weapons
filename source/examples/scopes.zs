
class BaseAcog : BaseScopeAttachment {
	default {
		//BaseSightAttachment.FrontImage "acogcr";
		//BaseSightAttachment.BackImage "acogsg2";
		BaseSightAttachment.FrontOffY 8;
		BaseSightAttachment.BackOffY 9;
		BaseScopeAttachment.XScaleCam        0.32;
		BaseScopeAttachment.YScaleCam        0.35;
		BaseScopeAttachment.XPosCam          0;
		BaseScopeAttachment.YPosCam          1;
		BaseScopeAttachment.ScaledWidth      65;
		BaseScopeAttachment.XClipCam         -35;
		BaseScopeAttachment.YClipCam         -30;
		BaseScopeAttachment.ScopeHoleX       0;
		BaseScopeAttachment.ScopeHoleY       0;
		BaseScopeAttachment.ScopeScaleX      1;
		BaseScopeAttachment.ScopeScaleY      1;
		BaseScopeAttachment.ScopeImageX      -0.5;
		BaseScopeAttachment.ScopeImageY      1.5;
		BaseScopeAttachment.ScopeImageScaleX 1;
		BaseScopeAttachment.ScopeImageScaleY 1;
		BaseScopeAttachment.ScopeBackX       2.5;
		BaseScopeAttachment.ScopeBackY       15;
		HDPickup.Bulk 1;
		BaseScopeAttachment.ScopeImage "acog2sg";
		BaseScopeAttachment.SightImage "acog1";
		BaseAttachment.MountId "NATO_RAILS";
	}
}

class BaseAcogType2 : BaseAcog {
	default {
		BaseSightAttachment.FrontImage "rdot";
		BaseScopeAttachment.SightImage "acog1";
		BaseSightAttachment.BackImage "rdotcog";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY 0;
	}
}

class BaseAcogType3 : BaseAcog {
	default {

	}
}

class BaseCompactDotSight : BaseSightAttachment {
	default {
		BaseAttachment.MountId "NATO_RAILS";
		BaseSightAttachment.FrontImage "holir";
		BaseSightAttachment.BackImage "rflhud";
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.FrontOffY 0;
		BaseSightAttachment.BackOffY 24;
		BaseSightAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
	}
}


class BaseFullDotSight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "rdot";
		BaseSightAttachment.BackImage "rdssg";
		BaseSightAttachment.BackOffY 10;
		BaseSightAttachment.BackOffX -15;
		BaseSightAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
	}
}

class BaseHoloSight : BaseFullDotSight {
	default {
		BaseSightAttachment.FrontImage "holir";
		BaseSightAttachment.BackImage "holsg";
		BaseSightAttachment.FrontOffY 0;
		BaseSightAttachment.BackOffY 18.5;
		BaseSightAttachment.DotThreshold 180;
	}
}










class B_M4_RearSight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "";
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "mrsig1";
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_M4_REARSIGHT_ID;
		BaseAttachment.BaseSprite "M4IR";
		BaseAttachment.BaseFrame 0;
		BaseSightAttachment.BackOffX -7;
		BaseSightAttachment.BackOffY 40;
		Inventory.Icon "M4RSA0";
		Inventory.PickupMessage "Picked up a M4 iron sight.";
		tag "M4 rear iron sight";
	}

	States {
		Spawn:
			M4RS A -1;
			Stop;

		OverlayImage:
			M4IR A -1;
			Stop;
	}

	override bool Blocked(BHDWeapon weapon) {
		let className = weapon.getClassName();
		if (className == "B_M4" || className == "B_M4_M203") {
			return false;
		}
		return true;
	}
}

class B_M4_CarrySight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "";
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "mrsig2";
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_M4_CARRYHANDLE_ID;
		BaseAttachment.BaseSprite "M4IR";
		BaseAttachment.BaseFrame 1;
		BaseSightAttachment.BackOffX -2.5;
		BaseSightAttachment.BackOffY 42;
		Inventory.Icon "M4CHA0";
		Inventory.PickupMessage "Picked up a M4 carryhandle.";
		tag "M4 carryhandle";
	}

	states {
		Spawn:
			M4CH A -1;
			Stop;

		OverlayImage:
			M4IR B -1;
			Stop;
	}

	override bool Blocked(BHDWeapon weapon) {
		let className = weapon.getClassName();
		if (className == "B_M4" || className == "B_M4_M203") {
			return false;
		}
		return true;
	}	
}

class B_Faux_Sight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "";
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "fauxbk";
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_FAUX_SIGHT_ID;
		BaseAttachment.BaseSprite "FOSI";
		BaseAttachment.BaseFrame 0;
		BaseSightAttachment.BackOffX -0.75;
		BaseSightAttachment.BackOffY 47;
		Inventory.Icon "FTRSA0";
		Inventory.PickupMessage "Picked up a diamond rear sight.";
		tag "Diamond rear sight";
	}

	states {
		Spawn:
			FTRS A -1;
			Stop;

		OverlayImage:
			FOSI A -1;
			Stop;
	}

	override bool Blocked(BHDWeapon weapon) {
		let className = weapon.getClassName();
		if (className == "b_FauxtechOrigin") {
			return false;
		}
		return true;
	}
}

class B_ACOG_Red : BaseAcog {
	default {
		BaseAttachment.SerialId B_ACOG_RED_ID;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 0;
		Tag "Red M4 ACOG (iron Sight).";
		Inventory.Icon "SCPPA0";
		Inventory.PickupMessage "Picked up a red M4 ACOG (iron Sight).";
	}

	States {
		Spawn:
			SCPP A -1;
			Stop;

		OverlayImage:
			SCOP A -1;
			Stop;
	}
}

class B_Sight_CRdot : BaseFullDotSight {
	default {
		BaseAttachment.SerialId B_SIGHT_CRDOT_ID;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 1;
		BaseSightAttachment.useWeaponIron true;
		Tag "Red-dot full sight";
		Inventory.Icon "SCPPB0";
		Inventory.PickupMessage "Picked up a red-dot full sight.";
	}

	States {
		Spawn:
			SCPP B -1;
			Stop;

		OverlayImage:
			SCOP B -1;
			Stop;
	}
}

class B_Sight_Holo_Red : BaseHoloSight {
	default {
		BaseAttachment.SerialId B_SIGHT_HOLO_ID;
		BaseAttachment.BaseSprite "HOLG";
		BaseAttachment.BaseFrame 0;
		Tag "EOTech Holographic Sight";
		Inventory.Icon "SCPPC0";
		BaseSightAttachment.BackOffX 0;
		//BaseSightAttachment.BackOffY 47;
		Inventory.PickupMessage "Picked up a red-dot round sight.";
	}

	States {
		Spawn:
			SCPP C -1;
			Stop;

		OverlayImage:
			HOLG A -1;
			Stop;
	}
}


class B_Reflex_Red : BaseCompactDotSight {
	default {
		BaseAttachment.SerialID B_REFLEX_RED_ID;
		BaseAttachment.BaseSprite "RFLX";
		BaseAttachment.BaseFrame 0;
		Tag "Reflex red-dot sight";
		Inventory.ICON "RFLIA0";
		BaseSightAttachment.BackOffY 25;
		Inventory.PickupMessage "Picked up a reflex red-dot sight.";
	}
	States {
		Spawn:
			SCPP C -1;
			Stop;

		OverlayImage:
			RFLX A -1;
			Stop;
	}
}



