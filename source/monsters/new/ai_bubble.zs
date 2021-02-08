
class AiBubble : Actor {
	default {
        +FORCEXYBILLBOARD
        +NOINTERACTION
        +INTERPOLATEANGLES
        +FLATSPRITE
        +ROLLSPRITE
		+NOGRAVITY
		+SpriteAngle
		Scale 0.7;
		AiBubble.fora 10;
		AiBubble.forb 3;
		AiBubble.forc 25;
	}
	HumanoidBase host;

	property fora: fora;
	double fora;

	property forb: forb;
	double forb;

	property forc: forc;
	double forc;

	override void Tick() {
		super.Tick();

		let forward = (0, 0);
		let right = (0, 0);
		let height = forc;

		if (host.shooting) {			
			forward = self.AngleToVector(host.angle, fora);
			height += 5;
		}
		else {
			forward = self.AngleToVector(host.angle, forb);
		}

		if (host.height < 20) {
			height = 0;
		}

		self.SetOrigin(host.pos + (forward.x, forward.y, height) + (right.x, right.y, 0), true);
		self.angle = host.angle + 90;
		self.A_SetPitch(-90);

		if (host.shooting) {
			self.A_SetRoll(0);
		}
		else {
			self.A_SetRoll(-45);
		}
	}
	states {
		hide:
			TNT1 A -1;
			Stop;
	}
}

class ai_with_bubble_base : HumanoidBase {
	default {
		painchance 120;
		speed 10;
		seesound "";
		painsound "grunt/pain";
		deathsound "grunt/death";
		activesound "";
	}
	AiBubble gunInst;
	override void deathdrop() {
		if (gunInst) {
			gunInst.destroy();
		}
		super.deathdrop();
	}

	override void reloadStart() {
		super.reloadStart();
		if (gunInst) {
			gunInst.SetStateLabel("empty");
		}
	}

	override void reloadFinish() {
		super.reloadFinish();
		if (gunInst) {
			gunInst.SetStateLabel("spawn");
		}
	}

	virtual AiBubble getGun() {
		return null;
	}
	states{
	raise:
				---- A 0 {
				if (!gunInst) {
					gunInst = getGun();
				}
			}
			Goto Super::raise;
	}
}