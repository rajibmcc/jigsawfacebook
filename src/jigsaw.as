package
{
	import flash.display.Sprite;
	
	[SWF(frameRate="60", width="800", height="550")]
	public class jigsaw extends Sprite
	{
		private var bgRound:Sprite;
		private var slidingpuzzle:SlidingPuzzle;
		public function jigsaw()
		{			
			bgRound = new Sprite();
			bgRound.graphics.beginFill(0x00FFFF, .5);
			bgRound.graphics.drawRoundRect(0,0,800,500,20,20);
			bgRound.graphics.endFill();
			addChild(bgRound);
			
			
			slidingpuzzle = new SlidingPuzzle();
			addChild(slidingpuzzle);
			
			//just for test
			
			slidingpuzzle.startSlidingPuzzle();
		}
	}
}