package event
{
	import flash.events.Event;

	public class TiMonsterEvent extends Event
	{
		public static const MONSTER_ATTACT_FINISH_EVENT:String="MONSTER_ATTACT_FINISH_EVENT"
		public static const MONSTER_ATTACT_EVENT:String="MONSTER_ATTACT_EVENT"
		public static const MONSTER_SUFFER_FINISH_EVENT:String="MONSTER_SUFFER_FINISH_EVENT"
		public static const MONSTER_DIE_FINISH_EVENT:String="MONSTER_DIE_FINISH_EVENT"
	
		public function TiMonsterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}