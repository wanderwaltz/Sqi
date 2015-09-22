//
//  sqxtd_types.h
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 21.09.15.
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

#ifndef SqXtdLib_sqxtd_types_h
#define SqXtdLib_sqxtd_types_h

#include "SqXtdLib.h"

#ifdef __cplusplus
#include "sqxtd_types.hpp"

#ifdef type
#undef type
#endif // #ifdef type

namespace sqxtd {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - object
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class object {
    public:
        object(HSQUIRRELVM &vm, const SQObjectPtr &value) : _vm(vm), _value(value) {};
        
        inline SQObjectType type() const {
            return _value._type;
        }
        
        inline HSQUIRRELVM &vm() const {
            return _vm;
        }
        
        inline const native_string tostring() const {
            SQObjectPtr result;
            
            _vm->ToString(_value, result);
            assert(sq_type(result) == OT_STRING);
            
            SQString *pString = result._unVal.pString;
            return native_string(pString->_val, pString->_len);
        }
        
        inline operator string() const;
        inline operator array() const;
        inline operator table() const;
        
        inline operator SQObjectPtr() const {
            return SQObjectPtr{_value};
        }
        
        inline void push() const {
            _vm->Push(_value);
        }
        
    private:
        HSQUIRRELVM &_vm;
        SQObjectPtr _value;
    };
}

#endif // #ifdef __cplusplus
#endif // #ifndef SqXtdLib_sqxtd_types_h
