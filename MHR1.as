/***********************************************************
 * Class name: MHR1 Class
 * Version:    1.1 
 * Metatip:    Mohammad's Hashing Routine 1
 *
 * Author:     Mohammad Shams Javi
 * Website:    http://www.mshams.ir
 * Contact:    info@mshams.ir
 *
 * Description:
 *    This is a fast, simple 128-bit (32-digit hexadecimal number) hash routine.
 * 
 * 
 * Usage:
 *    import classes.mshams.MHR1;
 * 	  trace(new MHR1("Your String1 Here..."));
 *    trace(new MHR1("Your String2 Here..."));
 *
 *    var myHash: MHR1 = new MHR1();
 *    trace(myHash.getHash("Your String1 Here..."));
 *    trace(myHash.getHash("Your String2 Here..."));
 *
 ***********************************************************
 ****************** BEGIN LICENSE BLOCK ********************
 *                 
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is MHR1 Class
 *
 * The Initial Developer of the Original Code is
 * Mohammad Shams Javi
 *
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 ****************** END LICENSE BLOCK **********************
 Updates
 ***********************************************************
 * Date:       2010/09/14
 * Author:     Mohammad Shams Javi
 * Version:    1.1
 * Update:     Overflow bug in temp array fixed.
 ***********************************************************/



package classes.mshams{

	public class MHR1 {
		
		private var _outHash:String = "";

		public function MHR1(input:String = null) {
			// constructor code
			if (input != null)
				_outHash = getHash(input);
		}


		public function getHash(input:String):String {
			var magicNums:Array = new Array(1073676287,2719025332,3429132025,1971238619,3760598361,2065482987,5463458053,3367900313,
			      							5915587277,1500450271,3267000013,5754853343,4093082899,9576890767,3628273133,2860486313);
			
			var temp:Array = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
			var tmpHash:String = "";
			var circle:uint = 1;

			for (var i:uint = 0; i < input.length-1; i++) {
				for (var j:uint = 0; j < magicNums.length; j++) {
					temp[j] = (temp[j] + ( magicNums[j]/ ( (input.charCodeAt(i) + 1 ) ^ (i%j) + j ) )   ) ;//% magicNums[j];
				}
			}

			i = input.length - 1;
			_outHash = "";

			for (j = 0; j < magicNums.length; j++) {
				
				temp[j] = (temp[j] + Math.floor( magicNums[j]/ ( (input.charCodeAt(i) + 1 ) ^ (i%j) + j ) )    ) ;//% magicNums[j];
				tmpHash = temp[j].toString(16);
				tmpHash = tmpHash.substr(tmpHash.length - 4,4);
				
				_outHash +=  tmpHash.substr(circle,2);
				circle = 1 + (++circle % 2);
			}

			return _outHash;
		}


		public function toString():String {
			return _outHash;
		}

	}
}