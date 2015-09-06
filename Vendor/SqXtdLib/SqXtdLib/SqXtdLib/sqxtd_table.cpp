//
//  sqxtd_table.cpp
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

#include "sqxtd_table.h"
#include "sqxtd_string.h"

namespace sqxtd { namespace native { namespace table {
    SQRESULT tostring(HSQUIRRELVM vm) {
        sqxtd::string result("{\n");
        
        sq_pushnull(vm);
        
        while(SQ_SUCCEEDED(sq_next(vm, -2)))
        {
            static const SQInteger key_index = -2;
            static const SQInteger value_index = -1;
            
            auto key_value = sqxtd::format_key_value_at(vm, key_index, value_index);
            
            result += sqxtd::indent_string(key_value);
            result += "\n";
            
            sq_pop(vm,2);
        }
        
        result += "}";
        
        push_string(vm, result);
        return 1;
    }
}}}