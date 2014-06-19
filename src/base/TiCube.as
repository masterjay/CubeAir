package base
{
	import flash.events.MouseEvent;
	
	import spark.components.Group;

	public class TiCube extends Group
	{
		
		public static const BLUE:String="BLUE"
		public static const RED:String="RED"
		public static const GREEN:String="GREEN"
		public static const PINK:String="PINK"
		public static const YELLOW:String="YELLOW"
		public static const INVISIBLE:String="INVISIBLE"
			
		public var m_cubeColor:String; 
		public var m_cubeIndex:int; 
		public var m_MouseOver:Boolean =false;	
		public var m_MouseDown:Boolean =false;
		public var m_bRemove:Boolean =false;
		public var m_bCubeFall:Boolean = false;
		public var m_bLastCubeInArray:Boolean=false;
		public var m_bLastCubeInArrayCollection:Boolean=false;
		public var m_bGrouped:Boolean=false;
		
		public function TiCube(color:String)
		{
			m_cubeColor = color
			this.addEventListener(MouseEvent.MOUSE_DOWN,fnMouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,fnMouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,fnMouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,fnMouseOutHandler);
		}
		
		public function fnCreateCube():void
		{
			
		}
		
		public function fnMoveCube():void
		{
			
		}
		
		public function fnDeleteCube():void
		{
			
		}
		
		private function fnMouseOverHandler(e:MouseEvent):void
		{
			m_MouseOver =true
			//	trace("over")
		}
		
		private function fnMouseOutHandler(e:MouseEvent):void
		{
			m_MouseOver =false
		//	trace("out")
		}
		
		private function fnMouseUpHandler(e:MouseEvent):void
		{
			
		}
		
		private function fnMouseDownHandler(e:MouseEvent):void
		{
			m_MouseDown =true
		}
		
		public function fnPlayBreakAni():void
		{
			
		}
		
		public function fnInit():void
		{
			m_bCubeFall = false;
			m_bLastCubeInArray =false
			m_bLastCubeInArrayCollection=false;
			m_bRemove = false;
			m_bGrouped=false;
		}
	}
}