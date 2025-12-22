package states.editor;

class CharacterEditor extends StateManager {

    override function create() {
    }

    override function update(e:Float) {
        if (controls.justPressed("back")) {
            CoolUtil.playSound("MenuCancel");
            StateManager.switchState(new states.editor.MainMenuEdt());
        }
    }
}