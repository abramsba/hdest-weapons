
class BaseAcog : BaseScopeAttachment {
	default {
		//BaseSightAttachment.FrontImage "acogcr";
		//BaseSightAttachment.BackImage "acogsg2";
		BaseSightAttachment.FrontOffY 4;
		BaseSightAttachment.BackOffY 0;
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
		BaseScopeAttachment.zoomFactor 5;
		HDPickup.Bulk 1;
		BaseScopeAttachment.ScopeImage "acog2sg";
		BaseScopeAttachment.SightImage "acog1";
		BaseAttachment.MountId "NATO_RAILS";
		Scale 0.4;
	}
}

class Base10xScope : BaseAcog {
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
		BaseSightAttachment.FrontImage "m16iron";
		BaseSightAttachment.FrontOffY 22;
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "mrsig1";
		HDPickup.Bulk 1;
		HDPickup.RefID "m4i";
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_M4_REARSIGHT_ID;
		BaseAttachment.BaseSprite "M4IR";
		BaseAttachment.BaseFrame 0;
		BaseSightAttachment.BackOffX -7;
		BaseSightAttachment.BackOffY 40;
		Inventory.Icon "M4RSA0";
		Inventory.PickupMessage "Picked up a M4 iron sight.";
		tag "M4 rear iron sight";
		BaseSightAttachment.bfrontAltImage "am4";
		BaseSightAttachment.bbackAltImage "alt_m4i";
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
		if (weapon is "B_M4" || weapon is "B_M4_M203") {
			return false;
		}
		return true;
	}
}

class B_M4_CarrySight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "m16iron";
		BaseSightAttachment.FrontOffY 22;
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "mrsig2";
		HDPickup.Bulk 1;
		HDPickup.RefID "m4c";
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_M4_CARRYHANDLE_ID;
		BaseAttachment.BaseSprite "M4IR";
		BaseAttachment.BaseFrame 1;
		BaseSightAttachment.BackOffX -2.5;
		BaseSightAttachment.BackOffY 42;
		Inventory.Icon "M4CHA0";
		Inventory.PickupMessage "Picked up a M4 carryhandle.";
		tag "M4 carryhandle";
		BaseSightAttachment.bfrontAltImage "am4";
		BaseSightAttachment.bbackAltImage "alt_carr";
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
		BaseSightAttachment.FrontImage "altfaf";
		BaseSightAttachment.UseWeaponIron true;
		BaseSightAttachment.BackImage "fauxbk";
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_FAUX_SIGHT_ID;
		BaseAttachment.BaseSprite "FOSI";
		BaseAttachment.BaseFrame 0;
		BaseSightAttachment.BackOffX 0;
		BaseSightAttachment.BackOffY 47;
		BaseSightAttachment.FrontOffY 46;
		Inventory.Icon "FTRSA0";
		Inventory.PickupMessage "Picked up a diamond rear sight.";
		tag "Diamond rear sight";
		HDPickup.RefID "dia";
		BaseSightAttachment.bfrontAltImage "altfaf";
		BaseSightAttachment.bbackAltImage "altfab";
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
		if (weapon is "b_FauxtechOrigin") {
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
		HDPickup.RefID "acg";
		Tag "Red ACOG (iron Sight).";
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
		BaseAttachment.BaseFrame 3;
		BaseSightAttachment.useWeaponIron true;
		Tag "Red-dot full sight";
		HDPickup.RefID "rdt";
		Inventory.Icon "SCPPB0";
		BaseSightAttachment.bbackAltImage "ardssg";
		Inventory.PickupMessage "Picked up a red-dot full sight.";
		Scale 0.4;
	}

	States {
		Spawn:
			SCPP B -1;
			Stop;

		OverlayImage:
			SCOP D -1;
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
		HDPickup.RefID "hrd";
		BaseSightAttachment.BackOffX 0;
		//BaseSightAttachment.BackOffY 47;
		Inventory.PickupMessage "Picked up a EOTech red-dot sight.";
		Scale 0.4;
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
		Inventory.ICON "ZUXKA0";
		BaseSightAttachment.BackOffY 25;
		Inventory.PickupMessage "Picked up a reflex red-dot sight.";
		//BaseSightAttachment.bfrontAltImage "rflahd";
		BaseSightAttachment.bbackAltImage "rflahd";
		HDPickup.RefID "rfr";
		Scale 0.4;
	}
	States {
		Spawn:
			ZUXK A -1;
			Stop;

		OverlayImage:
			RFLX A -1;
			Stop;
	}
}

class B_Scope_10x : BaseAcog {
	default {
		BaseAttachment.SerialId B_SCOPE_10X_ID;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 4;
		HDPickup.RefID "s10";
		Tag "LR scope";
		Inventory.Icon "ZXOIA0";
		Inventory.PickupMessage "Picked up a LR scope.";
		BaseScopeAttachment.zoomFactor 1;
		BaseScopeAttachment.SightImage "sight10z";
		BaseScopeAttachment.ScopeImage "bscope1";


		BaseScopeAttachment.ScopeBackY 0;
		BaseScopeAttachment.ScopeBackX 0;

		BaseScopeAttachment.XClipCam         -46;
		BaseScopeAttachment.YClipCam         -49;
		BaseScopeAttachment.ScaledWidth      95;

		BaseScopeAttachment.XPosCam          0;
		BaseScopeAttachment.YPosCam          1;

		BaseScopeAttachment.ScopeScaleX      1.6;
		BaseScopeAttachment.ScopeScaleY      1.6;

		BaseScopeAttachment.ScopeHoleX       0;
		BaseScopeAttachment.ScopeHoleY       0;		

		BaseScopeAttachment.XScaleCam        0.55;
		BaseScopeAttachment.YScaleCam        0.55;

	}

	States {
		Spawn:
			ZXOI A -1;
			Stop;

		OverlayImage:
			SCOP E -1;
			Stop;
	}
}

