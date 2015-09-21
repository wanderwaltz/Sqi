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
    sqxtd::set_global_constant(vm, _SC("SQXTD_ARRAY_EXTENSION_VERSION"), _SC(SQXTD_VERSION));
    
    sqxtd::set_default_delegate_native(vm, OT_ARRAY, kKeyComponentsJoinedByString,
        &sqxtd::native::array::components_joined_by_string);
}

namespace sqxtd { namespace native { namespace array {
    SQRESULT tostring(HSQUIRRELVM vm) {
        native_string result("[");
        
        try {
            sqxtd::array array{validate<sqxtd::array>(object::from_stack(vm, -1))
                .with_error(_SC("array::tostring: invalid receiver of type `%s` "
                                "(are you calling the _tostring() metamethod on "
                                "the `array` default delegate directly?)"),
                            IdType2Name(sq_gettype(vm, -1))).value()};
            
            for (auto &object : array) {
                result += quoted(object).tostring();
                result += ", ";
            }
        } catch (TypeError) {
            return SQ_ERROR;
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
        try {
            sqxtd::array array
                {validate<sqxtd::array>(object::from_stack(vm, -2))
                    .with_error(_SC("array::%s invalid receiver of type `%s` "
                                    "(are you calling the %s function on "
                                    "the `array` default delegate directly?)"),
                                kKeyComponentsJoinedByString,
                                IdType2Name(sq_gettype(vm, -2)),
                                kKeyComponentsJoinedByString).value()};
            
            sqxtd::string joiner{validate<sqxtd::string>(object::from_stack(vm, -1))
                .with_error(_SC("array::%s invalid parameter of type `%s` (expected a `string`)"),
                            kKeyComponentsJoinedByString,
                            IdType2Name(sq_gettype(vm, -1))).value()};
            
            native_string result;
            
            auto iter = array.begin();
            auto end = array.end();
            
            while (iter != end) {
                result += (*iter).tostring();
                
                ++iter;
                
                if (iter != end) {
                    result += joiner.tostring();
                }
            }
            
            push_string(vm, result);
        } catch (TypeError) {
            return SQ_ERROR;
        }
        
        return 1;
    }
}}}