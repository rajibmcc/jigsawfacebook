package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import fbconst.FbDialogue;
	import fbconst.Fbfilters;
	import fbconst.Fbwindow;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	[SWF(frameRate="60", width="800", height="550")]
	public class jigsaw extends Sprite
	{
		protected static const APP_ID:String = '212685678892431';
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
			ver.textColor = 0xFF0000;
			ver.text = 'ver: 0.3e';
			ver.x = 20;
			addChild(ver);
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		protected function onAddedToStage(event:Event):void
		{
			// TODO Auto-generated method stub			
			connectToFacebook();			
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var dat:Object;
			switch(event.currentTarget)
			{
				case startBt:
					//on Start button pressed
					MonsterDebugger.trace(this,'start button pressed');
					break;
				case resetBt:
					//on reset button pressed
					break;
				case inviteBt:
					//on invite button pressed
					MonsterDebugger.trace(this,'invite button pressed');
					dat = new Object();
					dat.message = 'Hi, Play puzz puzz game';
					dat.title = '*** Puzz Puzz Game ***';
					dat.filters = [Fbfilters.APP_NON_USER];
					Facebook.ui(FbDialogue.APP_REQUEST,dat,onappRequest,Fbwindow.I_FRAME);
					break;
				case postBt:
					//on post button pressed
					MonsterDebugger.trace(this,'post button pressed');
					dat = new Object();
					dat.name = '^^^^^^ PUZZ PUZZ ^^^^^^';
					dat.link = 'http://www.mcc.com.bd';
					dat.caption = '***** I want to post something on my wall *****';
					Facebook.ui(FbDialogue.FEED, dat, onFeed, Fbwindow.I_FRAME);
					break;
			}
		}
		
		private function onFeed(feed:Object):void
		{
			// TODO Auto Generated method stub
			if(feed == null){
				MonsterDebugger.trace(this,'Nothing posted');
			}
			else{
				MonsterDebugger.trace(this,feed);
			}
			
		}
		
		private function onappRequest(result:Object):void
		{
			// TODO Auto Generated method stub
			if(result == null){
				MonsterDebugger.trace(this,'none selected');				
			}
			else if(result) {
				MonsterDebugger.trace(this,result.to.length);
			}
			else{
				MonsterDebugger.trace(this,'0 friend selected');
			}
		}
		
		private function connectToFacebook():void
		{
			// TODO Auto Generated method stub
			MonsterDebugger.trace(this, "connect to facebook call");
			Facebook.init(APP_ID, onInit);
		}
		
		protected function onInit(result:Object, fail:Object):void {	
			MonsterDebugger.trace(this, "onInit call");
			if (result) { //already logged in because of existing session
				MonsterDebugger.trace(this, "user logged in");
				initiateGame();
			} else {
				MonsterDebugger.trace(this, "user not logged in");
			}
		}
		
		private function initiateGame():void
		{
			// TODO Auto Generated method stub
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
			inviteBt.addEventListener(MouseEvent.MOUSE_UP, onButtonClick);	
			postBt.addEventListener(MouseEvent.MOUSE_UP, onButtonClick);
			slidingpuzzle.startSlidingPuzzle();
		}
	}
}