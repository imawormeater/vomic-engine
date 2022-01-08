package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'assembly':
				if (PlayState.isStoryMode) {
					FlxG.sound.playMusic(Paths.music('DialogueMusic', 'cyrix'), 0.485);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
			case 'voltage':
				if (PlayState.isStoryMode) {
					FlxG.sound.playMusic(Paths.music('DialogueMusic', 'cyrix'), 0.485);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
			case 'integer overflow':
				if (PlayState.isStoryMode) {
					FlxG.sound.playMusic(Paths.music('IntegerDialogue', 'cyrix'), 0.485);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
			case 'system crash':
				if (PlayState.isStoryMode) {
					FlxG.sound.play(Paths.sound('shortcircuit', 'cyrix'), 0.485);

					FlxG.sound.playMusic(Paths.music('OhShitHeGlitch', 'cyrix'), 0.485);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
			default:
				if (PlayState.isStoryMode) {
					FlxG.sound.playMusic(Paths.music('breakfast'), 0.485);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'assembly':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'Speech Bubble Normal Open', 24, false);
				box.setGraphicSize(Std.int(box.width * 1 * 0.9));
				box.y = (FlxG.height - box.height) + 80;
			case 'voltage':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'Speech Bubble Normal Open', 24, false);
				box.setGraphicSize(Std.int(box.width * 1 * 0.9));
				box.y = (FlxG.height - box.height) + 80;
			case 'integer overflow':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'Speech Bubble Normal Open', 24, false);
				box.setGraphicSize(Std.int(box.width * 1 * 0.9));
				box.y = (FlxG.height - box.height) + 80;
			case 'system crash':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'Speech Bubble Normal Open', 24, false);
				box.setGraphicSize(Std.int(box.width * 1 * 0.9));
				box.y = (FlxG.height - box.height) + 80;
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'Speech Bubble Normal Open', 24, false);
				box.setGraphicSize(Std.int(box.width * 1 * 0.9));
				box.y = (FlxG.height - box.height) + 80;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		add(portraitLeft);
		portraitLeft.visible = false;

		// small things: fix thorns layering issue
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
			face.setGraphicSize(Std.int(face.width * 6));
			add(face);
		}

		portraitRight = new FlxSprite(0, 40);
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		// portraitLeft.screenCenter(X);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.BLACK, LEFT);
		//dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		//dropText.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.BLACK, LEFT);

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns') {
			//dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			//dropText.font = 'Pixel Arial 11 Bold';
			//dropText.color = 0xFFD89494;

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}

		//add(dropText);
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		//dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
			
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					switch (PlayState.SONG.song.toLowerCase())
					{
						case 'assembly':
							FlxG.sound.music.fadeOut(2.2, 0);
						default:
							FlxG.sound.music.fadeOut(2.2, 0);
					}

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						//dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);

				portraitLeft.visible = false;
				portraitRight.visible = false;

				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'bf':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 1.0)];
				swagDialogue.color = FlxColor.fromRGB(0, 0, 0);
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.frames = Paths.getSparrowAtlas('ports', 'shared');
					portraitRight.animation.addByPrefix('enter', 'bf port', 24, false);
					portraitRight.scale.set(1.3, 1.3);
					portraitRight.antialiasing = true;
					portraitRight.updateHitbox();
					portraitRight.scrollFactor.set();
					// portraitRight.screenCenter(X);

					portraitRight.x = (box.x + box.width) - (portraitRight.width) - 75;
					portraitRight.y = box.y + -215;

					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				swagDialogue.color = FlxColor.fromRGB(0, 0, 0);
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.frames = Paths.getSparrowAtlas('ports', 'shared');
					portraitLeft.animation.addByPrefix('enter', 'gf port', 24, false);
					portraitLeft.scale.set(1.3, 1.3);
					portraitLeft.antialiasing = true;
					portraitLeft.updateHitbox();
					portraitLeft.scrollFactor.set();
					// portraitLeft.screenCenter(X);

					portraitLeft.x = box.x + 64;
					portraitLeft.y = box.y - 235;

					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
