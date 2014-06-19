package base
{
	import event.TiBattleEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import spark.components.Group;

	public class TiHost extends Group
	{
		public function TiHost()
		{
		}
		private var m_mcHost:MovieClip=new MovieClip();
		private var m_nAttackCD:int=1
		private var m_nAttackCDcount:int
		public var m_nBlood:int
		private var m_nDefaultBlood:int
		private var m_nAttackValue:int
		protected function fnInit(mc:MovieClip,nAttackCD:int,nBlood:int):void
		{
			m_mcHost =mc;
			m_nAttackCD = nAttackCD  
			m_nAttackCDcount = m_nAttackCD
			m_nBlood = nBlood;
			m_nDefaultBlood = nBlood
			fnHide();
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_INIT_FINISH_EVENT)
			dispatchEvent( ev);
		}
		
		private function fnHide():void
		{
			m_mcHost.suffer.visible =false;
			m_mcHost.attack.visible =false;
			m_mcHost.wait.visible =false;
			m_mcHost.die.visible = false;
			m_mcHost.appear.visible = false;
			m_mcHost.suffer.gotoAndStop(1);
			m_mcHost.attack.gotoAndStop(1);
			m_mcHost.wait.gotoAndStop(1);
			m_mcHost.die.gotoAndStop(1);
			m_mcHost.appear.gotoAndStop(1);
		}
		
		public function fnShowToStage():void
		{
			m_mcHost.appear.visible =true;
			m_mcHost.appear.gotoAndPlay(1);
			m_mcHost.appear.addEventListener(Event.ENTER_FRAME,fnShowtoStageFinish);
		}
		private function fnShowtoStageFinish(e:Event):void
		{
			
			if(m_mcHost.appear.totalFrames == m_mcHost.appear.currentFrame)
			{
				m_mcHost.appear.removeEventListener(Event.ENTER_FRAME,fnShowtoStageFinish);
				fnWait();
			}
		}
		
		
		public function fnAttack():void
		{
			//if(m_bAttack)
			{
				//	m_bAttack = false
				m_mcHost.attack.addEventListener(Event.ENTER_FRAME,fnAttackFinish);
				m_mcHost.attack.addEventListener(Event.ENTER_FRAME,fnHitMonster);
				fnHide();
				m_mcHost.attack.visible =true;
				m_mcHost.attack.gotoAndPlay(1);
			}
		}
		
		private function fnHitMonster(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.currentFrameLabel == "HIT")
			{
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_HIT_MONSTER_EVENT)
				dispatchEvent(ev);
			}
		}
		
		private function fnAttackFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcHost.attack.removeEventListener(Event.ENTER_FRAME,fnAttackFinish);
				fnWait();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_ATTACT_FINISH_EVENT)
				dispatchEvent(ev);
			} 
		}
		
		public function fnSufferValue(nValue:int):void
		{
			m_nAttackValue = nValue
			
		}
		
		public function fnHit():void
		{
			m_mcHost.suffer.removeEventListener(Event.ENTER_FRAME,fnSufferFinish);
			m_mcHost.suffer.addEventListener(Event.ENTER_FRAME,fnSufferFinish);
			fnHide();
			m_mcHost.suffer.visible =true;
			m_mcHost.suffer.gotoAndPlay(1);
		}
		
		private function fnSufferFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcHost.suffer.removeEventListener(Event.ENTER_FRAME,fnSufferFinish);
				fnWait();
			
			//	var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT)
			//	dispatchEvent(ev);
			} 
		}
		
		public function fnMonsterAttackFinish():void
		{
			m_nBlood-=m_nAttackValue
			if(m_nBlood<=0)
			{
				m_nBlood = 0;
				fnDie()
			}	
			else
			{
				fnWait();
			}
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SHOW_HOST_LIFE_EVENT)
				dispatchEvent(ev);
		}
		
		private function fnDie():void
		{
			m_mcHost.die.addEventListener(Event.ENTER_FRAME,fnDieFinish);
			fnHide();
			m_mcHost.die.visible =true
			m_mcHost.die.gotoAndPlay(1);
		}
		
		private function fnDieFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcHost.die.removeEventListener(Event.ENTER_FRAME,fnDieFinish);
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_DIE_FINISH_EVENT)
				dispatchEvent(ev);	
			}
			
		}
		private function fnCountDownAttact():void
		{
			m_nAttackCDcount-- 
			if(m_nAttackCDcount == 0)
			{
				fnAttack()
				m_nAttackCDcount = m_nAttackCD
			}
			else
			{
				fnWait();
			}
		}
		
		private function fnWait():void
		{
			fnHide()
			m_mcHost.wait.visible =true;
			m_mcHost.wait.gotoAndPlay(1)
		}
		
		public function fnMonsterDieLifeHill(nPoint:int):void
		{
			m_nBlood +=nPoint
			if(m_nBlood > m_nDefaultBlood)
			{
				m_nBlood = m_nDefaultBlood
			}
		}
	}
}