//
//  sqxtd_array.cpp
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 05.09.15.
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

#include "sqxtd_array.h"
#include "assert.h"

#include "sqxtd_string.h"

namespace sqxtd { namespace native { namespace array {
    SQRESULT tostring(HSQUIRRELVM vm) {
        sqxtd::string result("[");
        
        sq_pushnull(vm);
        
        while(SQ_SUCCEEDED(sq_next(vm, -2)))
        {
            __unused static const SQInteger key_index = -2;
            static const SQInteger value_index = -1;
            
            bool isString = (sq_gettype(vm, value_index) == OT_STRING);
            
            if (isString) {
                result += "\"";
            }
            
            result += sqxtd::tostring_at(vm, value_index);
            
            if (isString) {
                result += "\"";
            }
            
            result += ", ";
            
            sq_pop(vm,2);
        }
        
        result.erase(result.length()-2, result.length());
        result += "]";
        
        sq_pushstring(vm, result.c_str(), result.length());
        return 1;
    }
}}}