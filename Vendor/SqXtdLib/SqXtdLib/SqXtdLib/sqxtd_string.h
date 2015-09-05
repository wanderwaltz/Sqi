//
//  sqxtd_string.h
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 24.08.15.
//  Copyright (c) 2015 Egor Chiglintsev. All rights reserved.
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

#ifndef __SqXtdLib__sqxtd_string__
#define __SqXtdLib__sqxtd_string__

#include "SqXtdLib.h"


#ifdef __cplusplus
#include <string>

struct SQObjectPtr;

namespace sqxtd {
    typedef std::string string;
    
    enum class StringError {
        InvalidSQObjectType
    };
    
    /** Returns the string representation of an object at the given position in the stack.
     */
    const string tostring_at(HSQUIRRELVM vm, SQInteger idx);
    
    
    /** Returns the given object value as sqxtd::string; throws StringError::InvalidSQObjectType if
     *  the parameter is not an OT_STRING.
     */
    const string as_string(const SQObjectPtr &object);
    
    
    /** Indents each line of the given std::string with a number of whitespace characters specified
     *  in the second parameter. Useful when printing tostring() representations of objects which
     *  contain other objects (tables, arrays, etc.)
     */
    const string indent_string(const string &string, const SQChar *with = "\t");
    
    
    /** Formats the two given strings as a single 'key = value' string.
     */
    const string format_key_value(const string &key, const string &value);
    
    
    /** Returns a formatted key-value string for objects stored at the given stack positions.
     *
     *  Calls sqxtd_format_key_value internally, so the output of these two functions is identical.
     */
    const string format_key_value_at(HSQUIRRELVM vm, SQInteger keyIdx, SQInteger valueIdx);

}

#endif // #ifdef __cplusplus
#endif // #ifndef __SqXtdLib__sqxtd_string__
