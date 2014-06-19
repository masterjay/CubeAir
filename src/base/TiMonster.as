package base
{
	import event.TiBattleEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import spark.components.Group;
	

	public class TiMonster extends Group
	{
		public function TiMonster()
		{
		}
		private var m_mcMonster:MovieClip
		private var m_nAttackCD:int=1
		private var m_nAttackCDcount:int
		public var m_nLife:int
		private var m_nAttackValue:int
		private var m_nMonsterAttackPoint:int = 0 
		private var m_nDiePoint:int
		protected function fnInit(mc:MovieClip,nLife:int,nAttackCD:int,nAttackPoint:int,nDiePoint:int):void
		{
			m_mcMonster =mc;
			m_nAttackCD = nAttackCD  
			m_nAttackCDcount = m_nAttackCD
			m_nLife = nLife;
			m_nMonsterAttackPoint = nAttackPoint
			m_nDiePoint = nDiePoint
			fnHide();
			fnCurrentCD(m_nAttackCDcount)
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_INIT_FINISH_EVENT)
				dispatchEvent( ev);
		}
		
		private function fnHide():void
		{
			m_mcMonster.suffer.visible =false;
			m_mcMonster.attack.visible =false;
			m_mcMonster.wait.visible =false;
			m_mcMonster.die.visible = false;
			m_mcMonster.appear.visible = false;
			m_mcMonster.suffer.gotoAndStop(1);
			m_mcMonster.attack.gotoAndStop(1);
			m_mcMonster.wait.gotoAndStop(1);
			m_mcMonster.die.gotoAndStop(1);
			m_mcMonster.appear.gotoAndStop(1);
		}
		
		public function fnShowtoStage():void
		{
			m_mcMonster.appear.visible =true;
			m_mcMonster.appear.gotoAndPlay(1);
			m_mcMonster.appear.addEventListener(Event.ENTER_FRAME,fnShowtoStageFinish);
		}
		private function fnShowtoStageFinish(e:Event):void
		{
			
			if(m_mcMonster.appear.totalFrames == m_mcMonster.appear.currentFrame)
			{
				m_mcMonster.appear.removeEventListener(Event.ENTER_FRAME,fnShowtoStageFinish);
				fnWait();
			}
		}
		
		private function fnAttack():void
		{
			//if(m_bAttack)
			{
			//	m_bAttack = false
				m_mcMonster.attack.addEventListener(Event.ENTER_FRAME,fnAttackFinish);
				m_mcMonster.attack.addEventListener(Event.ENTER_FRAME,fnHitHost);
				fnHide();
				m_mcMonster.attack.visible =true;
				m_mcMonster.attack.gotoAndPlay(1);
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_EVENT)
				ev.m_eventArgs = m_nMonsterAttackPoint
					dispatchEvent(ev);
			}
		}
		
		private function fnHitHost(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.currentFrameLabel == "HIT")
			{
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT)
				dispatchEvent(ev);
			}	
		}
		
		private function fnAttackFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcMonster.attack.removeEventListener(Event.ENTER_FRAME,fnAttackFinish);
				fnWait();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT)
				dispatchEvent(ev);
				var ev2:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				ev2.fnBroadcast();
			} 
		}
		
		public function fnSufferValue(nValue:int):void
		{
			m_nAttackValue = nValue
			
		}
		
		public function fnHit():void
		{
			m_mcMonster.suffer.removeEventListener(Event.ENTER_FRAME,fnSufferFinish);
			m_mcMonster.suffer.addEventListener(Event.ENTER_FRAME,fnSufferFinish);
			fnHide();
			m_mcMonster.suffer.visible =true;
			m_mcMonster.suffer.gotoAndPlay(1);
		}
		
		private function fnSufferFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcMonster.suffer.removeEventListener(Event.ENTER_FRAME,fnSufferFinish);
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT)
				dispatchEvent(ev);
				fnWait();
			} 
		}
		
		public function fnHostAttackFinish():void
		{
			m_nLife-=m_nAttackValue
			if(m_nLife<=0)
			{
				m_nLife = 0;
				fnDie()
			}	
			else
			{
				fnCountDownAttack();
			}
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SHOW_MONSTER_LIFE_EVENT);
			dispatchEvent(ev);
		}
		
		private function fnDie():void
		{
			m_mcMonster.die.addEventListener(Event.ENTER_FRAME,fnDieFinish);
			fnHide();
			m_mcMonster.die.visible =true
			m_mcMonster.die.gotoAndPlay(1);
		}
		
		private function fnDieFinish(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip
			if(mc.totalFrames == mc.currentFrame)
			{
				m_mcMonster.die.removeEventListener(Event.ENTER_FRAME,fnDieFinish);
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_DIE_FINISH_EVENT)
				ev.m_eventArgs = m_nDiePoint
				dispatchEvent(ev);	
				var ev2:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				ev2.fnBroadcast();
			}
			
		}
		private function fnCountDownAttack():void
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
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				ev.fnBroadcast();
			}
			fnCurrentCD(m_nAttackCDcount)
		}
		
		protected function fnCurrentCD(nAttactCDcount:int):void
		{
			
		}
		
		public function fnMonsterAttactCountDownMinus():void
		{
			fnCountDownAttack();
		}
		
		private function fnWait():void
		{
			fnHide();
			m_mcMonster.wait.visible =true;
			m_mcMonster.wait.gotoAndPlay(1)
		}
	}
}