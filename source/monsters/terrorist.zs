
class BaseTerrorist : HDMobBase {

	default {
		Radius 12;
		Height 57;
		gibhealth 140;
		health 100;
		Mass 100;
		Speed 8;
		PainChance 200;
		Monster;
		+FLOORCLIP;
		+SLIDESONWALLS
		Obituary "The terrorists have stolen %1's freedom";
		Tag "Terrorist";
		Translation "115:125=160:167";
		BaseTerrorist.TurnSpeed 15;
	}

	property WeaponHoverClass: bWeaponHoverClass;
	String bWeaponHoverClass;

	property WeaponClass: bWeaponClass;
	string bWeaponClass;

	property TurnSpeed: turnSpeed;
	double turnSpeed;

	HoveringGun hoverGun;

	override void PostBeginPlay() {
		super.PostBeginPlay();
		hoverGun = HoveringGun(Actor.Spawn(bWeaponHoverClass));
		hoverGun.host = self;
	}

	action void A_DropHovering() {
		if (invoker.hoverGun) {
			invoker.hoverGun.destroy();
			BHDWeapon dropWeapon = BHDWeapon(Actor.Spawn(invoker.bWeaponClass));
			let randomDir = AngleToVector(self.angle, random(1, 4));
			dropWeapon.SetOrigin(invoker.pos + (0, 0, 30), false);
			dropWeapon.vel.x = randomDir.x;
			dropWeapon.vel.y = randomDir.y;
		}
	}

	action void A_TurnToTarget() {
		double toTarget = AngleTo(target);
		double delta = toTarget - angle;
		bool direction = delta > 0;

		if (!CheckIfTargetInLOS(40, 2048)) {
			let forward = AngleToVector(angle, 0.5);
			vel.x -= (forward.x);
			vel.y -= (forward.y);
		}

		if (direction) {
			angle += delta > invoker.TurnSpeed ? invoker.TurnSpeed : delta; //    clamp(invoker.TurnSpeed, delta, invoker.TurnSpeed);
		}
		else if (delta < 0) {
			angle -= abs(delta) > invoker.TurnSpeed ? invoker.TurnSpeed : -delta;
		}

	}

	action void A_StrafePause() {
		let forward = AngleToVector(angle + random(-90, 90), random(-4, 4));
		vel.x -= (forward.x);
		vel.y -= (forward.y);
	}

	vector2 jukeForward;
	action void A_StartJuke() {
		invoker.jukeForward = AngleToVector(angle + random(-90, 90), random(-1, 1));
	}

	action void A_Juke() {
		vel.x -= (invoker.jukeForward.x);
		vel.y -= (invoker.jukeForward.y);
	}

	action void A_SightCheck() {
		if (CheckIfTargetInLOS(20, 2048)) {
			invoker.SetStateLabel("CoverFire");
		}
	}

	action void A_CoverFire() {
		//let bbb = HDBulletActor.FireBullet(self, "HDB_762sov", spread:5);
		// get pitch to target

		double dx = target.x - pos.x;
		double dy = target.y - pos.y;
		double dz = target.z - pos.z;
		double yaw = atan2(dz, dx);
		double pitch = atan2(sqrt(dz * dz + dx * dx), dy) + 3.141592653;
		console.printf("%f", pitch - 90);
		self.pitch = 10;
		let bbb = HDBulletActor.FireBullet(self, "HDB_762sov", spread:5);

		A_StartSound("weapons/akm/fire");
	}

	States {
		Spawn:
			MOSA AB 10 A_Look;
			Loop;
		See:
			MOSA AAAABBBBCCCCDDDD 3 A_Chase;
			Loop;
		Melee:
		Missile:
			MOSA E 3 A_TurnToTarget;
			MOSA E 0 A_SightCheck;
			Loop;

		CoverFire:
			MOSA E 0 A_Jump(100, "Juke");
			MOSA E 10 A_StrafePause;
			MOSA F 1 A_CoverFire;
			MOSA E 4;
			MOSA F 1 A_CoverFire;
			MOSA E 4;
			MOSA F 1 A_CoverFire;
			MOSA E 4;
			MOSA E 0 {
				if (!CheckIfTargetInLOS(20, 2048)) {
					invoker.SetStateLabel("See");
				}
			}
			Goto Missile;

		Juke:
			MOSA A 0 A_StartJuke;
			MOSA AAA 3 A_Juke;
			MOSA BBB 3 A_Juke;
			MOSA CCC 3 A_Juke;
			MOSA DDD 3 A_Juke;
			MOSA A 0 A_Jump(100, "Juke");
			Goto Missile;

		Pain:
			MOSA G 2;
			MOSA G 2 A_Pain;
		Death:
			MOSA H 0 A_DropHovering();
			MOSA HI 10;
			MOSA JK 6;
			MOSA LMN 3;
			MOSA N -1;
			Stop;
		XDeath:
			MOSA O 0 A_DropHovering();
			MOSA OPQRSTUVW 3;
			MOSA W -1;
			Stop;
	}

}

class HoveringGun : Actor {
	default {
        +FORCEXYBILLBOARD
        +NOINTERACTION
        +INTERPOLATEANGLES
        +FLATSPRITE
        +ROLLSPRITE
		+NOGRAVITY
		+SpriteAngle
		Scale .7;
	}
	BaseTerrorist host;
	override void Tick() {
		super.Tick();
		let forward = self.AngleToVector(host.angle, 10);
		let right = self.AngleToVector(host.angle - 90, 4);
		self.SetOrigin(host.pos + (forward.x, forward.y, 30) + (right.x, right.y, 0), true);
		self.angle = host.angle + 90;
		self.A_SetPitch(-90);
	}
}

class HoveringAks : HoveringGun {
	states {
		spawn:
			AK7P A -1;
			Stop;
	}
}

class HoveringAkm : HoveringGun {
	states {
		spawn:
			AKMP A -1;
			Stop;
	}
}

class AksTerror : BaseTerrorist {
	default {
		BaseTerrorist.WeaponHoverClass "HoveringAks";
		BaseTerrorist.WeaponClass "B_AKS74U";
	}
}

class AkmTerror : BaseTerrorist {
	default {
		BaseTerrorist.WeaponHoverClass "HoveringAkm";
		BaseTerrorist.WeaponClass "B_AKM";
	}
}