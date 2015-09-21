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

#include "sqxtd_vm.hpp"
#include "sqxtd_table.h"
#include "sqxtd_string.h"
#include "sqxtd_object.hpp"
#include "sqxtd_utils.h"

namespace sqxtd { namespace native { namespace table {
    SQRESULT tostring(HSQUIRRELVM sqvm) {
        sqxtd::vm vm{sqvm};
        
        native_string result("{\n");
        
        try {
            sqxtd::table table
                {validate<sqxtd::table>(vm.stack.at(-1))
                    .with_error(_SC("table::tostring: invalid receiver of type `%s` "
                                    "(are you calling the _tostring() metamethod on "
                                    "the `table` default delegate directly?)"),
                                vm.stack.typename_at(-1)).value()};
            
            for (auto &pair : table) {
                auto key_value = format_key_value(pair.first.tostring(), quoted(pair.second).tostring());
                
                result += indent_string(key_value);
                result += "\n";
            }
        } catch (TypeError) {
            return SQ_ERROR;
        }
        
        result += "}";
        
        vm.stack.push(result);
        return 1;
    }
}}}