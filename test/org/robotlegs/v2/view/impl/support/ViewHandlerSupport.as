//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.view.impl.support
{
	import flash.display.DisplayObject;
	import org.robotlegs.v2.view.api.IViewClassInfo;
	import org.robotlegs.v2.view.api.IViewHandler;

	public class ViewHandlerSupport implements IViewHandler
	{

		/*============================================================================*/
		/* Public Static Properties                                                   */
		/*============================================================================*/

		public static const INTEREST_0:uint = 0x000000; // illegal

		public static const INTEREST_1:uint = 0x000001;

		public static const INTEREST_2:uint = 0x000004;

		public static const INTEREST_3:uint = 0x000010;

		public static const INTEREST_4:uint = 0x000040;

		public static const INTEREST_5:uint = 0x000100;

		public static const INTEREST_6:uint = 0x000400;

		public static const INTEREST_7:uint = 0x001000;

		public static const INTEREST_8:uint = 0x004000;


		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		protected var _interests:uint;

		public function get interests():uint
		{
			return _interests;
		}

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _addedHandler:Function;

		protected var _blocking:Boolean;

		protected var _interestsToActuallyHandle:uint;

		protected var _removedHandler:Function;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function ViewHandlerSupport(
			interests:uint,
			interestsToActuallyHandle:uint,
			blocking:Boolean,
			addedHandler:Function,
			removedHandler:Function = null)
		{
			_interests = interests;
			_interestsToActuallyHandle = interestsToActuallyHandle;
			_blocking = blocking;
			_addedHandler = addedHandler;
			_removedHandler = removedHandler;
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function handleViewAdded(view:DisplayObject, info:IViewClassInfo):uint
		{
			var response:uint = _interestsToActuallyHandle;

			if (_blocking)
				response |= _interestsToActuallyHandle << 1;

			_addedHandler(view, info, response);

			return response;
		}

		public function handleViewRemoved(view:DisplayObject):void
		{
			_removedHandler(view);
		}
	}
}
