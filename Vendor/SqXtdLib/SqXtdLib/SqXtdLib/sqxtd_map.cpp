//
//  sqxtd_map.cpp
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 04.09.15.
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

#include "SqXtdLib.h"
#include "sqxtd_utils.h"
#include "assert.h"
#include "string.h"
#include <new>

#include "sqvm.h"
#include "sqobject.h"
#include "sqstate.h"
#include "sqarray.h"

namespace sqxtd { namespace native { namespace common {
    static SQRESULT map_null(HSQUIRRELVM vm);
    static SQRESULT map_single(HSQUIRRELVM vm);
}}}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_map(HSQUIRRELVM vm) {
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Null,   "map", &sqxtd::native::common::map_null);
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Scalar, "map", &sqxtd::native::common::map_single);
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Object, "map", &sqxtd::native::common::map_single);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace common {
    static SQRESULT map_null(HSQUIRRELVM vm) {
        sq_pushnull(vm);
        return 1;
    }
    
    
    static SQRESULT map_single(HSQUIRRELVM vm) {
        SQObjectPtr closure = vm->GetAt(vm->_top-1);
        
        if ((type(closure) != OT_CLOSURE) && (type(closure) != OT_NATIVECLOSURE)) {
            vm->Raise_ParamTypeError(1, OT_CLOSURE | OT_NATIVECLOSURE, type(closure));
            return 0;
        }
        
        SQObjectPtr result;
        result.Null();
        
        sq_push(vm, -2); // push self as implicit `this`
        sq_push(vm, -3); // push self as parameter
        vm->Call(closure, 2, vm->_top-2, result, SQTrue);
        sq_pop(vm, 1); // pop self x2
        
        vm->Push(result);
        
        return 1;
    }
}}}