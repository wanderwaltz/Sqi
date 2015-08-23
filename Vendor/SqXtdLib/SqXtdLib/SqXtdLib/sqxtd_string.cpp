//
//  sqxtd_string.cpp
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

#include "sqxtd_string.h"
#include <string>
#include <sstream>
#include "assert.h"

#include "sqvm.h"
#include "sqobject.h"
#include "sqstring.h"

namespace sqxtd {
    const string tostring_at(HSQUIRRELVM vm, SQInteger idx) {
        SQObjectPtr object = stack_get(vm, idx);
        SQObjectPtr string;
        
        vm->ToString(object, string);
        
        return sqxtd::string(string._unVal.pString->_val);
    }
    
    
    const string indent_string(const string &string, const SQChar *with) {
        std::string result;
        
        std::istringstream stream(string);
        std::string line;
        
        while (std::getline(stream, line)) {
            result += with;
            result += line;
            result += "\n";
        }
        
        // do not include last \n
        return result.substr(0, result.length()-1);
    }
    
    
    const string format_key_value(const string &key, const string &value) {
        std::string result(key);
        result += " = ";
        result += value;
        
        return result;
    }
    
    
    const string format_key_value_at(HSQUIRRELVM vm, SQInteger keyIdx, SQInteger valueIdx) {
        auto key(tostring_at(vm, keyIdx));
        auto value(tostring_at(vm, valueIdx));
        
        return format_key_value(key, value).c_str();
    }
    
}

