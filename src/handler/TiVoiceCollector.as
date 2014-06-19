package handler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	

	public class TiVoiceCollector extends EventDispatcher
	{
		
	
		
		
		private var m_sound:Sound;
		public static var m_SoundSwapCube:Sound;
		public static var m_SoundCubeBreak:Sound;
		public static var m_Soundopening:Sound;
		public static var m_Soundonepoint09:Sound;
		
		public function TiVoiceCollector()
		{
		}
		
		public static function fnPlaySwapCube():void
		{
			if(m_SoundSwapCube)
			{
				m_SoundSwapCube.play(0,0,new SoundTransform(1));
			}
		}
		public static function fnPlayCubeBreak():void
		{
			if(m_SoundCubeBreak)
			{
				m_SoundCubeBreak.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayOpening():void
		{
			if(m_Soundopening)
			{
				m_Soundopening.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnStopPlayOpening():void
		{
			if(m_Soundopening)
			{
				m_Soundopening.play(m_Soundopening.length);
			}
		}
		
		public static function fnPlayonepoint09():void
		{
			if(m_Soundonepoint09)
			{
				m_Soundonepoint09.play(0,0,new SoundTransform(1));
			}
		}
	}
}