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
#include "sqxtd_string.h"
#include "sqxtd_utils.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private forwards and constants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const SQChar * const kKeyComponentsJoinedByString = _SC("componentsJoinedByString");

namespace sqxtd { namespace native { namespace array {
    static SQRESULT components_joined_by_string(HSQUIRRELVM vm);
}}}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_array(HSQUIRRELVM vm) {
    sqxtd::set_default_delegate_native(vm, OT_ARRAY, kKeyComponentsJoinedByString,
        &sqxtd::native::array::components_joined_by_string);
}

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
            
            result += sqxtd::tostring(vm, value_index);
            
            if (isString) {
                result += "\"";
            }
            
            result += ", ";
            
            sq_pop(vm,2);
        }
        
        // no commas to delete for empty array
        if (result.length() > 1) {
            result.erase(result.length()-2, result.length());
        }
        
        result += "]";
        
        push_string(vm, result);
        return 1;
    }
}}}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace array {
    static SQRESULT components_joined_by_string(HSQUIRRELVM vm) {
        SQObjectPtr selfObject  = vm->GetAt(vm->_top-2);
        SQObjectPtr otherObject = vm->GetAt(vm->_top-1);
        
        assert((type(selfObject) == OT_ARRAY) && "componentsJoinedByString is expected to be used with array receiver");
        if (type(selfObject) != OT_ARRAY) {
            vm->Raise_Error(_SC("%s expected `this` of array type"), kKeyComponentsJoinedByString);
            return SQ_ERROR;
        }
        
        if (type(otherObject) != OT_STRING) {
            vm->Raise_Error(_SC("%s expected parameter of string type"), kKeyComponentsJoinedByString);
            return SQ_ERROR;
        }
        
        SQArray *self = _array(selfObject);
        auto separator = sqxtd::tostring(otherObject);
        auto result(string(""));
        
        for (SQInteger i = 0; i < self->Size(); ++i) {
            SQObjectPtr selfElement;
            self->Get(i, selfElement);
        
            auto elementString = sqxtd::tostring(vm, selfElement);
            result += elementString;
            
            if (i+1 < self->Size()) {
                result += separator;
            }
        }
        
        push_string(vm, result);
        return 1;
    }
}}}