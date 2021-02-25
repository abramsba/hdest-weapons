// ------------------------------------------------------------
// H.E.R.P. Robot
// ------------------------------------------------------------

class THERPLeg:Actor{
	default{
		+flatsprite +nointeraction +noblockmap
	}
	vector3 relpos;
	double oldfloorz;
	override void Tick(){
		if(!master){destroy();return;}
		binvisible=oldfloorz!=floorz;
		setorigin(master.pos+relpos,true);
		oldfloorz=floorz;
	}
	states{
	spawn:
		HLEG A -1;
		stop;
	}
}
class THERPBot:HDUPK{
	default{
		//$Category "Monsters/Hideous Destructor"
		//$Title "H.E.R.P. Robot"
		//$Sprite "HERPA1"

		+ismonster +noblockmonst +friendly +standstill +nofear
		+shootable +ghost +noblood +dontgib
		+missilemore //on/off
		height 9;radius 7;mass 400;health 200;
		damagefactor "Thermal",0.7;damagefactor "SmallArms3",0.8;
		obituary "%o went THERP.";
		hdupk.pickupmessage ""; //just use the spawned one
		hdupk.pickupsound "";
		tag "T.H.E.R.P. robot";
		scale 0.8;
	}

	//it is now canon: the mag and seal checkers are built inextricably into the AI.
	//if you tried to use a jailbroken mag, the whole robot just segfaults.
	int ammo[3]; //the mag being used: -1-51, -1 no mag, 0 empty, 51 sealed, >100  dirty
	int battery; //the battery, -1-20
	double startangle;
	double startpitch;
	bool scanright;
	int botid;

	override bool cancollidewith(actor other,bool passive){return other.bmissile||HDPickerUpper(other);}

	override void Die(actor source,actor inflictor,int dmgflags){
		super.Die(source,inflictor,dmgflags);
		if(self)bsolid=true;
	}
	override void Tick(){
		if(
			pos.z+vel.z<floorz+12
		){
			vel.z=0;
			setz(floorz+12);
			bnogravity=true;
		}else bnogravity=pos.z-floorz<=12;
		if(bnogravity)vel.xy*=getfriction();
		super.tick();
	}
	override void postbeginplay(){
		super.postbeginplay();
		startangle=angle;
		startpitch=pitch;
		scanright=false;
		if(!master){
			ammo[0]=30;
			ammo[1]=30;
			ammo[2]=30;
			battery=20;
		}
		bool gbg;actor lll;
		[gbg,lll]=A_SpawnItemEx(
			"HERPLeg",xofs:-7,zofs:-12,
			angle:0,
			flags:SXF_NOCHECKPOSITION|SXF_SETMASTER
		);
		HERPLeg(lll).relpos=lll.pos-pos;
		lll.pitch=-60;
		[gbg,lll]=A_SpawnItemEx(
			"HERPLeg",xofs:-7,zofs:-12,
			angle:-120,
			flags:SXF_NOCHECKPOSITION|SXF_SETMASTER
		);
		HERPLeg(lll).relpos=lll.pos-pos;
		lll.pitch=-60;
		[gbg,lll]=A_SpawnItemEx(
			"HERPLeg",xofs:-7,zofs:-12,
			angle:120,
			flags:SXF_NOCHECKPOSITION|SXF_SETMASTER
		);
		HERPLeg(lll).relpos=lll.pos-pos;
		lll.pitch=-60;
	}
	void herpbeep(string snd="herp/beep",double vol=1.){
		A_StartSound(snd,CHAN_VOICE);
		if(
			master
			&&master.player
			&&master.player.readyweapon is "HERPController"
		)master.A_StartSound(snd,CHAN_WEAPON,volume:0.4);
	}
	void message(string msg){
		if(!master)return;
		master.A_Log(string.format("\cd[HERP]\cj  %s",msg),true);
	}
	void scanturn(){
		if(battery<1){
			message("Operational fault. Please check your manual for proper maintenance. (ERR-4fd92-00B) Power low.");
			setstatelabel("nopower");
			return;
		}
		if(health<1){
			A_Die();
			setstatelabel("death");
			return;
		}
		if(!bmissilemore){
			setstatelabel("off");
			return;
		}
		if(bmissileevenmore){
			setstatelabel("inputready");
			return;
		}
		if(!random(0,8192))battery--;
		A_ClearTarget();

		//shoot 5 lines for at least some z-axis awareness
		actor a;int b;int c=-2;
		while(
			c<=1
		){
			c++;
			//shoot a line out
			flinetracedata hlt;
			linetrace(
				angle,4096,c+pitch,
				flags:TRF_NOSKY,
				offsetz:9.5,
				data:hlt
			);

			if(!c&&hlt.hittype!=Trace_HitNone)a_spawnparticle(
				"red",SPF_FULLBRIGHT,lifetime:2,size:2,0,
				hlt.hitlocation.x-pos.x,
				hlt.hitlocation.y-pos.y,
				hlt.hitlocation.z-pos.z
			);

			//if the line hits a valid target, go into shooting state
			actor hitactor=hlt.hitactor;
			if(
				hitactor
				&&isHostile(hitactor)
				&&hitactor.bshootable
				&&!hitactor.bnotarget
				&&!hitactor.bnevertarget
				&&(hitactor.bismonster||hitactor.player)
				&&(!hitactor.player||!(hitactor.player.cheats&CF_NOTARGET))
				&&hitactor.health>random((hitactor.vel==(0,0,0)&&random(0,99))?0:-2,20)
			){
				target=hitactor;
				setstatelabel("ready");
				message("IFF system alert: enemy pattern recognized.");
				if(hd_debug)A_Log(string.format("HERP targeted %s",hitactor.getclassname()));
				return;
			}
		}

		//if nothing, keep moving (add angle depending on scanright)
		angle+=scanright?-3:3;

		//if anglechange is too far, start moving the other way
		double chg=deltaangle(angle,startangle);
		if(abs(chg)>35){
			if(chg<0)scanright=true;
			else scanright=false;
			setstatelabel("postbeep");
		}

		//drift back into home pitch
		if(pitch!=startpitch){
			pitch+=clamp(startpitch-pitch,-2,2);
		}
	}
	actor A_SpawnPickup(){
		let hu=THERPUsable(spawn("THERPUsable",pos,ALLOW_REPLACE));
		if(hu){
			hu.translation=translation;
			if(health<1)hu.weaponstatus[0]|=HERPF_BROKEN;
			hu.weaponstatus[1]=ammo[0];
			hu.weaponstatus[2]=ammo[1];
			hu.weaponstatus[3]=ammo[2];
			hu.weaponstatus[4]=battery;
		}
		destroy();
		return hu;
	}

	states{
	spawn:
		THRP A 0;
	spawn2:
		THRP A 0 A_JumpIfHealthLower(1,"dead");
		THRP A 10 A_ClearTarget();
	idle:
		THRP A 2 scanturn();
		wait;
	postbeep:
		THRP A 6 herpbeep("herp/beep");
		goto idle;


	inputwaiting:
		THRP A 4;
		THRP A 0{
			if(!master){
				setstatelabel("spawn");
				return;
			}
			herpbeep("herp/beep");
			message("Establishing connection...");
			A_SetTics(random(10,min(350,int(0.3*distance3d(master)))));
		}
		THRP A 20{
			if(master){
				bmissileevenmore=true;
				herpbeep("herp/beepready");
				message("Connected!");
			}else{
				setstatelabel("inputabort");
				return;
			}
		}
	inputready:
		THRP A 1 A_JumpIf(
			!master
			||!master.player
			||!(master.player.readyweapon is "HERPController")
		,"inputabort");
		wait;
	inputabort:
		THRP A 4{bmissileevenmore=false;}
		THRP A 2 herpbeep("herp/beepready");
		THRP A 20 message("Disconnected.");
		goto spawn;


	ready:
		THRP A 7 A_StartSound("bots/therp/warning", CHAN_BODY, CHANF_OVERLAP);
		THRP AAA 1 herpbeep("herp/beepready");
	aim:
		THRP A 2 A_FaceTarget(2.,2.,0,0,FAF_TOP,-4);
	shoot:
		THRP B 2 bright light("SHOT"){
			int currammo=ammo[0];
			if(
				(
					currammo<1
					&&ammo[1]<1
					&&ammo[2]<1
				)||(currammo>100&&!random(0,7))
			){
				message("Operational fault. Please check your manual for proper maintenance. (ERR-42392-41A) Cartridge empty. Shutting down...");
				if(currammo>60&&!random(0,3))ammo[0]--;
				setstatelabel("off");
				return;
			}
			if(currammo<1&&ammo[1]>0){
				setstatelabel("swapmag");
				return;
			}

			//deplete 1 round
			if(currammo>60){
				//"100" is an empty mag so set it to empty
				if(currammo==61)ammo[0]=0;
				else ammo[0]--;
			}else if(currammo>30){
				//51-99 = sealed mag, break seal and deplete one = 49
				ammo[0]=29;
			}else ammo[0]--;

			A_StartSound("weapons/m4/fire",CHAN_WEAPON,CHANF_OVERLAP);
			double cosp = cos(pitch);

			A_SPawnItemEx(
					"B556Spent",
					cosp * 2, 
					0, 
					height - 12 - sin(pitch) * 6,
					cosp * -2,
					1,
					2 - sin(pitch),
					0,
					SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
			HDBulletActor.FireBullet(self,"HDB_556", zofs:6, spread:1, distantsound: "world/herpfar");

		}
		THRP C 1{
			angle-=frandom(0.4,1.);
			pitch-=frandom(0.8,1.3);
			if(bfriendly)A_AlertMonsters(0,AMF_TARGETEMITTER);
			else A_AlertMonsters();
		}
		THRP A 0{
			if(ammo[0]<1){
				setstatelabel("swapmag");
			}else if(target && target.health>random(-30,30)){
				flinetracedata herpline;
				linetrace(
					angle,4096,pitch,
					offsetz:12,
					data:herpline
				);
				if(herpline.hitactor!=target){
					if(checksight(target))setstatelabel("aim");
					else target=null;
				}else setstatelabel("shoot");
			}
		}goto idle;
	swapmag:
		THRP A 3{
			int nextmag=ammo[1];
			if(
				nextmag<1
				||nextmag==100
				||(nextmag>100&&!random(0,3))
			){
				message("Operational fault. Please check your manual for proper maintenance. (ERR-42392-41A) Cartridge empty. Shutting down...");
				A_StartSound("bots/therp/downed",8,CHANF_OVERLAP);
				setstatelabel("off");
			}else{
				int currammo=ammo[0];
				if(currammo>=0){
					let mmm=B556Mag(spawn("B556Mag",(pos.xy,pos.z-6)));
					mmm.mags.clear();mmm.mags.push(max(0,currammo));
					double angloff=angle+100;
					mmm.vel=(cos(angloff),sin(angloff),1)*frandom(0.7,1.3)+vel;
				}
				ammo[0]=ammo[1];
				ammo[1]=ammo[2];
				ammo[2]=-1;
			}
		}goto idle;
	nopower:
		THRP A -1;
	off:
		THRP A 10{
			if(health>0){
				double turn=clamp(deltaangle(angle,startangle),-24,24);
				if(turn){
					A_StartSound("herp/crawl",CHAN_BODY,volume:0.6);
					angle+=turn;
					A_SetTics(5);
				}
			}
		}
		THRP A 0{
			if(
				!bmissilemore
				||absangle(angle,startangle)>12
				||(
					ammo[0]%100<1
					&&ammo[1]%100<1
					&&ammo[2]%100<1
				)
			)setstatelabel("off");
		}goto idle;
	give:
		---- A 0{
			let hu=A_SpawnPickup();
			if(hu){
				hu.translation=self.translation;
				grabthinker.grab(target,hu);
			}
			let ctr=HERPController(target.findinventory("HERPController"));
			if(ctr)ctr.UpdateHerps(false);
		}stop;
	death:
		THRP A 0{
			if(ammo[0]>=0)ammo[0]=random(0,ammo[0]+randompick(0,0,0,100));
			if(ammo[1]>=0)ammo[1]=random(0,ammo[1]+randompick(0,0,0,100));
			if(ammo[2]>=0)ammo[2]=random(0,ammo[2]+randompick(0,0,0,100));
			battery=min(battery,random(-1,20));
			if(battery<0){
				A_GiveInventory("Heat",1000);
				ammo[0]=min(ammo[0],0);
				ammo[1]=min(ammo[1],0);
				ammo[2]=min(ammo[2],0);
			}
			A_NoBlocking();
			A_StartSound("world/shotgunfar",CHAN_BODY,CHANF_OVERLAP,0.4);
		}
		THRP A 1 A_StartSound("weapons/bigcrack",15);
		THRP A 1 A_StartSound("weapons/bigcrack",16);
		THRP A 1 A_StartSound("weapons/bigcrack",17);
		THRP AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("HugeWallChunk",random(-6,6),random(-6,6),random(0,6), vel.x+random(-6,6),vel.y+random(-6,6),vel.z+random(1,8),0,SXF_NOCHECKPOSITION|SXF_ABSOLUTEMOMENTUM);
		THRP A 0{
			A_StartSound("bots/therp/downed",CHAN_WEAPON,CHANF_OVERLAP);
			string yay="";
			switch(random(0,8)){
			case 0:
				yay="Operational fault. Please check your manual for proper maintenance. (ERR-4fd92-00B) Power low.";break;
			case 1:
				yay="Operational fault. Please check your manual for proper maintenance. (ERR-74x29-58A) Unsupported ammunition type.\n\n\cjPlease note: Reloading a 4.26 UAC Standard magazine or its components without the supervision of a Volt UAC Standard Certified Cartridge Professional(tm) is a breach of the Volt End User License Agreement.";break;
			case 2:
				yay="Operational fault. Please check your manual for proper maintenance. (ERR-8w8i7-8VX) No interface detected.";break;
			case 3:
				yay="Illegal operation. Please check your manual for proper maintenance. (ERR-u0H85-6NN) System will restart.";break;
			case 4:
				yay="Illegal operation. Identify Friend/Foe system has been tampered with. Please contact your commanding officer immediately. (ERR-0023j-000) System will halt.";break;
			case 5:
				yay="Formatting C:\\ (DBG-444j2-0A0)";break;
			case 6:
				yay="Testing mode initialized.  (DBG-86nm8-BN5) Cache cleared.";break;
			case 7:
				yay="*** Fatal Error *** Address not mapped to object (signal 11) Address: 0x8";break;
			case 8:
				yay="*** Fatal Error *** Segmentation fault (signal 11) Address: (nil)";break;
			}
			if(!random(0,3))yay="\cg"..yay;
			message(yay);
		}
		THRP AAA 1 A_SpawnItemEx("HDSmoke",random(-2,2),random(-2,2),random(-2,2), vel.x+random(-2,2),vel.y+random(-2,2),vel.z+random(1,4),0,SXF_NOCHECKPOSITION|SXF_ABSOLUTEMOMENTUM);
		THRP AAA 3 A_SpawnItemEx("HDSmoke",random(-2,2),random(-2,2),random(-2,2), vel.x+random(-2,2),vel.y+random(-2,2),vel.z+random(1,4),0,SXF_NOCHECKPOSITION|SXF_ABSOLUTEMOMENTUM);
		THRP AAA 9 A_SpawnItemEx("HDSmoke",random(-2,2),random(-2,2),random(-2,2), vel.x+random(-2,2),vel.y+random(-2,2),vel.z+random(1,4),0,SXF_NOCHECKPOSITION|SXF_ABSOLUTEMOMENTUM);
	dead:
		THRP A -1 A_SpawnPickup();
		stop;
	}
}

class EnemyTHERP:THERPBot{
	default{
		//$Category "Monsters/Hideous Destructor"
		//$Title "H.E.R.P. Robot (Hostile)"
		//$Sprite "HERPA1"

		-friendly
		translation "112:120=152:159","121:127=9:12";
	}
}

class BrokenTHERP:THERPBot{
	default{
		//$Category "Monsters/Hideous Destructor"
		//$Title "H.E.R.P. Robot (Broken)"
		//$Sprite "HERPA1"
		translation "112:120=152:159","121:127=9:12";
	}
	override void postbeginplay(){
		super.postbeginplay();
		A_Die("spawndead");
	}
	states{
	spawn:
		THRP A -1;
		stop;
	death.spawndead:
		THRP A -1{
			ammo[0]=random(0,ammo[0]+randompick(0,0,0,100));
			ammo[1]=random(0,ammo[1]+randompick(0,0,0,100));
			ammo[2]=random(0,ammo[2]+randompick(0,0,0,100));
			battery=min(battery,random(-1,20));
			if(battery<0){
				ammo[0]=0;ammo[1]=0;ammo[2]=0;
			}
			A_NoBlocking();
			A_SpawnPickup();
		}stop;
	}
}

class THERPUsable:HDWeapon{
	default{
		//$Category "Items/Hideous Destructor"
		//$Title "H.E.R.P. Robot (Pickup)"
		//$Sprite "HERPA1"

		+weapon.wimpy_weapon
		+inventory.invbar
		+hdweapon.droptranslation
		+hdweapon.fitsinbackpack
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.icon "THRPEX";
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "Picked up a Tactical Heavy Engagement Rotary Platform robot.";
		tag "T.H.E.R.P. robot";
		hdweapon.refid "thp";
		weapon.selectionorder 1015;
	}
	override string pickupmessage(){
		if(weaponstatus[0]&HERPF_BROKEN)return super.pickupmessage().." It is damaged.";
		return super.pickupmessage();
	}
	override bool AddSpareWeapon(actor newowner){return AddSpareWeaponRegular(newowner);}
	override hdweapon GetSpareWeapon(actor newowner,bool reverse,bool doselect){return GetSpareWeaponRegular(newowner,reverse,doselect);}
	override double gunmass(){
		double amt=9+weaponstatus[HERP_BATTERY]<0?0:1;
		if(weaponstatus[1]>=0)amt+=3.6;
		if(weaponstatus[2]>=0)amt+=3.6;
		if(weaponstatus[3]>=0)amt+=3.6;
		if(owner&&owner.player.cmd.buttons&BT_ZOOM)amt*=frandom(3,4);
		return amt;
	}
	override double weaponbulk(){
		double enc=ENC_HERP;
		for(int i=1;i<4;i++){
			if(weaponstatus[i]>=0)enc+=max(ENC_426MAG*0.2,weaponstatus[i]*ENC_426*0.8);
		}
		if(owner&&owner.player.cmd.buttons&BT_ZOOM)enc*=2;
		return enc;
	}
	override int getsbarnum(int flags){return weaponstatus[HERP_BOTID];}
	override void InitializeWepStats(bool idfa){
		weaponstatus[HERP_BATTERY]=20;
		weaponstatus[1]=30;
		weaponstatus[2]=30;
		weaponstatus[3]=30;
	}
	action void A_ResetBarrelSize(){
		invoker.weaponstatus[HERP_YOFS]=100;
		invoker.barrellength=0;
		invoker.barrelwidth=0;
		invoker.barreldepth=0;
		invoker.bobspeed=2.4;
		invoker.bobrangex=0.2;
		invoker.bobrangey=0.8;
	}
	action void A_RaiseBarrelSize(){
		invoker.barrellength=25;
		invoker.barrelwidth=3;
		invoker.barreldepth=3;
		invoker.bobrangex=8.2;
		invoker.bobrangey=4.6;
		invoker.bobspeed=2.8;
	}
	states{
	select:
		TNT1 A 0 A_ResetBarrelSize();
		goto super::select;
	ready:
		TNT1 A 0 A_JumpIf(pressingzoom(),"raisetofire");
		TNT1 A 1 A_HERPWeaponReady();
		goto readyend;
		
	user3:
		TNT1 A 0 A_MagManager("B556Mag");
		TNT1 A 1 A_WeaponReady(WRF_NOFIRE);
		goto nope;

	unload:
		TNT1 A 0 A_JumpIf(invoker.weaponstatus[1]<0
			&&invoker.weaponstatus[2]<0
			&&invoker.weaponstatus[3]<0,"altunload");
		TNT1 A 0{invoker.weaponstatus[0]|=HERPF_UNLOADONLY;}
		//fallthrough to unloadmag
	unloadmag:
		TNT1 A 14;
		TNT1 A 5 A_UnloadMag();
		TNT1 A 0 A_JumpIf(invoker.weaponstatus[0]&HERPF_UNLOADONLY,"reloadend");
		goto reloadend;
	reload:
		TNT1 A 0 A_JumpIf(B556Mag.NothingLoaded(self,"B556Mag"),"nope");
		TNT1 A 14 A_StartSound("weapons/pocket",9);
		TNT1 A 5 A_LoadMag();
		goto reloadend;

	altreload:
		TNT1 A 0 A_JumpIf(pressinguse()||pressingzoom(),"altunload");
		TNT1 A 0{
			if(HDBattery.NothingLoaded(self,"HDBattery"))setweaponstate("nope");
			else invoker.weaponstatus[0]&=~HERPF_UNLOADONLY;
		}goto unloadbattery;
	altunload:
		TNT1 A 0{invoker.weaponstatus[0]|=HERPF_UNLOADONLY;}
		//fallthrough to unloadbattery
	unloadbattery:
		TNT1 A 20;
		TNT1 A 5 A_UnloadBattery();
		TNT1 A 0 A_JumpIf(invoker.weaponstatus[0]&HERPF_UNLOADONLY,"reloadend");
	reloadbattery:
		TNT1 A 14 A_StartSound("weapons/pocket",9);
		TNT1 A 5 A_LoadBattery();
	reloadend:
		TNT1 A 6;
		goto ready;
	spawn:
		THRP A -1;
		stop;

	//for manual carry-firing
	raisetofire:
		TNT1 A 8 A_StartSound("herp/crawl",8,CHANF_OVERLAP,1.);
		HERG A 1 offset(0,80) A_StartSound("herp/beepready",8,CHANF_OVERLAP);
		HERG A 1 offset(0,60);
		HERG A 1 offset(0,50) A_RaiseBarrelSize();
		HERG A 1 offset(0,40);
		HERG A 1 offset(0,34);
	readytofire:
		HERG A 1{
			if(pressingzoom()){
				if(pressingfire())setweaponstate("directfire");
				if(pitch<10&&!gunbraced())A_MuzzleClimb(frandom(-0.1,0.1),frandom(0.,0.1));
			}else{
				setweaponstate("lowerfromfire");
			}
		}
		THRP A 0 A_ReadyEnd();
		loop;
	directfire:
		HERG A 2{
			if(invoker.weaponstatus[HERP_BATTERY]<1){
				setweaponstate("directfail");
				return;
			}
			int currammo=invoker.weaponstatus[1];

			//check ammo and cycle mag if necessary
			if(
				!currammo
				||currammo>100
			){
				let mmm=B556Mag(spawn("B556Mag",(pos.xy,pos.z+height-20)));
				mmm.mags.clear();mmm.mags.push(max(0,currammo));
				double angloff=angle+100;
				mmm.vel=(cos(angloff),sin(angloff),1)*frandom(0.7,1.3)+vel;
				invoker.weaponstatus[1]=-1;
			}
			if(
				invoker.weaponstatus[1]<0
			){
				invoker.weaponstatus[1]=invoker.weaponstatus[2];
				invoker.weaponstatus[2]=invoker.weaponstatus[3];
				invoker.weaponstatus[3]=-1;

				int curmag=invoker.weaponstatus[1];
				if(
					curmag>0
					&&curmag<31
					&&!random(0,15)
				)invoker.weaponstatus[1]+=100;

				return;
			}

			//deplete ammo and fire
			//if(invoker.weaponstatus[1]==51)invoker.weaponstatus[1]=49;
			else 
			invoker.weaponstatus[1]--;				
			A_Overlay(PSP_FLASH,"directflash");
		}
		HERG B 2;
		HERG A 0 A_JumpIf(!pressingzoom(),"lowerfromfire");
		HERG A 0 A_Refire("directfire");
		goto readytofire;
	directflash:
		HERF A 1 bright{
			HDFlashAlpha(-16);
			HDBulletActor.FireBullet(
				self,"HDB_426",zofs:height-12,
				spread:1,
				distantsound:"world/herpfar"
			);
			A_StartSound("weapons/m4/fire",CHAN_WEAPON,CHANF_OVERLAP);
			A_ZoomRecoil(max(0.95,1.-0.05*min(invoker.weaponstatus[ZM66S_AUTO],3)));
			A_MuzzleClimb(
				frandom(-0.2,0.2),frandom(-0.4,0.2),
				frandom(-0.4,0.4),frandom(-0.6,0.4),
				frandom(-0.4,0.4),frandom(-1.,0.6),
				frandom(-0.8,0.8),frandom(-1.6,0.8)
			);
		}stop;
	directfail:
		THRP # 1 A_WeaponReady(WRF_NONE);
		THRP # 0 A_JumpIf(pressingfire(),"directfail");
		goto readytofire;
	lowerfromfire:
		THRP A 1 offset(0,34) A_ClearRefire();
		THRP A 1 offset(0,40) A_StartSound("herp/beepready",8);
		THRP A 1 offset(0,50);
		THRP A 1 offset(0,60);
		THRP A 1 offset(0,80)A_ResetBarrelSize();
		TNT1 A 1 A_StartSound("herp/crawl",8);
		TNT1 A 1 A_JumpIf(pressingfire()||pressingaltfire(),"nope");
		goto select;



	readytorepair:
		TNT1 A 1{
			if(!pressingfire())setweaponstate("nope");
			else if(justpressed(BT_RELOAD)){
				if(invoker.weaponstatus[HERP_BATTERY]>=0){
					message("Damaged beyond function. Remove battery before attempting repairs.");
				}else setweaponstate("repairbash");
			}
		}
		wait;
	repairbash:
		TNT1 A 5 A_RepairAttempt();
		TNT1 A 0 A_JumpIf(!(invoker.weaponstatus[0]&HERPF_BROKEN),"nope");
		goto readytorepair;
	}




	action void Message(string msg){
		A_Log("\cd[HERP]\cj  "..msg,true);
	}
	action void A_LoadMag(){
		let magg=B556Mag(findinventory("B556Mag"));
		if(!magg)return;
		for(int i=1;i<4;i++){
			if(invoker.weaponstatus[i]<0){
				int toload=magg.takemag(true);
				invoker.weaponstatus[i]=toload;
				break;
			}
		}
	}
	action void A_UnloadMag(){
		bool unsafe=(player.cmd.buttons&BT_USE)||(player.cmd.buttons&BT_ZOOM);
		for(int i=3;i>0;i--){
			int thismag=invoker.weaponstatus[i];
			if(thismag<0)continue;
			if(unsafe||!thismag||thismag>30){
				invoker.weaponstatus[i]=-1;
				if(thismag>31)thismag%=30;
				if(pressingunload()||pressingreload()){
					B556Mag.GiveMag(self,"B556Mag",thismag);
					A_StartSound("weapons/pocket",9);
					A_SetTics(20);
				}
					else B556Mag.SpawnMag(self,"B556Mag",thismag);
				break;
			}
		}
	}
	action void A_LoadBattery(){
		if(invoker.weaponstatus[4]>=0)return;
		let batt=HDBattery(findinventory("HDBattery"));
		if(!batt)return;
		int toload=batt.takemag(true);
		invoker.weaponstatus[4]=toload;
		A_StartSound("weapons/vulcopen1",8,CHANF_OVERLAP);
	}
	action void A_UnloadBattery(){
		int batt=invoker.weaponstatus[4];
		if(batt<0)return;
		if(pressingunload()||pressingreload()){
			HDBattery.GiveMag(self,"HDBattery",batt);
			A_StartSound("weapons/pocket",9);
			A_SetTics(20);
		}else HDBattery.SpawnMag(self,"HDBattery",batt);
		invoker.weaponstatus[4]=-1;
	}
	action void A_HERPWeaponReady(){
		if(invoker.amount<1){
			invoker.goawayanddie();
			return;
		}
		if(pressingfire()){
			int yofs=invoker.weaponstatus[HERP_YOFS];
			yofs=max(yofs+12,yofs*3/2);
			if(yofs>100)A_DeployHERP();
			invoker.weaponstatus[HERP_YOFS]=yofs;
		}else invoker.weaponstatus[HERP_YOFS]=invoker.weaponstatus[HERP_YOFS]*2/3;
		if(pressingfiremode()){
			int inputamt=clamp((player.cmd.pitch>>8),-4,4);
			inputamt+=(justpressed(BT_ATTACK)?1:justpressed(BT_ALTATTACK)?-1:0);
			hijackmouse();
			invoker.weaponstatus[HERP_BOTID]=clamp(
				invoker.weaponstatus[HERP_BOTID]-inputamt,0,63
			);
		}else if(justpressed(BT_ALTATTACK)){
			invoker.weaponstatus[0]^=HERPF_STARTOFF;
			A_StartSound("weapons/fmswitch",8,CHANF_OVERLAP);
		}else A_WeaponReady(WRF_NOFIRE|WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER3|WRF_ALLOWUSER4);
	}
	action void A_DeployHERP(){
		if(invoker.weaponstatus[0]&HERPF_BROKEN){
			setweaponstate("readytorepair");
			return;
		}
		if(invoker.weaponstatus[4]<1){
			message("No power. Please load 1 cell pack before deploying.");
			setweaponstate("nope");
			return;
		}

		actor hhh;int iii;
		[iii,hhh]=A_SpawnItemEx("THERPBot",5,0,height-16,
			2.5*cos(pitch),0,-2.5*sin(pitch),
			0,SXF_NOCHECKPOSITION|SXF_TRANSFERTRANSLATION
			|SXF_TRANSFERPOINTERS|SXF_SETMASTER
		);
		hhh.A_StartSound("misc/w_pkup",5);
		hhh.changetid(HERP_TID);
		hhh.vel+=vel;hhh.angle=angle;
		let hhhh=THERPBot(hhh);
		hhhh.startangle=angle;
		hhhh.ammo[0]=invoker.weaponstatus[1];
		hhhh.ammo[1]=invoker.weaponstatus[2];
		hhhh.ammo[2]=invoker.weaponstatus[3];
		hhhh.battery=invoker.weaponstatus[4];
		hhhh.botid=invoker.weaponstatus[HERP_BOTID];
		hhhh.bmissilemore=invoker.weaponstatus[0]&HERPF_STARTOFF?false:true;
		A_Log(string.format("\cd[THERP] \cjDeployed with tag ID \cy%i",invoker.weaponstatus[HERP_BOTID]),true);
		A_GiveInventory("HERPController");
		HERPController(findinventory("HERPController")).UpdateHerps(false);
		dropinventory(invoker);
		invoker.destroy();
		return;
	}
	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		int batt=hdw.weaponstatus[4];

		//bottom status bar
		for(int i=2;i<4;i++){
			if(hdw.weaponstatus[i]>=0)sb.drawrect(-11-i*4,-15,3,2);
		}
		sb.drawwepnum(hdw.weaponstatus[1] % 100, 30, posy:-10);
		sb.drawwepcounter(hdw.weaponstatus[0]&HERPF_STARTOFF,
			-28,-16,"STBURAUT","blank"
		);

		if(!batt)sb.drawstring(
			sb.mamountfont,"00000",(-16,-8),
			sb.DI_TEXT_ALIGN_RIGHT|sb.DI_TRANSLATABLE|sb.DI_SCREEN_CENTER_BOTTOM,
			Font.CR_DARKGRAY
		);else if(batt>0)sb.drawwepnum(batt,20);

		if(barrellength>0)return;

		int yofs=weaponstatus[HERP_YOFS];
		if(yofs<70){
			vector2 bob=hpl.hudbob*0.2;
			bob.y+=yofs;
			sb.drawimage("THRPA7A3",(10,14)+bob,
				sb.DI_SCREEN_CENTER|sb.DI_ITEM_CENTER|sb.DI_TRANSLATABLE,
				scale:(2,2)
			);
			for(int i=1;i<4;i++){
				int bbb=hdw.weaponstatus[i];
				if(bbb>=30)sb.drawimage("M4RCA0",(-20,i*10)+bob,
					sb.DI_SCREEN_CENTER|sb.DI_ITEM_CENTER,
					scale:(2,2)
				);else if(bbb>=0)sb.drawbar(
					"M4RCA0","M4RCB0",
					bbb,50,
					(-20,i*10)+bob,-1,
					sb.SHADER_VERT,sb.DI_SCREEN_CENTER|sb.DI_ITEM_CENTER
				);
			}
			if(batt>=0){
				string batsprite;
				if(batt>13)batsprite="CELLA0";
				else if(batt>6)batsprite="CELLB0";
				else batsprite="CELLC0";
				sb.drawimage(batsprite,(0,30)+bob,
					sb.DI_SCREEN_CENTER|sb.DI_ITEM_CENTER
				);
			}
		}
	}
	override string gethelptext(){
		return
		((weaponstatus[0]&HERPF_BROKEN)?
		(WEPHELP_FIRE.."+"..WEPHELP_RELOAD.."  Repair\n"):(WEPHELP_FIRE.."  Deploy\n"))
		..WEPHELP_ALTFIRE.."  Cycle modes\n"
		..WEPHELP_FIREMODE.."+"..WEPHELP_UPDOWN.."  Set BotID\n"
		..WEPHELP_RELOAD.."  Reload mag\n"
		..WEPHELP_ALTRELOAD.."  Reload battery\n"
		..WEPHELP_UNLOAD.."  Unload mag\n"
		..WEPHELP_USE.."+"..WEPHELP_ALTRELOAD.."  Unload battery\n"
		..WEPHELP_USE.."+"..WEPHELP_UNLOAD.."  Unload partial mag\n"
		..WEPHELP_ZOOM.."  Manual firing"
		;
	}

	static int backpackrepairs(actor owner,hdbackpack bp){
		if(!owner||!bp)return 0;
		StorageItem si=bp.Storage.Find('therpusable');
		int fixbonus=0;
		if (si){
			for(int i=0;si.Amounts.Size()>0&&i<si.Amounts[0];){
				if (si.WeaponStatus[HDWEP_STATUSSLOTS*i]&HERPF_BROKEN){
					if (!random(0,7-fixbonus)){
						//fix
						si.WeaponStatus[HDWEP_STATUSSLOTS*i]&=~HERPF_BROKEN;
						if (fixbonus>0)fixbonus--;
						owner.A_Log("You repair one of the broken T.H.E.R.P.s in your backpack.",true);
					}else if(!random(0,7)){
						fixbonus++;
						//delete and restart
						bp.Storage.RemoveItem(si,null,null,index:i);
						i=0;
						owner.A_Log("You destroy one of the broken T.H.E.R.P.s in your backpack in your repair efforts.",true);
						continue;
					}
				}
				i++;
			}
		}
		return fixbonus;
	}



	action void A_RepairAttempt(){
		if(!invoker.RepairAttempt())return;
		if(!(invoker.weaponstatus[0]&HERPF_BROKEN))A_SetHelpText();
		A_MuzzleClimb(
			frandom(-1.,1.),frandom(-1.,1.),
			frandom(-1.,1.),frandom(-1.,1.),
			frandom(-1.,1.),frandom(-1.,1.),
			frandom(-1.,1.),frandom(0.,1.)
		);
	}
	bool RepairAttempt(){
		if(!owner)return false;
		int failchance=40;
		int spareindex=-1;
		//find spares, whether to cannibalize or copy
		let spw=spareweapons(owner.findinventory("spareweapons"));
		if(spw){
			for(int i=0;i<spw.weapontype.size();i++){
				if(
					spw.weapontype[i]==getclassname()
					&&spw.GetWeaponValue(i,0)&HERPF_BROKEN
				){
					if(spareindex==-1)spareindex=i;
					failchance=min(10,failchance-5);
					break;
				}
			}
		}
		if(!random(0,failchance)){
			weaponstatus[0]&=~HERPF_BROKEN;
			owner.A_StartSound("herp/repair",CHAN_WEAPON);
			owner.A_Log("You bring your T.H.E.R.P. back into working condition.",true);
			//destroy one spare
			if(
				spareindex>=0
				&&!random(0,3)
			){
				spw.weaponbulk.delete(spareindex);
				spw.weapontype.delete(spareindex);
				spw.weaponstatus.delete(spareindex);
				owner.A_Log("Another T.H.E.R.P. was cannibalized for parts.",true);
			}
		}else owner.A_StartSound("herp/repairtry",CHAN_WEAPONBODY,CHANF_OVERLAP,
			volume:frandom(0.6,1.),pitch:frandom(0.7,1.4)
		);
		return true;
	}
	override void consolidate(){
		if(!owner)return;
		int fixbonus=backpackrepairs(owner,hdbackpack(owner.findinventory("HDBackpack")));
		let spw=spareweapons(owner.findinventory("spareweapons"));
		if(spw){
			for(int i=0;i<spw.weapontype.size();i++){
				if(spw.weapontype[i]!=getclassname())continue;
				array<string>wpst;wpst.clear();
				spw.weaponstatus[i].split(wpst,",");
				int wpstint=wpst[0].toint();
				if(
					wpstint&HERPF_BROKEN
				){
					if(!random(0,max(0,7-fixbonus))){
						if(fixbonus>0)fixbonus--;
						wpstint&=~HERPF_BROKEN;
						owner.A_Log("You repair one of your broken T.H.E.R.P.s.",true);
						string newwepstat=spw.weaponstatus[i];
						newwepstat=wpstint..newwepstat.mid(newwepstat.indexof(","));
						spw.weaponstatus[i]=newwepstat;
					}else if(!random(0,7)){
						//delete
						fixbonus++;
						spw.weaponbulk.delete(i);
						spw.weapontype.delete(i);
						spw.weaponstatus.delete(i);
						owner.A_Log("You destroy one of your broken T.H.E.R.P.s in your repair efforts.",true);
						//go back to start
						i=0;
						continue;
					}
				}
			}
		}
		if(
			(weaponstatus[0]&HERPF_BROKEN)
			&&!random(0,7-fixbonus)
		){
			weaponstatus[0]&=~HERPF_BROKEN;
			owner.A_Log("You manage some improvised field repairs to your T.H.E.R.P. robot.",true);
		}
	}
	override void DropOneAmmo(int amt){
		if(owner){
			amt=clamp(amt,1,10);
			if(owner.countinv("FourMilAmmo"))owner.A_DropInventory("FourMilAmmo",50);
			else{
				owner.angle-=10;
				owner.A_DropInventory("B556Mag",1);
				owner.angle+=20;
				owner.A_DropInventory("HDBattery",1);
				owner.angle-=10;
			}
		}
	}
	override void ForceBasicAmmo(){
		owner.A_TakeInventory("FourMilAmmo");
		owner.A_TakeInventory("B556Mag");
		owner.A_GiveInventory("B556Mag",3);
		owner.A_TakeInventory("HDBattery");
		owner.A_GiveInventory("HDBattery");
	}
}


