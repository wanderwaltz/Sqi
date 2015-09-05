//
//  SqXtdLib.h
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 23.08.15.
//  Copyright (c) 2015 Egor Chiglintsev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


#ifndef SqXtdLib_SqXtdLib_h
#define SqXtdLib_SqXtdLib_h

#include "squirrel.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void sqxtd_register_getdefaultdelegate(HSQUIRRELVM vm);
void sqxtd_register_default_string_representations(HSQUIRRELVM vm);
    
/** Sets up default delegate for `null` objects to allow calls, getters and setters
 *  which do nothing but return `null` back. This makes `null` instances work similar
 *  to Objective-C's `nil`.
 */
void sqxtd_register_objectivec_null(HSQUIRRELVM vm);
    

/** Adds `map` function to default delegates of all types.
 *  
 *  Usage: `x = y.map(function(y) { return ...; });`
 *
 *  Mapping a `null` value always yields `null`.
 */
void sqxtd_register_map(HSQUIRRELVM vm);
    
    
/** Adds `isEqual` function to default delegates of all types.
 *
 *  isEqual checks equality of most objects using ==, except for
 *  tables and arrays it checks that they contain the same elements.
 */
void sqxtd_register_is_equal(HSQUIRRELVM vm);
#ifdef __cplusplus
} /*extern "C"*/
#endif

#endif
