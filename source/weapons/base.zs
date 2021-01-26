


// Base Class for Rifle
class BHDWeapon : HDWeapon {

	default {
		BHDWeapon.SoundClass "chicken";
		BHDWeapon.BSpriteWithFrame 0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.EjectShellClass "NULL";
		BHDWeapon.BLayerGun    100;
		BHDWeapon.BLayerSight  101;
		BHDWeapon.bLayerScopeShader 102;
		BHDWeapon.BLayerMisc   103;
		BHDWeapon.bLayerBarrel 99;
		BHDWeapon.bLayerRHand  105;
		BHDWeapon.bLayerGunBack 104;
		BHDWeapon.bLayerEHand  120;

		BHDWeapon.bFlashSprite "MPFLA0";
		BHDWeapon.bIronThreshold 35;
		BHDWeapon.BAmmoHudScale 2;

		BHDWeapon.BRecoilXLow -1.4;
		BHDWeapon.BRecoilXHigh 1.4;
		BHDWeapon.BRecoilYLow  1.3;
		BHDWeapon.BRecoilYHigh 2.6;
		BHDWeapon.BShowFireMode false;
	}

	property BShowFireMode: bShowFireMode;
	bool bShowFireMode;

	property BRecoilXLow: BRecoilXLow;
	property BRecoilXHigh: BRecoilXHigh;
	property BRecoilYLow: BRecoilYLow;
	property BRecoilYHigh: BRecoilYHigh;

	double BRecoilXLow, BRecoilXHigh;
	double BRecoilYLow, BRecoilYHigh;	

	property BIronThreshold: bIronThreshold;
	double bIronThreshold;

	property BFlashSprite: bFlashSprite;
	string bFlashSprite;

	property BLayerGun: bLayerGun;
	property BLayerGunBack: bLayerGunBack;
	property BLayerSight: bLayerSight;
	property BLayerMisc: bLayerMisc;
	property BLayerBarrel: bLayerBarrel;
	property BLayerRHand: bLayerRHand;
	property BLayerEHand: bLayerEHand;
	property bLayerScopeShader: bLayerScopeShader;

	property BAmmoHudScale: BAmmoHudScale;
	double BAmmoHudScale;

	int bLayerGun;
	int bLayerSight;
	int bLayerMisc;
	int bLayerBarrel;
	int bLayerRHand;
	int bLayerGunBack;
	int bLayerScopeShader;
	int bLayerEHand;

	property EjectShellClass: ejectShellClass;
	String ejectShellClass;

	property SoundClass: soundClass;
	Name SoundClass;

	property BHeatDrain: bHeatDrain;
	int bHeatDrain;

	property BBulletClass: bBulletClass;
	string bBulletClass;

	property BAmmoClass: bAmmoClass;
	string bAmmoClass;

	property BMagazineClass: bMagazineClass;
	string bMagazineClass;

	property BGunMass: bGunMass;
	double bGunMass;

	property BCookOff: bCookOff;
	int bCookOff;

	property BHeatLimit: bHeatLimit;
	int bHeatLimit;

	property BSpriteWithMag: bSpriteWithMag;
	string bSpriteWithMag;

	property BSpriteWithFrame: bSpriteWithFrame;
	int bSpriteWithFrame;

	property BSpriteWithoutMag: bSpriteWithoutMag;
	string bSpriteWithoutMag;

	property BSpriteWithoutFrame: bSpriteWithoutFrame;
	int bSpriteWithoutFrame; 

	property BMagazineSprite: bMagazineSprite;
	string bMagazineSprite;

	property BWeaponBulk: bWeaponBulk;
	int bWeaponBulk;

	property BMagazineBulk: bMagazineBulk;
	int bMagazineBulk;

	property BBulletBulk: bBulletBulk;
	int bBulletBulk;

	property BMagazineCapacity: bMagazineCapacity;
	int bMagazineCapacity;

	property BSFireSound : bSFireSound;
	string bSFireSound;

	property BFireSound : bFireSound;
	string bFireSound;

	property BChamberSound : bChamberSound;
	string bChamberSound;

	property BClickSound : bClickSound;
	string bClickSound;

	property BLoadSound : bLoadSound;
	string bLoadSound;

	property BUnloadSound : bUnloadSound;
	string bUnloadSound;

	property BBoltForwardSound : bBoltForwardSound;
	string bBoltForwardSound;

	property BBoltBackwardSound : bBoltBackwardSound;
	string bBoltBackwardSound;

	property BBackSightImage : bBackSightImage;
	string bBackSightImage;

	property BBackOffsetX : bBackOffsetX;
	property BBackOffsetY : bBackOffsetY;
	int bBackOffsetX;
	int bBackOffsetY;

	property BFrontSightImage : bFrontSightImage;
	string bFrontSightImage;

	property BAltFrontSightImage: BAltFrontSightImage;
	property BAltBackSightImage : BAltBackSightImage;
	string BAltFrontSightImage;
	string BAltBackSightImage;

	property BFrontOffsetX : bFrontOffsetX;
	property BFrontOffsetY : bFrontOffsetY;
	int bFrontOffsetX;
	int bFrontOffsetY;

	property BROF : bROF;
	int bROF;

	property BarrelLength: barrelLength;
	property BarrelWidth: barrelWidth;
	property BarrelDepth: barrelDepth;

	property BSilentOffsetX : bSilentOffsetX;
	property BSilentOffsetY : bSilentOffsetY;
	float bSilentOffsetX;
	float bSilentOffsetY;

	BaseBarrelAttachment barrelAttachment;
	BaseSightAttachment scopeAttachment;
	BaseMiscAttachment miscAttachment;

	Class<BaseBarrelAttachment> barrelClass;
	Vector2 barrelOffsets;
	bool useBarrelOffsets;

	Class<BaseMiscAttachment> miscClass;
	Vector2 miscOffsets;
	bool useMiscOffsets;

	Class<BaseSightAttachment> scopeClass;
	Vector2 scopeOffsets;
	bool useScopeOffsets;

	bool miscActive;
	void toggleMisc() const {
		miscActive = !miscActive;
	}

	property BBarrelMount: bBarrelMount;
	string bBarrelMount;

	property BScopeMount: bScopeMount;
	string bScopeMount;

	property BMiscMount: bMiscMount;
	string bMiscMount;

	// Pretty API that I need to use consistently TODO

	int magazineGetAmmo() const {
		return weaponStatus[I_MAG];
	}

	bool magazineHasAmmo() const {
		return weaponStatus[I_MAG] > 0;
	}

	void magazineAddAmmo(int amt) {
		weaponStatus[I_MAG] += amt;
	}

	void fixChamber() {
		weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
	}

	void breakChamber() {
		weaponStatus[I_FLAGS] |= F_CHAMBER_BROKE;
	}

	void unchamber() {
		weaponStatus[I_FLAGS] &= ~F_CHAMBER;
	}

	void setChamber() {
		weaponStatus[I_FLAGS] |= F_CHAMBER;
	}

	bool brokenChamber() const {
		return (weaponStatus[I_FLAGS] & F_CHAMBER_BROKE) > 0;
	}

	bool chambered() const {
		return (weaponStatus[I_FLAGS] & F_CHAMBER) > 0;
	}

	int heatAmount() const {
		return weaponStatus[I_HEAT];
	}

	void addHeat(int h) {
		weaponStatus[I_HEAT] += h;
	}

	bool overheated() const {
		return weaponStatus[I_HEAT] > bCookOff;
	}

	int fireMode() const {
		return weaponStatus[I_AUTO];
	}

	void setFireMode(int mode) {
		weaponStatus[I_AUTO] = mode;
	}

	int boreStretch() const {
		return weaponStatus[I_BORE];
	}

	void addBoreStretch(int amount) {
		weaponStatus[I_BORE] += amount;
	}

	int getBarrelSerialID() const {
		int all = weaponStatus[I_3RD] & B_BARREL;
		return all;
	}

	int getMiscSerialID() const {
		int all = weaponStatus[I_3RD] & B_MISC;
		return (all >> 8);
	}

	int getScopeSerialID() const {
		int all = weaponStatus[I_3RD] & B_SCOPE;
		return (all >> 16);
	}

	void setBarrelSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_BARREL;
		weaponStatus[I_3RD] |= id;
	}

	void setMiscSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_MISC;
		int offset = id << 8;
		weaponStatus[I_3RD] |= offset;
	}

	void setScopeSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_SCOPE;
		int offset = id << 16;
		weaponStatus[I_3RD] |= offset;
	}

	bool spawnEmpty;

	// HD API

	// Overrides

	override void Tick() {
		super.tick();
		drainheat(I_HEAT, bHeatDrain);
	}

	override bool AddSpareWeapon(actor newowner) {
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect) {
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	override double GunMass(){
		return bGunMass + (magazineGetAmmo() * 0.02);
	}

	override void GunBounce() {
		super.GunBounce();
		if (!random(0, 5)) {
			fixChamber();
		}
	}

	override void OnPlayerDrop() {
		if(!random(0, 15)) {
			breakChamber();
		}
		if(overheated()) {
			owner.dropInventory(self);
		}
	}

	override string, double GetPickupSprite() {
		if(magazineHasAmmo()) {
			return bSpriteWithMag, 1.;
		}
		else {
			return bSpriteWithoutMag, 1.;
		}
	}

	override double WeaponBulk() {
		// Fuck it do like the zm66
		int mgg = weaponStatus[I_MAG];
		double loadedMagBulk = (bMagazineBulk * 0.4) * 0.4;
		double loadedRoundBulk = (bBulletBulk / 2);
		return bWeaponBulk + (mgg < 0 ? 0 : (loadedMagBulk + mgg * loadedRoundBulk));
	}

	override void DropOneAmmo(int amt){
		if(owner){
			amt = clamp(amt, 1, 10);
			if (owner.CountInv(bAmmoClass)) {
				owner.A_DropInventory(bAmmoClass, amt * bMagazineCapacity);
			}
			else {
				owner.A_DropInventory(BMagazineClass, amt);
			}
		}
	}

	override void ForceBasicAmmo(){
		owner.A_TakeInventory(bAmmoClass);
		owner.A_TakeInventory(bMagazineClass);
		owner.A_GiveInventory(bMagazineClass);
	}

	override void InitializeWepStats (bool idfa) {
		weaponStatus[I_MAG] = bMagazineCapacity - 1;
		weaponStatus[I_FLAGS] |= F_CHAMBER;
		weaponspecial=1337;
		//console.printf("%s %i", getClassName(), getBarrelSerialID());
		//setchamber();
	}

	override void LoadoutConfigure(string input){
		AttachmentManager mgr = AttachmentManager(EventHandler.Find("AttachmentManager"));
		int barrelId = getLoadoutVar(input, "ba");
		int scopeId = getLoadoutVar(input, "bs");
		int miscId = getLoadoutVar(input, "bm");
		
		Class<BaseSightAttachment> bsClass = mgr.getScopeClass(scopeId);
		if (bsClass) {
			string bsMountId = GetDefaultByType(bsClass).mountId;
			if (bsMountId == bScopeMount) {
				setScopeSerialID(scopeId);
				scopeClass = bsClass;
			}
		}

		Class<BaseBarrelAttachment> baClass = mgr.getBarrelClass(barrelId);
		if (baClass) {
			string baMountId = GetDefaultByType(baClass).mountId;
			if (baMountId == bBarrelMount) {
				setBarrelSerialID(barrelId);
				barrelClass = baClass;
			}
		}

		Class<BaseMiscAttachment> bmClass = mgr.getMiscClass(miscId);
		if (bmClass) {
			string bmMountId = GetDefaultByType(bmClass).mountId;
			if (bmMountId == bMiscMount) {
				setMiscSerialID(miscId);
				miscClass = bmClass;
			}
		}

		weaponstatus[I_FLAGS] |= F_CHAMBER;
	}

	// HD Action Functions

	action bool A_CheckCookoff() {
		if (invoker.overheated() && !invoker.brokenChamber() && invoker.chambered()) {
			SetWeaponState("cookoff");
			return true;
		}
		return false;
	}

	action bool BrokenRound() {
		if (!invoker.brokenChamber()) {
			int currentHeat = invoker.heatAmount();
			if (currentHeat > invoker.bHeatLimit) {
				invoker.addBoreStretch(1);
			}
			currentHeat *= currentHeat >>= 10; // ?
			int pivot = (invoker.owner ? 1 : 10) +
			            max(invoker.fireMode(), currentHeat) +
			            invoker.boreStretch() +
			            (invoker.magazineGetAmmo() > 100 ? 10 : 0);
			if (random(0, 2000) < pivot) {
				invoker.breakChamber();
			}
		}
		return invoker.brokenChamber();
	}

	override inventory CreateTossable(int amt){

		if (SpawnState == GetDefaultByType("Actor").SpawnState || SpawnState == NULL) {
			return NULL;

		}
		if (bUndroppable || bUntossable || Owner == NULL || Amount <= 0 || amt == 0) {
			return NULL;
		}
		DropTime = 30;
		bSpecial = bSolid = false;
		if (miscActive) {
			FlashLightManager mgr = FlashLightManager(EventHandler.Find("FlashLightManager"));
			PlayerPawn pawn = PlayerPawn(owner);
			mgr.destLight(pawn.PlayerNumber());
		}

		miscActive = false;

		let copyWeapon = super.CreateTossable(amt);
		return copyWeapon;
	}


	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		BHDWeapon basicWep = BHDWeapon(hdw);
		if (sb.hudLevel == 1) {
			int nextMag = sb.GetNextLoadMag(HDMagAmmo(hpl.findInventory(basicWep.bMagazineClass)));
			sb.DrawImage(basicWep.bMagazineSprite, (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (basicWep.BAmmoHudScale, basicWep.BAmmoHudScale));
			sb.DrawNum(hpl.CountInv(basicWep.bMagazineClass), -43, -8, sb.DI_SCREEN_CENTER_BOTTOM);
		}
		if (bShowFireMode) {
			sb.drawwepcounter(hdw.weaponstatus[I_AUTO], -22, -10, "RBRSA3A7", "STFULAUT", "STBURAUT" );
		}
		int ammoBarAmt = clamp(basicWep.magazineGetAmmo() % 999, 0, basicWep.bMagazineCapacity);
		sb.DrawWepNum(ammoBarAmt, basicWep.bMagazineCapacity);
		if (basicWep.chambered()) {
			sb.DrawWepDot(-16, -10, (3, 1));
			//ammoBarAmt++;
		}
		//sb.DrawNum(ammoBarAmt, -16, -22, sb.DI_SCREEN_CENTER_BOTTOM | sb.DI_TEXT_ALIGN_RIGHT, Font.CR_RED);
	}

	String getFrontSightImage(HDPlayerPawn hpl) const {
		let b_althud_mode = Cvar.GetCVar("b_althud_mode", players[hpl.playernumber()]).GetInt();
		//console.printf("%i", b_althud_mode);
		if (scopeClass && b_althud_mode == 1) {
			let img = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontImage;
			return img;
		}
		else if (scopeClass && b_althud_mode == 2) {
			let altimg = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).bfrontAltImage;
			if (altimg == "") {
				altimg = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontImage;
			}
			return altimg;
		}
		else if (b_althud_mode == 2) {
			return BAltFrontSightImage;
		}
		return bFrontSightImage;
	}

	String getBackSightImage(HDPlayerPawn hpl) const {
		let b_althud_mode = Cvar.GetCVar("b_althud_mode", players[hpl.playernumber()]).GetInt();
		//console.printf("%i", b_althud_mode);
		if (scopeClass && b_althud_mode == 1) {
			let img = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackImage;
			return img;
		}
		else if (scopeClass && b_althud_mode == 2) {
			let altimg = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).bbackAltImage;
			if (altimg == "") {
				altimg = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackImage;
			}
			return altimg;
		}
		else if (b_althud_mode == 2) {
			return BAltBackSightImage;
		}
		return bBackSightImage;
	}

	Vector2 getFrontSightOffsets() const {
		if (scopeClass) {
			let x = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontOffX;
			let y = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontOffY;
			return (x, y);
		}
		return (bFrontOffsetX, bFrontOffsetY);
	}

	Vector2 getBackSightOffsets() const {
		if (scopeClass) {
			let x = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackOffX;
			let y = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackOffY;
			return (x, y);
		}
		return (bBackOffsetX, bBackOffsetY);
	}

	Vector2 getBarrelOffsets() const {
		return (0, 0);
	}

	vector2 lastBob;

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {

		PlayerInfo info = players[hpl.playernumber()];
		BHDWeapon basicWep = BHDWeapon(hdw);

		double dotoff = max(abs(bob.x), abs(bob.y));

		double dotLimit = basicWep.bIronThreshold;
		if (basicWep.scopeClass) {
			dotLimit = GetDefaultByType((Class<BaseSightAttachment>)(basicWep.scopeClass)).DotThreshold;
		}

		if (dotoff < dotLimit){
			sb.drawImage(getFrontSightImage(hpl), getFrontSightOffsets() + bob * 3, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.9 - dotoff * 0.04);
		}
		sb.drawimage(getBackSightImage(hpl), getBackSightOffsets() + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		if (basicWep.scopeClass is "BaseScopeAttachment" && scopeview) {
			let def = GetDefaultByType((Class<BaseScopeAttachment>)(basicWep.scopeClass));

			string image               = def.ScopeImage;
			string ScopeSightImageName = def.SightImage;

			double xscalecam        = def.xscalecam;
			double yscalecam        = def.yscalecam;
			double xposcam          = def.xposcam;
			double yposcam          = def.yposcam; //58;

			double scaledwidth      = def.scaledwidth;

			double xclipcam         = def.xclipcam;
			double yclipcam         = def.yclipcam;

			double scopeholex       = def.scopeholex;
			double scopeholey       = def.scopeholey;
			double scopescalex      = def.scopescalex;
			double scopescaley      = def.scopescaley;

			double scopeImageX      = def.scopeImagex;
			double scopeImageY      = def.scopeImagey;
			double scopeImageScaleX = def.scopeImageScaleX;
			double scopeImageScaleY = def.scopeImageScaley;
			double scopeBackX       = def.scopeBackX;
			double scopeBackY       = def.scopeBackY;

			Vector2 cameraPos = (xposcam, yposcam);
			Vector2 scaleCamera = (xscalecam, yscalecam);
			Vector2 clipCamera = (xclipcam, yclipcam);
			Vector2 scopeHole = (scopeholex, scopeholey);
			Vector2 scopeScale = (scopescalex, scopescaley);
			Vector2 scopeImage = (scopeimagex, scopeimagey);
			Vector2 scopeImageScale = (scopeImageScaleX, scopeImageScaleY);
			Vector2 scopeBack = (scopeBackX, scopeBackY);

			TexMan.SetCameraToTexture(hpc, "HDXHCAM3", def.zoomFactor);
			//let boff = (0, 35);
			//sb.drawImage("HDXHCAM3", boff + cameraPos + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: scaleCamera);

			int cx,cy,cw,ch;
			[cx,cy,cw,ch]=screen.GetClipRect();
			sb.SetClipRect(
				clipCamera.x + bob.x, 
				clipCamera.y + bob.y, 
				scaledwidth, 
				scaledwidth,
				sb.DI_SCREEN_CENTER
			);

			sb.drawImage("HDXHCAM3", cameraPos + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: scaleCamera);

			
			sb.drawimage(
				"scophole", 
				scopeHole + bob * 3, 
				sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, 
				scale: scopeScale * 0.7
			);
			

			sb.drawImage(
				ScopeSightImageName, 
				scopeImage + bob, 
				sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, 
				scale: scopeImageScale
			);
			

			sb.SetClipRect(cx,cy,cw,ch);
			sb.drawImage(image, scopeBack + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (1.5, 1.5));
		}

		//sb.drawImage("calib", (0, 0), sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.3);


	}

	action state GetMagState() {
		//console.printf("am i here? %i", invoker.magazineGetAmmo());
		if (invoker.magazineGetAmmo() > -1) {
			return ResolveState("SpawnMag");
		}
		return ResolveState("SpawnNoMag");
		
	}

	bool flashlight;
	bool flashlightOn;

	action void GetAttachmentStateBarrel(AttachmentManager mgr) {
		// Barrel
		int sid = -1;
		int oid = -1;

		//console.printf("Attach barrel %b", invoker.useBarrelOffsets);

		//TakeInventory("BSilencerRemover", 1);
		if (invoker.useBarrelOffsets) {
			//console.printf("with %i %i", invoker.barrelOffsets.x, invoker.barrelOffsets.y);
			A_OverlayOffset(invoker.bLayerBarrel, invoker.barrelOffsets.x, invoker.barrelOffsets.y);
		}
		else {
			//console.printf("none");
			A_OverlayOffset(invoker.bLayerBarrel, 0, 0);
		}

		if (invoker.getBarrelSerialID() == 0) {
			//console.printf("hi mom?");
			//
			invoker.barrelClass = null;
			A_ClearOverlays(invoker.bLayerBarrel, invoker.bLayerBarrel);
		}
		else {
			//GiveInventoryType("BSilencerRemover");
			if (!invoker.barrelClass && invoker.getBarrelSerialID() > 0) {
				sid = invoker.getBarrelSerialID();
				invoker.barrelClass = mgr.getBarrelClass(sid);
			}

			sid = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).serialId;
			if (invoker.getBarrelSerialID() > 0 && invoker.getBarrelSerialID() != sid) {
				sid = invoker.getBarrelSerialID();
				invoker.barrelClass = mgr.getBarrelClass(sid);
				//invoker.barrelLength += GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).barrelLength;
			}

			if (invoker.getBarrelSerialID() > 0) {
				//let psp = player.FindPSprite(invoker.bLayerBarrel);
				//if (!psp) {
					A_Overlay(invoker.bLayerBarrel, "BarrelOverlay");
				//}

				oid = mgr.barrelOffsetIndex(invoker, invoker.barrelClass);
				//console.printf("%i %p %p", oid, invoker, invoker.barrelClass);
				if (oid > -1) {
					invoker.barrelOffsets = mgr.getBarrelOffset(oid);
					A_OverlayOffset(invoker.bLayerBarrel, invoker.barrelOffsets.x, invoker.barrelOffsets.y);
					invoker.useBarrelOffsets = true;
				}
				else {
					invoker.barrelOffsets = (0, 0);
					invoker.useBarrelOffsets = false;
				}

			}
			else {
				A_ClearOverlays(invoker.bLayerBarrel, invoker.bLayerBarrel);
			}
		}
	}

	action void GetAttachmentStateScope(AttachmentManager mgr) {
		int sid = -1;
		int oid = -1;

		//console.printf("hi?");
		if (invoker.useScopeOffsets) {
			A_OverlayOffset(invoker.bLayerSight, invoker.scopeOffsets.x, invoker.scopeOffsets.y);
		}
		else {
			A_OverlayOffset(invoker.bLayerSight, 0, 0);
		}

		if (invoker.getScopeSerialID() == 0) {
			invoker.scopeClass = null;
			A_ClearOverlays(invoker.bLayerSight, invoker.bLayerSight);
		}
		else {
			if (!invoker.scopeClass && invoker.getScopeSerialID() > 0) {
				sid = invoker.getScopeSerialID();
				invoker.scopeClass = mgr.getScopeClass(sid);
			}

			sid = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).serialId;
			if (invoker.getScopeSerialID() > 0 && invoker.getScopeSerialID() != sid) {
				sid = invoker.getScopeSerialID();
				invoker.scopeClass = mgr.getScopeClass(sid);
			}

			if (invoker.getScopeSerialID() > 0) {
				//let psp = player.FindPSprite(invoker.bLayerSight);
				//if (!psp) {
					A_Overlay(invoker.bLayerSight, "ScopeOverlay");
				//}
				

				oid = mgr.scopeOffsetIndex(invoker, invoker.scopeClass);
				if (oid > -1) {
					invoker.scopeOffsets = mgr.getScopeOffset(oid);
					A_OverlayOffset(invoker.bLayerSight, invoker.scopeOffsets.x, invoker.scopeOffsets.y);
					invoker.useScopeOffsets = true;
				}
				else {
					invoker.scopeOffsets = (0, 0);
					invoker.useScopeOffsets = false;
				}
				
			}
			else {
				//A_Overlay(invoker.bLayerSight, "LayerDefaultSight");
				A_ClearOverlays(invoker.bLayerSight, invoker.bLayerSight);
			}
		}
	}

	action void GetAttachmentStateMisc(AttachmentManager mgr) {
		int sid = -1;
		int oid = -1;

		if (invoker.useMiscOffsets) {
			A_OverlayOffset(invoker.bLayerMisc, invoker.miscOffsets.x, invoker.miscOffsets.y);
		}
		else {
			A_OverlayOffset(invoker.bLayerMisc, 0, 0);
		}

		if (invoker.getMiscSerialID() == 0) {
			invoker.miscClass = null;
			A_ClearOverlays(invoker.bLayerMisc, invoker.bLayerMisc);
		}
		else {
			if (!invoker.miscClass && invoker.getMiscSerialID() > 0) {
				sid = invoker.getMiscSerialID();
				invoker.miscClass = mgr.getMiscClass(sid);
			}

			sid = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).serialId;
			if (invoker.getMiscSerialID() > 0 && invoker.getMiscSerialID() != sid) {
				sid = invoker.getMiscSerialID();
				invoker.miscClass = mgr.getMiscClass(sid);
			}

			if (invoker.getMiscSerialID() > 0) {
				//let psp = player.FindPSprite(invoker.bLayerMisc);
				//if (!psp) {
					A_Overlay(invoker.bLayerMisc, "MiscOverlay");
				//}

				oid = mgr.miscOffsetIndex(invoker, invoker.miscClass);
				if (oid > -1) {
					invoker.miscOffsets = mgr.getMiscOffset(oid);
					A_OverlayOffset(invoker.bLayerMisc, invoker.miscOffsets.x, invoker.miscOffsets.y);
					invoker.useMiscOffsets = true;
				}
				else {
					invoker.miscOffsets = (0, 0);
					invoker.useMiscOffsets = false;
				}
				
			}
			else {
				A_ClearOverlays(invoker.bLayerMisc, invoker.bLayerMisc);
			}
		}
	}

	action void GetAttachmentState() {
		int sid = -1;
		AttachmentManager mgr = AttachmentManager(EventHandler.Find("AttachmentManager"));
		
		let psp = player.FindPSprite(invoker.bLayerGun);
		//if (!psp) {
			A_Overlay(invoker.bLayerGun, "LayerGun");
			A_Overlay(invoker.bLayerGunBack, "LayerGunBack");
			//A_Overlay(invoker.bLayerSight, "LayerDefaultSight");
		//}

		if (player.health <= 0 && psp) {
			A_ClearOverlays(invoker.bLayerGun, invoker.bLayerGun);
			A_ClearOverlays(invoker.bLayerGunBack, invoker.bLayerGunBack);
			//A_ClearOverlays(invoker.bLayerSight, invoker.bLayerSight);
		}
		
		if (!invoker.getScopeSerialID() && player.health > 0) {
			A_Overlay(invoker.bLayerSight, "LayerDefaultSight");
		}
		else if (invoker.getScopeSerialID() && player.health > 0) {
			GetAttachmentStateScope(mgr);
		}
		else {
			A_ClearOverlays(invoker.bLayerSight, invoker.bLayerSight);
		}
		
		if (player.health > 0) {
			GetAttachmentStateBarrel(mgr);
		}
		else {
			A_ClearOverlays(invoker.bLayerBarrel, invoker.bLayerBarrel);
		}

		if (player.health > 0) {
			GetAttachmentStateMisc(mgr);
		}
		else {
			A_ClearOverlays(invoker.bLayerMisc, invoker.bLayerMisc);
		}
	}

	action void GetMiscState() {
		PlayerInfo info = players[invoker.PlayerNumber()];
		if (!(info.cmd.buttons & BT_SPEED)) {
			FlashLightManager mgr = FlashLightManager(EventHandler.Find("FlashLightManager"));
			mgr.destLight(invoker.PlayerNumber());	
		}
	}

	states {

		Spawn: 
			#### # -1 GetMagState();
			Stop;

		BarrelOverlay:
			TNT1 A 0 {
				if (invoker.barrelClass) {
					string sp = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).BaseSprite;
					int idx = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).BaseFrame;
					let psp = player.FindPSprite(invoker.bLayerBarrel);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		ScopeShaderOverlay: 
			TNT1 A 0 {
				string sp = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).ScopeShaderTexture;
				let psp = player.FindPSprite(invoker.bLayerScopeShader);
				if (psp) {
					psp.sprite = GetSpriteIndex(sp);
					psp.frame = 0;
				}
				A_SetTics(1);
			}
			Stop;

		ScopeOverlay:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					string shader = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).ScopeShaderTexture;
					if (shader != "") {
						//A_Overlay(invoker.bLayerScopeShader, "ScopeShaderOverlay");
					}

					string sp = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).BaseSprite;
					int idx = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).BaseFrame;
					let psp = player.FindPSprite(invoker.bLayerSight);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		MiscOverlay:
			TNT1 A 0 {
				if (invoker.miscClass) {
					string sp;
					int idx;

					if (!invoker.miscActive) {
						sp = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).BaseSprite;
						idx = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).BaseFrame;
					} 
					else {
						sp = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).OnSprite;
						idx = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).OnFrame;
					}

					let psp = player.FindPSprite(invoker.bLayerMisc);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		FlashlightOn:
			TNT1 A 0;
			Stop;

		FlashLightOff:
			TNT1 A 0;
			Stop;

		Ready:
			TNT1 A 0 {
				let psp = player.FindPSprite(invoker.bLayerGun);
				if (!psp) {
					A_Overlay(invoker.bLayerGun, "LayerGun");
				}

			}
			TNT1 A 1 GetAttachmentState();
			#### A 0 {
				if (A_CheckCookoff()) {
					return ResolveState("ReadyEnd");
				}
				if (pressingZoom()) {
					A_ZoomAdjust(I_ZOOM, 16, 70);
				}
				else {
					A_WeaponReady(WRF_ALL);
				}

				if (invoker.firemode() > 2) {
					invoker.setFireMode(2);
				}

				return ResolveState("ReadyEnd");
			}

		SpawnMag:
			#### # -1 {
				sprite = GetSpriteIndex(invoker.BSpriteWithMag);
				frame = invoker.BSpriteWithFrame;
			}
			Goto Super::Spawn;

		SpawnNoMag:
			#### # -1 {
				//console.printf("nomag");

				sprite = GetSpriteIndex(invoker.BSpriteWithoutMag);
				frame = invoker.BSpriteWithoutFrame;
			}
			Goto Super::Spawn;

		Spawn2:
			#### A 0 {
				if (invoker.weaponStatus[I_MAG] > 0) {
					sprite = getSpriteIndex(invoker.bSpriteWithMag);
				}

				if (invoker.weaponStatus[I_MAG] < 0) {
					frame = 1;
				}

				if (invoker.chambered() && !invoker.brokenChamber() && invoker.overheated()) {
					SetStateLabel("SpawnShoot");
				}
				
			}
			Stop;

		SpawnShoot:
			#### A 1;
			Stop;

		User3:
			#### A 0 A_MagManager(invoker.bMagazineClass);
			#### A 0 {
				return ResolveState("Ready");
			}

		Fire:
			#### A 0 {
				return ResolveState("ShootGun");
			}


		ShootGun:
			#### A 0 {
				if (invoker.fireMode() > 0) {
					A_SetTics(invoker.bROF);
				}
			}
			#### A 1 {
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Chamber_Manual");
				}
				else {
					A_Overlay(-500, "Flash");
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1 Offset (0, 42) {
				A_Overlay(invoker.bLayerGun, "LayerGunFire");
			}
			#### B 0 Offset (0, 38) {
				return ResolveState("Chamber");
			}

		Flash:
			TNT1 A 0 {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					let psp = player.FindPSprite(-500);
					//console.printf("PSP? %p", psp);
					if (psp) {
						psp.sprite = GetSpriteIndex(invoker.bFlashSprite);
						psp.frame = random(0, 3);

						PlayerInfo info = players[invoker.playerNumber()];
						invoker.CurSector.lightlevel;

						double ll = invoker.owner.CurSector.LightLevel;
						if (ll < 100.0) {
							ll = 100.0;
						}
						else if (ll > 170) {
							ll = 170.0;
						}

						double offset = invoker.owner.CurSector.LightLevel - 100;

						double alphaLevel = 1.0 - min(0.7, offset / 70.0);
						//console.printf("%f", alphaLevel);


						A_OverlayFlags(-500, PSPF_RENDERSTYLE, true);
						A_OverlayFlags(-500, PSPF_ALPHA, true);
						A_OverlayRenderstyle(-500, STYLE_Translucent);
						A_OverlayAlpha(-500, alphaLevel);

						// BARREL skibbies
						int count = random(1, alphaLevel * 30);
						string colors[] = {
							"#ff7200",
							"#ff5400",
							"#ffc000",
							"#ffda69",
							"#ffed21"
						};
						for (int i = 0; i < count; i++) {
							int xval = cos(random(0, 360) * 3.14) * 80;
							int zval = sin(random(0, 360) * 3.14) * 80;

							int xcel = random(0, 1);
							if (xcel == 0) {
								xcel *= -1;
							}

							double particleZ = 40;

							PlayerInfo pi = players[invoker.PlayerNumber()];
							if (info.cmd.buttons & BT_CROUCH) {
								particleZ = 15;
							}

							A_SpawnParticle(
								colors[random(0, colors.size()-1)],
								SPF_FULLBRIGHT | SPF_RELATIVE, 
								7, // Lifetime
								random(1, 5), // Size
								0, // Angle
								40, // X off
								0, // Y off
								particleZ, // Z off
								50, // xvel
								random(-60, 60), // yvel
								random(-60, 60), // zvel
								random(-4.0, 4.0), // x accel 
								random(-4.0, 4.0), // y accel 
								random(-4.0, 4.0), // z accel
								1.0, // start alpha
								-0.01,
								-0.1


								);
						}
					}
				}
			}
			
			#### # 1 Bright {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					A_Light1();
					HDFlashAlpha(-16);
				}

				bool silenced = invoker.barrelClass is "BaseSilencerAttachment";
				string sound = silenced ? invoker.bSFireSound : invoker.bFireSound;

				A_StartSound(sound, CHAN_WEAPON, CHANF_OVERLAP);
				A_ZoomRecoil(max(0.95, 1. -0.05 * invoker.fireMode()));
				double burn = max(invoker.heatAmount(), invoker.boreStretch()) * 0.01;
				HDBulletActor.FireBullet(self, invoker.bBulletClass, spread: burn > 1.2 ? burn : 0);


				double muzzleMul = 1.0;
				PlayerInfo pi = players[invoker.owner.playerNumber()];
				if (invoker.weaponstatus[I_AUTO] == 1) {
					if (pi.cmd.buttons & BT_FORWARD) {
						muzzleMul = 1.8;
					}
					else {
						muzzleMul = 1.3;
					}
				}

				if (hdplayerpawn(invoker.owner) && hdplayerpawn(invoker.owner).gunbraced) {
					muzzleMul *= 0.5;
				}

				A_MuzzleClimb(
					-frandom(0.1,0.1), -frandom(0,0.1),
					-0.2,              -frandom(0.3,0.4),
					frandom(invoker.BRecoilXLow, invoker.BRecoilXHigh) * muzzleMul, 
					-frandom(invoker.BRecoilYLow, invoker.BRecoilYHigh) * muzzleMul
				);

				// double BRecoilXLow, BRecoilXHigh;
				// double BRecoilYLow, BRecoilYHigh;	
				//invoker.addHeat(random(3, 5));
				invoker.unchamber();

				double fc = max(pitch * 0.01, 5);
				double cosp = cos(pitch);

				// Todo: Configurable property
				A_SPawnItemEx(
					invoker.EjectShellClass,
					cosp * 12, 
					5, 
					height - 12 - sin(pitch) * 6,
					cosp * -2,
					1,
					2 - sin(pitch),
					0,
					SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);

				A_AlertMonsters();
			}
			#### # 0 { 
				return ResolveState("LightDone");
			}

		Firemode:
			#### A 1 {

				if (invoker.weaponStatus[I_FLAGS] > F_NO_FIRE_SELECT) {
					invoker.weaponStatus[I_AUTO] = 0;
					return ResolveState("Nope");
				}

				if (invoker.weaponStatus[I_AUTO] == 0) {
					invoker.WeaponStatus[I_AUTO] = 2;
				}
				else if (invoker.weaponStatus[I_AUTO] == 2) {
					invoker.weaponStatus[I_AUTO] = 1;
				}
				else if (invoker.weaponStatus[I_AUTO] == 1) {
					invoker.WeaponStatus[I_AUTO] = 0;
				}

				A_WeaponReady(WRF_NONE);
				return ResolveState("Nope");
			}

		Chamber:
			#### B 0 Offset(0, 32) {
				if (!invoker.magazineHasAmmo()) {
					return ResolveState("nope");
				}

				if (invoker.magazineGetAmmo() % 999 > 0) {
					if (invoker.magazineGetAmmo() == (invoker.bMagazineCapacity + 1)) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity;
					}
					invoker.magazineAddAmmo(-1);
					invoker.setChamber();

					if (b_weapon_jamming == 1) {
						int rngagain = random(0, 1000000);
						if (rngagain < 50 || rngagain > 999980) {
							//console.printf("break the chamber %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);
							invoker.breakChamber();
							//console.printf("break the chamber %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);
							A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
							//return ResolveState("Nope");
						}
					}

				}
				else {
					invoker.weaponStatus[I_MAG] = min(invoker.magazineGetAmmo(), 0);
					//A_StartSound(invoker.bChamberSound, CHAN_WEAPON, CHANF_OVERLAP);
				}

				//if (BrokenRound()) {
					//return ResolveState("Jam");
				//}
				A_WeaponReady(WRF_NOFIRE);
				return ResolveState(NULL);
			}
			//#### B 1 A_CheckCookoff();
			#### A 1 {
				//A_SetTics(invoker.bROF);
			}
			#### A 0 A_JumpIf(invoker.fireMode() < 1, "Nope");
			#### A 0 A_JumpIf(invoker.fireMode() > 4, "Nope");
			#### A 0 A_JumpIf(invoker.fireMode() > 1, 1);
			#### A 0 A_Refire();
			#### A 0 {
				return ResolveState("Ready");
			}

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0 {
				A_Overlay(invoker.bLayerRHand, "LayerReloadHands");
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 3 Offset(-1, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 999 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity - 1;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}

					//A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
					invoker.setChamber();
					//BrokenRound();
					return ResolveState(NULL);
				}
				//console.printf("noping");
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				A_Overlay(invoker.bLayerGun, "LayerGunBolt");
			}
			#### D 3 offset(0, 36) {
				//A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}


		FinishChamber:
			#### B 1;
			#### A 0 A_CheckCookOff();
			#### A 0 A_Refire();
			#### A 0 {
				return ResolveState("Ready");
			}

		// Maybe one day
		Cookoff:
			#### A 0 {
				A_ClearRefire();
				if (invoker.weaponStatus[I_MAG] >= 0 && JustPressed(BT_RELOAD) || JustPressed(BT_UNLOAD)) {
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, invoker.weaponStatus[I_MAG]);
					invoker.weaponStatus[I_MAG]= -1;
				}
				return ResolveState("ShootGun");
			}

		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				if (invoker.magazineGetAmmo() >= 0) {
					return ResolveState("UnloadMag");
				}
				else if (invoker.chambered() || invoker.brokenChamber()) {
					return ResolveState("UnloadChamber");
				}
				else {
					return ResolveState("Nope");
				}
			}

		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				bool nomags=HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass);
				//console.printf("break the chamber r %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);

				if (invoker.weaponstatus[I_FLAGS] & F_CHAMBER_BROKE) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					//console.printf("break the chamber r2 %i", invoker.weaponStatus[I_FLAGS] & F_CHAMBER_BROKE);
					return ResolveState("UnloadChamber");
				}
				else if (!invoker.chambered() && invoker.weaponStatus[I_MAG] < 1 && (pressingUse() || nomags)) {
					return ResolveState("LoadChamber");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					return ResolveState("UnloadChamber");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass) && invoker.magazineGetAmmo() < invoker.bMagazineCapacity) {
					return ResolveState("UnloadMag");
				}
				else if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 999 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				return ResolveState("Nope");
			}

		LoadChamber:
			---- A 0 A_JumpIf(invoker.weaponStatus[I_MAG] > 0, "Nope");
			---- A 0 A_JumpIf(!CountInv(invoker.bAmmoClass), "Nope");
			---- A 1 Offset (0, 34) A_StartSound("weapons/pocket", 9);
			---- A 1 Offset (-2, 36);
			---- A 1 offset (-2, 44);
			---- A 1 offset (-5, 58);
			---- A 2 offset (-7, 70);
			---- A 6 offset (-8, 80);
			---- A 10 offset (-8, 87) {

				if (CountInv(invoker.bAmmoClass)) {
					A_TakeInventory(invoker.bAmmoClass, 1, TIF_NOTAKEINFINITE);
					invoker.setChamber();
					if (b_weapon_jamming == 1 && random(0, 1000) > 975) {
						invoker.weaponstatus[I_FLAGS] |= F_CHAMBER_BROKE;
						A_StartSound(invoker.bClickSound, 8);
					}
					else {
						A_StartSound(invoker.bBoltForwardSound, 8);
					}
				}
				else {
					A_SetTics(4);
				}

			}
			---- A 3 offset (-9, 76);
			---- A 2 offset (-5, 70);
			---- A 1 offset (-5, 64);
			---- A 1 offset (-5, 52);
			---- A 1 offset (-5, 42);
			---- A 1 offset (-2, 36);
			---- A 2 offset (0, 34);
			---- A 0 {
				return ResolveState("Nope");
			}

		UnloadMag:
			#### A 1 Offset(0, 33);
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-8, 37);
			#### A 2 Offset(-11, 39) {
				//console.printf("unload mag %i", invoker.magazineGetAmmo());
				if (invoker.magazineGetAmmo() < 0) {
					//console.printf("mag out %i", invoker.magazineGetAmmo());
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound(invoker.bUnloadSound, CHAN_WEAPON, CHANF_OVERLAP);
				return ResolveState(NULL);
			}
			#### A 4 Offset(-12, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			}
			#### A 120 offset(-14, 44) {

				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("MagOut");
			}

		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) ;//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
				}
				else {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;

					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					//invoker.weaponStatus[I_MAG]--;
				}
				return ResolveState("ReloadEnd");
			}

		MagOut:
			#### A 4;
			#### A 8 {
				if (invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY || !CountInv(invoker.bMagazineClass)) {
					return ResolveState("ReloadEnd");
				}
				return ResolveState("LoadMag");
			}
			

		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}
				A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
				A_SetTics(10);
				return ResolveState(NULL);
			}
			#### A 8 Offset(-15, 45);
			#### A 1 Offset(-15, 46);
			#### A 1 Offset(-15, 47) A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 10 Offset(-15, 42);
			#### A 1 Offset(-14, 47);
			#### A 1 Offset(-14, 45);
			#### A 1 Offset(-14, 44) {
				//A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
					//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("ReloadEnd");
			}

		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37); //A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				//console.printf("I'm here");
				if (invoker.brokenChamber() || invoker.weaponStatus[I_MAG] > 0) {
					//console.printf("nahing out");
					return ResolveState("Nope");
				}
				return ResolveState("Chamber_Manual");
			}

		Hold:
			#### A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & F_NO_FIRE_SELECT, "Nope");
			#### A 0 A_JumpIf(invoker.weaponstatus[I_AUTO] > 4, "Nope");
			#### A 0 A_JumpIf(invoker.weaponStatus[I_AUTO], "ShootGun");

		Select:
			TNT1 A 0 GetAttachmentState();
			TNT1 A 0 {
				//Console.printf("hi mom");
			}
			Goto super::select;

		Select0:
			#### A 0 GetAttachmentState();
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_GL_MODE;			
			}
			Goto super::select0small;

		deselect:
			TNT1 A 0 A_StartDeselect();

		Deselect0:
			//#### A 0 GetMiscState();
			#### A 0 GetAttachmentState();
			Goto super::deselect0small;

		LayerReloadHands:
			#### A 3; //Offset(-1, 36);
			#### B 3; //Offset(-1, 42);
			#### C 3; //offset(-5, 36);
			#### B 3; //offset(0, 34);
			#### A 2; //offset(0, 34);
			Stop;

		AttachmentStart:
			#### A 1 A_WeaponBusy();
			#### A 0 {
				invoker.attachmentBusy = true;
				A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
				PlayerInfo pl = players[invoker.playernumber()];
				BHDWeapon wep = BHDWeapon(pl.readyWeapon);
				if (wep && wep.lastRef) {
					PlayerPawn player = players[invoker.owner.playernumber()].mo;
					wep.lastRef.ClearAttachment(wep, player);
				}
			}
			//#### A 0 GetAttachmentState();
			#### A 1 Offset(1, 37);
			#### A 1 Offset(1, 38);
			#### A 1 Offset(1, 39);
			#### A 1 Offset(2, 40);
			#### A 1 Offset(2, 41);
			#### A 1 Offset(2, 42);
			#### A 15 Offset(2, 43);
			#### A 1 Offset(1, 44);
			#### A 1 Offset(1, 45);
			#### A 1 Offset(1, 46);
			#### A 1 Offset(1, 45);
			#### A 1 Offset(1, 44);
			#### A 1 Offset(2, 43);
			#### A 0 {
				A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				if (invoker.lastRef) {
					BHDWeapon wep = BHDWeapon(invoker);
					PlayerPawn player = players[invoker.owner.playernumber()].mo;
					invoker.lastRef.AttemptAttach(wep, player);
					TakeInventory(invoker.lastRef.getClassName(), 1);
					invoker.lastRef = null;
				}
			}
			#### A 0 GetAttachmentState();
			#### A 15 Offset(2, 43);
			#### A 1 Offset(2, 42);
			#### A 1 Offset(2, 40);
			#### A 1 Offset(1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				invoker.attachmentBusy = false;
				return ResolveState("Ready");
			}

		BarrelAttachmentRemove:
			#### A 0 {
				invoker.attachmentBusy = true;
			}
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setBarrelSerialID(0);
				invoker.barrelClass = null;
				invoker.useBarrelOffsets = false;
				invoker.barrelOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
			invoker.attachmentBusy = false;
				return ResolveState("Ready");
			}

		ScopeAttachmentRemove:
			#### A 0 {
				invoker.attachmentBusy = true;
			}
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setScopeSerialID(0);
				invoker.scopeClass = null;
				invoker.useScopeOffsets = false;
				invoker.scopeOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				invoker.attachmentBusy = false;
				return ResolveState("Ready");
			}

		MiscAttachmentRemove:
			#### A 0 {
				invoker.attachmentBusy = true;
			}
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setMiscSerialID(0);
				invoker.miscClass = null;
				invoker.useMiscOffsets = false;
				invoker.miscOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				invoker.attachmentBusy = false;
				return ResolveState("Ready");
			}
		
		//A_Overlay(invoker.bLayerGunBack, "NoHandsBack");
		//A_Overlay(invoker.bLayerGun, "NoHandsFront");

		NoHandsBack:
			#### A 1 {
				return ResolveState("LayerGunBack");
			}

		NoHandsFront:
			#### A 1 {
				return ResolveState("LayerGun");
			}
			
		Flashes:
			FLSH A -1;
			FLSH B -1;
			FLSH C -1;
			FLSH D -1;
			FLSH E -1;
			FLSH F -1;
			FLSH G -1;
			FLSH H -1;
			FLSH I -1;

	}

	override void detachfromowner(){
		super.detachfromowner();
	}

	override string gethelptext(){

		return
		WEPHELP_FIRE.."  Shoot\n"
		..WEPHELP_RELOAD.."  Reload mag\n"
		..WEPHELP_UNLOAD.."  Release mag \\ Unchamber\n"
		..WEPHELP_MAGMANAGER;
		
		//..WEPHELP_ALTRELOAD.."  Reload alt\n";
		//..WEPHELP_ALTFIRE..("  Rifle mode\n")

		/*
		   (gl?(WEPHELP_ALTRELOAD.."  Reload GL\n"):"")
		..(glmode?(WEPHELP_FIREMODE.."+"..WEPHELP_UPDOWN.."  Airburst\n")
			:(
			((weaponstatus[0]& I_AUTO)?"":WEPHELP_FIREMODE.."  Semi/Auto/Burst\n")
			..WEPHELP_ZOOM.."+"..WEPHELP_FIREMODE.."+"..WEPHELP_UPDOWN.."  Zoom\n"))
		..WEPHELP_MAGMANAGER
		..WEPHELP_UNLOAD.."  Unload "..(glmode?"GL":"magazine")
		;
		*/
	}

	bool attachmentBusy;
	BaseAttachment lastRef;


}



























class BWeaponGiver : HDWeaponGiver {

	virtual String getWeaponClass() {
		return "";
	}

	virtual String getConfigLine() {
		return "";
	}

	virtual void spawnMagazines() {
		return;
	}

	override void spawnactualweapon() {

		//check if the owner already has this weapon
		bool hasprevious=(
			owner
			&&owner.findinventory(self.getWeaponClass())
		);

		//spawn the weapon
		actualweapon=hdweapon(spawn(self.getWeaponClass(), pos));


		actualweapon.special = special;
		actualweapon.changetid(tid);

		if(owner){
			actualweapon.attachtoowner(owner);

			//apply defaults from owner
			actualweapon.defaultconfigure(player);
		}
		else {
			spawnMagazines();
		}

		//apply config applicable to this weapongiver
		actualweapon.loadoutconfigure(self.getConfigLine());

		//if there was a previous weapon, bring this one down to the spares
		if(hasprevious&&owner.getage()>5){
			actualweapon.AddSpareWeaponRegular(owner);
		}

	}
}