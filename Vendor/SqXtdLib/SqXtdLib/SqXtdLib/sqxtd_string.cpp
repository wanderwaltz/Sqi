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

#include "sqxtd_vm.hpp"
#include "sqxtd_string.h"
#include "sqxtd_utils.h"
#include "sqxtd_array.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private forwards and constants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const SQChar * const kKeyComponentsSeparatedByString = _SC("componentsSeparatedByString");

namespace sqxtd { namespace native { namespace  string {
    static SQRESULT components_separated_by_string(HSQUIRRELVM vm);
}}}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_string(HSQUIRRELVM vm) {
    sqxtd::set_global_constant(vm, _SC("SQXTD_STRING_EXTENSION_VERSION"), _SC(SQXTD_VERSION));
    
    sqxtd::set_default_delegate_native(vm, OT_STRING, kKeyComponentsSeparatedByString,
                                       &sqxtd::native::string::components_separated_by_string);
}


namespace sqxtd {
    void push_string(HSQUIRRELVM vm, const native_string &s) {
        sq_pushstring(vm, s.c_str(), s.length());
    }
    
    
    const native_string indent_string(const native_string &string, const SQChar *with) {
        native_string result;
        
        std::istringstream stream(string);
        native_string line;
        
        while (std::getline(stream, line)) {
            result += with;
            result += line;
            result += "\n";
        }
        
        // do not include last \n
        return result.substr(0, result.length()-1);
    }
    
    
    const native_string format_key_value(const native_string &key, const native_string &value) {
        native_string result(key);
        result += " = ";
        result += value;
        
        return result;
    }
    
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Credit for this implementation goes to http://stackoverflow.com/a/236180/892696
    static std::vector<native_string> split(const native_string& s, const native_string& delim, const bool keep_empty = true) {
        std::vector<native_string> result;
        
        if (delim.empty()) {
            result.push_back(s);
            return result;
        }
        
        native_string::const_iterator substart = s.begin(), subend;
        while (true) {
            subend = search(substart, s.end(), delim.begin(), delim.end());
            native_string temp(substart, subend);
            
            if (keep_empty || !temp.empty()) {
                result.push_back(temp);
            }
            
            if (subend == s.end()) {
                break;
            }
            
            substart = subend + delim.size();
        }
        return result;
    }
    
    
    namespace native { namespace string {
        static SQRESULT components_separated_by_string(HSQUIRRELVM sqvm) {
            sqxtd::vm vm{sqvm};
            
            try {
                sqxtd::string self
                    {validate<sqxtd::string>(vm.stack.at(-2))
                        .with_error(_SC("string::%s invalid receiver of type `%s` "
                                        "(are you calling the %s function on "
                                        "the `string` default delegate directly?)"),
                                    kKeyComponentsSeparatedByString,
                                    vm.stack.typename_at(-2),
                                    kKeyComponentsSeparatedByString).value()};
                
                sqxtd::string separator
                    {validate<sqxtd::string>(vm.stack.at(-1))
                        .with_error(_SC("string::%s invalid parameter of type `%s` (expected a `string`)"),
                                    kKeyComponentsSeparatedByString,
                                    vm.stack.typename_at(-2)).value()};
                
                auto components = split(self.tostring(), separator.tostring());
                auto array = sqxtd::array(vm);
                
                for (auto &string : components) {
                    array.append(sqxtd::string{vm, string});
                }
                
                vm.stack.push(array);
            } catch (TypeError) {
                return SQ_ERROR;
            }
            
            return 1;
        }
    }}
}

