package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	[SWF(frameRate="60", width="800", height="550")]
	public class jigsaw extends Sprite
	{
		private var bgRound:Sprite;
		private var slidingpuzzle:SlidingPuzzle;
		
		//buttons
		private var startBt:Bt_start;
		private var inviteBt:Bt_invite;
		private var resetBt:Bt_reset;
		private var postBt:Bt_postStory;
		public function jigsaw()
		{		
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "puzz puzz initiated");
			
			bgRound = new Sprite();
			bgRound.graphics.beginFill(0x00FFFF, .5);
			bgRound.graphics.drawRoundRect(0,0,800,500,20,20);
			bgRound.graphics.endFill();
			addChild(bgRound);
			
			var ver:TextField = new TextField();
			ver.textColor = 0xFFFFFF;
			ver.text = 'ver: 0.2';
			ver.x = 760;
			addChild(ver);
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		protected function onAddedToStage(event:Event):void
		{
			// TODO Auto-generated method stub			
			connectToFacebook();
			slidingpuzzle = new SlidingPuzzle();
			addChild(slidingpuzzle);
			
			
			
			//place buttons
			startBt = new Bt_start();
			resetBt = new Bt_reset();
			inviteBt = new Bt_invite();
			postBt = new Bt_postStory();
			
			startBt.x = resetBt.x = inviteBt.x = postBt.x = 680;
			startBt.y = 50;
			resetBt.y = 100;
			inviteBt.y = 150;
			postBt.y = 200;
			
			addChild(startBt);
			addChild(resetBt);
			addChild(inviteBt);
			addChild(postBt);
			
			/////buttons listeners
			startBt.addEventListener(MouseEvent.MOUSE_UP, onButtonClick);
			
			
			slidingpuzzle.startSlidingPuzzle();
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.currentTarget)
			{
				case startBt:
					//on Start button pressed
					break;
				case resetBt:
					//on reset button pressed
					break;
				case inviteBt:
					//on invite button pressed
					MonsterDebugger.trace(this,'invite button pressed');
					var dat:Object = new Object();
					dat.message = 'Hi, Play puzz puzz game';
					dat.title = 'Puzz Puzz Game';
					dat.filters = 'app_non_users';
					Facebook.ui('apprequest',dat,onappRequest);
					break;
				case postBt:
					//on post button pressed
					break;
			}
		}
		
		private function onappRequest(result:Object):void
		{
			// TODO Auto Generated method stub
			MonsterDebugger.trace(this,result.to.length);
		}
		
		private function connectToFacebook():void
		{
			// TODO Auto Generated method stub
			Facebook.init('212685678892431',onFBinit);
		}
		
		private function onFBinit(success:Object, fail:Object):void
		{
			// TODO Auto Generated method stub
			MonsterDebugger.trace(this, "onFBinit call");
			if(success) MonsterDebugger.trace(this, "user not logged in");
			if(fail) MonsterDebugger.trace(this, "user logged in");
			else MonsterDebugger.trace(this, 'there is a problem');
		}
	}
}