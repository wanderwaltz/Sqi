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
#include "sqxtd_object.hpp"

struct SQObjectPtr;

namespace sqxtd {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - string
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class string {
    public:
        string(HSQUIRRELVM &vm, SQString *string) : _vm(vm), _string(string) {}
        
        string(HSQUIRRELVM &vm, const native_string &string) :
            _vm(vm), _string(SQString::Create(vm->_sharedstate, string.c_str())) {}
        
        inline const native_string tostring() const {
            return native_string(_string->_val, _string->_len);
        }
        
        inline operator SQObjectPtr() const {
            return SQObjectPtr{_string};
        }
        
        inline operator object() const {
            return object{_vm, SQObjectPtr{_string}};
        }
        
        inline void push() const {
            sq_pushobject(_vm, SQObjectPtr{_string});
        }
        
    private:
        HSQUIRRELVM &_vm;
        SQString *_string;
    };
    
    
    inline object::operator string() const {
        if (type() != OT_STRING) {
            throw object::invalid_cast{};
        }
        
        return string{_vm, _string(_value)};
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - quoted
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class quoted {
    public:
        quoted(const object &obj) : _obj(obj) {}
        
        const native_string tostring() const {
            if (_obj.type() == OT_STRING) {
                return native_string{"\""} + _obj.tostring() + native_string{"\""};
            }
            else {
                return _obj.tostring();
            }
        }
    private:
        const object &_obj;
    };
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - functions
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /** Pushes the given sqxtd::string as a Squirrel string
     */
    void push_string(HSQUIRRELVM vm, const native_string &s);
    
    
    /** Indents each line of the given std::string with a number of whitespace characters specified
     *  in the second parameter. Useful when printing tostring() representations of objects which
     *  contain other objects (tables, arrays, etc.)
     */
    const native_string indent_string(const native_string &string, const SQChar *with = "\t");
    
    
    /** Formats the two given strings as a single 'key = value' string.
     */
    const native_string format_key_value(const native_string &key, const native_string &value);
}

#endif // #ifdef __cplusplus
#endif // #ifndef __SqXtdLib__sqxtd_string__
