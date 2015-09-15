//
//  squtf8_string_length.cpp
//  SqUTF8
//
//  Created by Egor Chiglintsev on 15.09.15.
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

#include "squtf8_string.h"
#include "utf8.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace squtf8 { namespace string {
    SQInteger length(SQString *string) {
        if (string == NULL) {
            return 0;
        }
        
        auto begin = string->_val;
        auto end = begin+string->_len;
        
        return utf8::distance(begin, end);
    }
}};


namespace squtf8 { namespace native { namespace string {
    SQRESULT length(HSQUIRRELVM vm) {
        SQObjectPtr self = vm->GetAt(vm->_top-1);
        
        if (type(self) == OT_STRING) {
            sq_pushinteger(vm, squtf8::string::length(_string(self)));
        }
        else {
            sq_pushinteger(vm, sq_getsize(vm, -1));
        }
        
        return 1;
    }
}}}