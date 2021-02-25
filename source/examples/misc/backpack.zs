
class ItemData {
	string clsName;
	int quantity;
	int chance;
}

class Loadout {
	Array<ItemData> items;
}


class BryanWildBackpack : IdleDummy {

	override void postbeginplay(){
		super.postbeginplay();
		let aaa = HDBackpack(spawn("HDBackpack",pos,ALLOW_REPLACE));
		AddRandomContents(aaa);
		destroy();
	}

	void AddRandomContents(HDBackpack backpack) {
		PlayerEvents evt = PlayerEvents(EventHandler.Find("PlayerEvents"));
		Loadout lout = evt.backpackLoadouts[random(0, evt.backpackLoadouts.size() - 1)];
		LoadoutToBackpack(backpack, lout);
	}

	void LoadoutToBackpack(HDBackpack backpack, Loadout lout) {
		for (int i = 0; i < lout.items.size(); i++) {
			ItemData dat = lout.items[i];
			int score = random(0, 100);
			int target = (100 - dat.chance);
			bool rng = score > target;
			if (rng) {
				int quantity = random(1, dat.quantity);
				backpack.Storage.AddAmount(dat.clsName, quantity, flags: 0);
				//for (int c = 0; c < quantity; c++) {
					//Inventory newItem = Inventory(backpack.Spawn(dat.clsName, self.pos, ALLOW_REPLACE));
					//backpack.itemtobackpack(newItem);
				//}
			}
		}
	}

}