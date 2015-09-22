//
//  sqxtd_array.h
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

#ifndef __SqXtdLib__sqxtd_array__
#define __SqXtdLib__sqxtd_array__

#include "SqXtdLib.h"

#ifdef __cplusplus

#include "sqxtd_vm.hpp"
#include "sqxtd_object.hpp"

namespace sqxtd {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - array
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class array {
    public:
        array(HSQUIRRELVM &vm, SQArray *array) : _vm(vm), _array(array) {};
        array(HSQUIRRELVM &vm, SQInteger initialSize = 0) :
            _vm(vm), _array(SQArray::Create(vm->_sharedstate, initialSize)) {}
        
        
        template<typename T>
        inline void append(const T &obj) {
            _array->Append(obj);
        }
        
        inline operator SQObjectPtr() const {
            return SQObjectPtr{_array};
        }
        
        class forward_iterator;
        
        inline forward_iterator begin() const;
        inline forward_iterator end() const;
    private:
        HSQUIRRELVM &_vm;
        SQArray * const _array;
    };
    
    
    inline object::operator array() const {
        if (type() != OT_ARRAY) {
            throw object::invalid_cast{};
        }
        
        return array{_vm, _array(_value)};
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - forward_iterator
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class array::forward_iterator {
    public:
        forward_iterator(const array &arr, SQInteger index) : _array(arr), _index(index) {};
        
        inline const object operator *() {
            SQObjectPtr value;
            _array._array->Get(_index, value);
            return object{_array._vm, value};
        }
        
        forward_iterator &operator ++() {
            _index ++;
            return *this;
        }
        
        inline bool operator ==(const forward_iterator &other) const {
            return (_array._vm == other._array._vm) &&
            (_array._array == other._array._array) &&
            (_index == other._index);
        }
        
        inline bool operator !=(const forward_iterator &other) const {
            return ((*this == other) == false);
        }
        
    private:
        const sqxtd::array &_array;
        SQInteger _index;
    };
    
    
    inline array::forward_iterator array::begin() const {
        return forward_iterator{*this, 0};
    }
    
    inline array::forward_iterator array::end() const {
        return forward_iterator{*this, _array->Size()};
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - native functions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace array {
    SQRESULT tostring(HSQUIRRELVM vm);
}}}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif // #ifdef __cplusplus
#endif // #ifndef __SqXtdLib__sqxtd_array__
