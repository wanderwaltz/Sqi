//
//  sqxtd_utils.h
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 26.08.15.
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

#ifndef SqXtdLib_sqxtd_utils_h
#define SqXtdLib_sqxtd_utils_h

#include "SqXtdLib.h"

#ifdef __cplusplus

#include "sqxtd_types.hpp"
#include "sqxtd_object.hpp"

namespace sqxtd {
    
    template<typename T>
    class validate {
    public:
        validate(const object &obj) : _obj(obj) {}
        
        const validate &with_error(const SQChar *format, ...) {
            static const size_t buffer_size = 1024;
            static SQChar buffer[buffer_size];
            memset(buffer, 0, sizeof(SQChar)*buffer_size);
            
            va_list vl;
            va_start(vl, format);
            vsnprintf(buffer, buffer_size-1, format, vl);
            va_end(vl);
            
            _error = native_string{buffer};
            
            return *this;
        }
        
        T value() const {
            try {
                return static_cast<T>(_obj);
            } catch (TypeError) {
                _obj.vm()->Raise_Error(_error.c_str());
                throw;
            }
        }
    private:
        const object &_obj;
        native_string _error;
    };
    
    namespace DefaultDelegable {
        const SQUnsignedInteger Null   = OT_NULL;
        const SQUnsignedInteger Scalar = OT_INTEGER | OT_FLOAT | OT_BOOL | OT_STRING;
        const SQUnsignedInteger Array  = OT_ARRAY;
        const SQUnsignedInteger Table  = OT_TABLE;
        const SQUnsignedInteger Object = OT_CLASS | OT_INSTANCE | OT_GENERATOR |
                                         OT_CLOSURE | OT_NATIVECLOSURE | OT_THREAD | OT_WEAKREF;
        
        const SQUnsignedInteger All          = Null | Scalar | Object | Array | Table;
        const SQUnsignedInteger NonContainer = All & !Array;
    };
    
    void set_default_delegate_native(HSQUIRRELVM vm, SQUnsignedInteger typemask, const SQChar *key, SQFUNCTION func);
    void set_global_constant(HSQUIRRELVM vm, const SQChar *key, const SQChar *value);
}

#endif // #ifdef __cplusplus
#endif // #ifndef SqXtdLib_sqxtd_utils_h
