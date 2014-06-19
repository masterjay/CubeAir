package base
{
	import flash.display.MovieClip;
	
	import spark.components.Group;

	public class TiLife extends Group
	{
		public function TiLife()
		{
		}
		
		private var m_nAllLife:int  
		private var m_mcLife:MovieClip =new MovieClip();
		private var m_bUseQuestion:Boolean =false;
		public function fnInit(mc:MovieClip,nLife:int,bUseQuestion:Boolean):void
		{
			m_mcLife = mc
			m_nAllLife = nLife
			m_bUseQuestion = bUseQuestion
			fnScore(nLife)
			fnPercent(nLife)
			fnShowAllLife(nLife)
			m_mcLife.lifePoint.gotoAndPlay(2)
		}
		
		public function fnResetLife():void
		{
			m_mcLife.lifePoint.gotoAndStop(1);
			for( var i:int = 0 ;; i++)
			{
				if(m_mcLife["org_score"+ (i+1)])
				{
					m_mcLife["org_score"+ (i+1)].visible = true;
					m_mcLife["org_score"+ (i+1)].gotoAndStop(11)
				}
				else
				{
					break;
				}
			}
			
			for( var j:int = 0 ;; j++)
			{
				if(m_mcLife["score"+ (j+1)])
				{
					m_mcLife["score"+ (j+1)].visible = true;
					m_mcLife["score"+ (j+1)].gotoAndStop(11)
				}
				else
				{
					break;
				}
			}
		}
		
		private function fnShowAllLife(nValue:int):void
		{
			m_mcLife.gotoAndPlay(1);
			var arLife:Array = TiConvertValueToArray.fnConvertValueToArray(nValue);
			if(m_bUseQuestion)
			{
				for( var i:int = 0 ;; i++)
				{
					if(m_mcLife["org_score"+ (i+1)])
					{
						if(i<arLife.length)
						{
							m_mcLife["org_score"+ (i+1)].gotoAndStop(11);	
							m_mcLife["org_score"+ (i+1)].visible = true;
						}
						else
						{
							m_mcLife["org_score"+ (i+1)].visible = false;
						}
					}
					else
					{
						break;
					}
				}
				
			}
			else
			{
				for( var j:int = 0 ;; j++)
				{
					if(m_mcLife["org_score"+ (j+1)])
					{
						if(j<arLife.length)
						{
							m_mcLife["org_score"+ (j+1)].gotoAndStop(int(arLife[j])+1);	
							m_mcLife["org_score"+ (j+1)].visible = true;
						}
						else
						{
							m_mcLife["org_score"+ (j+1)].visible = false;
						}
					}
					else
					{
						break;
					}
				}
			}
			
		}
		
		public function fnShowLife(nValue:int):void
		{
			fnPercent(nValue)
			fnScore(nValue);
			
		}
		
		private function fnScore(nValue:int):void
		{
			m_mcLife.gotoAndPlay(1);
			var arLife:Array = TiConvertValueToArray.fnConvertValueToArray(nValue);
			arLife.reverse();
			if(m_bUseQuestion)
			{
				
				for( var i:int = 0 ;; i++)
				{
					if(m_mcLife["score"+ (i+1)])
					{
						if(i<arLife.length)
						{
							m_mcLife["score"+ (i+1)].gotoAndStop(11);	
							m_mcLife["score"+ (i+1)].visible = true;
						}
						else
						{
							m_mcLife["score"+ (i+1)].visible = false;
						}
					}
					else
					{
						break;
					}
				}
			}
			else
			{
				for( var j:int = 0 ;; j++)
				{
					if(m_mcLife["score"+ (j+1)])
					{
						if(j<arLife.length)
						{
							m_mcLife["score"+ (j+1)].gotoAndStop(int(arLife[j])+1);	
							m_mcLife["score"+ (j+1)].visible = true;
						}
						else
						{
							m_mcLife["score"+ (j+1)].visible = false;
						}
					}
					else
					{
						break;
					}
				}
			}
		}
		
		private function fnPercent(nValue:int):void
		{
			if(nValue == m_nAllLife)
			{
				m_mcLife.lifePoint.gotoAndStop(m_mcLife.lifePoint.totalFrames);
			}
			else
			{
				var strPercent:Number = (nValue/m_nAllLife)*m_mcLife.lifePoint.totalFrames;
				var strFrame:String = Math.round(strPercent).toString();
				m_mcLife.lifePoint.gotoAndStop(strFrame);
				 
				if(strPercent<15)
				{
					m_bUseQuestion =false
					fnShowAllLife(m_nAllLife)
				}
			}
			
		}
		
		
	}
}