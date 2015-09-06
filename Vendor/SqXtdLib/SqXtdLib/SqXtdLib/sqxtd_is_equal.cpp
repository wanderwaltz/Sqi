//
//  sqxtd_is_equal.cpp
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

#include "SqXtdLib.h"
#include "sqxtd_utils.h"
#include "sqxtd_string.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Private forwards and constants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const SQChar * const kKeyIsEqual = "isEqual";

namespace sqxtd { namespace native { namespace common {
    static SQRESULT is_equal_default(HSQUIRRELVM vm);
    static SQRESULT is_equal_array(HSQUIRRELVM vm);
    static SQRESULT is_equal_table(HSQUIRRELVM vm);
}}}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_is_equal(HSQUIRRELVM vm) {
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Null, kKeyIsEqual,
        &sqxtd::native::common::is_equal_default);
    
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Scalar, kKeyIsEqual,
        &sqxtd::native::common::is_equal_default);
    
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Object, kKeyIsEqual,
        &sqxtd::native::common::is_equal_default);
    
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Table, kKeyIsEqual,
        &sqxtd::native::common::is_equal_table);
    
    sqxtd::set_default_delegate_native(vm, sqxtd::DefaultDelegable::Array, kKeyIsEqual,
        &sqxtd::native::common::is_equal_array);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace common {
    static bool raw_equal(HSQUIRRELVM vm) {
        return (sq_cmp(vm) == 0);
    }
    
    
    static bool equal(HSQUIRRELVM vm, const SQObjectPtr &isEqualClosureKey,
                      const SQObjectPtr &lhs, const SQObjectPtr &rhs) {
        vm->Push(lhs);
        vm->Push(rhs);
        
        bool equal = raw_equal(vm);
        
        // call isEqual implementation if raw check fails
        if (equal == false) {
            SQObjectPtr isEqualClosure; isEqualClosure.Null();
            SQObjectPtr isEqualResult;  isEqualResult.Null();
            
            vm->Get(lhs, isEqualClosureKey, isEqualClosure, SQFalse, vm->_top-2);
            
            if ((type(isEqualClosure) == OT_CLOSURE) || (type(isEqualClosure) == OT_NATIVECLOSURE)) {
                vm->Call(isEqualClosure, 2, vm->_top-2, isEqualResult, SQTrue);
                
                if (type(isEqualResult) == OT_BOOL) {
                    equal = _integer(isEqualResult);
                }
            }
        }
        
        vm->Pop(2);
        return equal;
    }
    
    
    static SQRESULT result_equal(HSQUIRRELVM vm) {
        sq_pushbool(vm, SQTrue);
        return 1;
    }
    
    
    static SQRESULT result_not_equal(HSQUIRRELVM vm) {
        sq_pushbool(vm, SQFalse);
        return 1;
    }
    
    static SQRESULT is_equal_default(HSQUIRRELVM vm) {
        sq_pushbool(vm, raw_equal(vm));
        return 1;
    }
    
    
    static SQRESULT is_equal_array(HSQUIRRELVM vm) {
        if (raw_equal(vm)) {
            return result_equal(vm);
        }
        
        SQObjectPtr selfObject  = vm->GetAt(vm->_top-2);
        SQObjectPtr otherObject = vm->GetAt(vm->_top-1);
        
        // in case isEqual is called on the array default delegate directly, we'll
        // have a table as the `this` parameter instead of an array
        SQObjectPtr defaultArrayDelegate = vm->GetDefaultDelegateObject(OT_ARRAY);
        SQInteger cmpDefaultDelegate = -1;
        
        vm->ObjCmp(selfObject, defaultArrayDelegate, cmpDefaultDelegate);
        if (cmpDefaultDelegate == 0) {
            return is_equal_table(vm);
        }
        
        // in all other cases selfObject should be of array type
        assert((type(selfObject) == OT_ARRAY) && "is_equal_array is expected to be used with array receiver");
        if (type(selfObject) != OT_ARRAY) {
            return result_not_equal(vm);
        }
        
        if (type(otherObject) != OT_ARRAY) {
            return result_not_equal(vm);
        }
        
        SQArray *self = _array(selfObject);
        SQArray *other = _array(otherObject);
        
        if (self->Size() != other->Size()) {
            return result_not_equal(vm);
        }
        
        SQString *isEqualKey = SQString::Create(vm->_sharedstate, kKeyIsEqual);
        
        for (SQInteger i = 0; i < self->Size(); ++i) {
            SQObjectPtr selfElement;          selfElement.Null();
            SQObjectPtr otherElement;         otherElement.Null();
            
            self->Get(i, selfElement);
            other->Get(i, otherElement);
            
            if (equal(vm, isEqualKey, selfElement, otherElement) == false) {
                return result_not_equal(vm);
            }
        }
        
        return result_equal(vm);
    }
    
    
    static SQRESULT is_equal_table(HSQUIRRELVM vm) {
        return is_equal_default(vm);
    }
}}}