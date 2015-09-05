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
#include <vector>
#include <sstream>
#include "assert.h"

#include "sqvm.h"
#include "sqobject.h"
#include "sqstring.h"
#include "sqstate.h"
#include "sqarray.h"

#include "sqxtd_utils.h"

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
    sqxtd::set_default_delegate_native(vm, OT_STRING, kKeyComponentsSeparatedByString,
                                       &sqxtd::native::string::components_separated_by_string);
}


namespace sqxtd {
    const string tostring_at(HSQUIRRELVM vm, SQInteger idx) {
        SQObjectPtr object = stack_get(vm, idx);
        SQObjectPtr string;
        
        vm->ToString(object, string);
        
        return sqxtd::string(string._unVal.pString->_val);
    }
    
    
    const string as_string(const SQObjectPtr &object) {
        if (type(object) != OT_STRING) {
            throw StringError::InvalidSQObjectType;
        }
        
        SQString *string = _string(object);
        return sqxtd::string(string->_val, string->_len);
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
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Credit for this implementation goes to http://stackoverflow.com/a/236180/892696
    static std::vector<string> split(const string& s, const string& delim, const bool keep_empty = true) {
        std::vector<string> result;
        
        if (delim.empty()) {
            result.push_back(s);
            return result;
        }
        
        string::const_iterator substart = s.begin(), subend;
        while (true) {
            subend = search(substart, s.end(), delim.begin(), delim.end());
            string temp(substart, subend);
            
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
        static SQRESULT components_separated_by_string(HSQUIRRELVM vm) {
            SQObjectPtr selfObject = vm->GetAt(vm->_top-2);
            SQObjectPtr separatorObject = vm->GetAt(vm->_top-1);
            
            assert((type(selfObject) == OT_STRING) &&
                    "componentsSeparatedByString is expected to be used with a string receiver");
            
            if (type(selfObject) != OT_STRING) {
                vm->Raise_Error(_SC("%s is expected to be used with a string receiver"), kKeyComponentsSeparatedByString);
                return SQ_ERROR;
            }
            
            
            if (type(separatorObject) != OT_STRING) {
                vm->Raise_Error(_SC("%s expects a separator string as the parameter"), kKeyComponentsSeparatedByString);
                return SQ_ERROR;
            }
            
            SQArray *array = SQArray::Create(vm->_sharedstate, 0);
            
            auto components = split(as_string(selfObject), as_string(separatorObject));
            
            for (auto &string : components) {
                SQObjectPtr component = SQString::Create(vm->_sharedstate, string.c_str());
                array->Append(component);
            }
        
            vm->Push(array);
            
            return 1;
        }
    }}
}

