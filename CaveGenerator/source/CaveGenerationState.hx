package;

import org.flixel.FlxCamera;
import flash.events.Event;
import flash.Lib;
import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxAssets;
import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxTilemap;

/**
 * ...
 * @author Zaphod
 */

class CaveGenerationS tate extends FlxState
{

    public var tileMap:FlxTilemap;

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		FlxG.bgColor = 0xffffffff;
		
		// Create cave of size 200x100 tiles
		var cave:FlxCaveGenerator = new FlxCaveGenerator(200, 100);

		// Generate the level and returns a matrix
		// 0 = empty, 1 = wall tile
		var caveMatrix:Array<Array<Int>> = cave.generateCaveLevel();

		// Converts the matrix into a string that is readable by FlxTileMap
		var dataStr:String = FlxCaveGenerator.convertMatrixToStr(caveMatrix);

		// Loads tilemap of tilesize 16x16
		tileMap = new FlxTilemap();
		tileMap.loadMap(dataStr, FlxAssets.imgAuto, 0, 0, FlxTilemap.AUTO);
		add(tileMap);

        Lib.current.stage.addEventListener(Event.RESIZE, handleOnResize);
	}

    public function handleOnResize(?e:Event):Void
    {
        var stageWidth = Lib.current.stage.stageWidth;
        var stageHeight = Lib.current.stage.stageHeight;

        FlxG.resetCameras(new FlxCamera(0, 0, stageWidth, stageHeight));
        FlxG.width = stageWidth;
        FlxG.height = stageHeight;

        tileMap.updateBuffers();
    }

}