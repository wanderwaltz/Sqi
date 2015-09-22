//
//  sqxtd_vm.hpp
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 22.09.15.
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

#ifndef SqXtdLib_sqxtd_vm_hpp
#define SqXtdLib_sqxtd_vm_hpp

#ifdef __cplusplus
#include "sqxtd_object.hpp"
#include "sqxtd_table.h"

namespace sqxtd {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - vm
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class vm {
    public:
        class stack {
        public:
            stack(HSQUIRRELVM &vm) : _vm(vm) {};
            
            inline void push_null() const;
            inline void push(const SQObjectPtr &obj) const;
            inline void push(const native_string &string) const;
            inline object at(SQInteger pos) const;
            inline SQObjectType type_at(SQInteger pos) const;
            inline const SQChar *typename_at(SQInteger pos) const;
            
            class preserve_top;
        private:
            HSQUIRRELVM &_vm;
        };
        
        const class stack stack;
        
        vm(HSQUIRRELVM &vm) : _vm(vm), stack(vm) {}
        
        inline operator HSQUIRRELVM &() {
            return _vm;
        }
        
        inline table const_table() const;
        
        template<typename T>
        inline table::slot const_table(T key) const;
        
        inline table root_table() const;
    private:
        HSQUIRRELVM _vm;
    };
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - stack
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    inline void vm::stack::push_null() const {
        sq_pushnull(_vm);
    }
    
    inline void vm::stack::push(const SQObjectPtr &obj) const {
        sq_pushobject(_vm, obj);
    }
    
    inline void vm::stack::push(const native_string &s) const {
        sq_pushstring(_vm, s.c_str(), s.length());
    }
    
    inline object vm::stack::at(SQInteger pos) const {
        return object{_vm, stack_get(_vm, pos)};
    }
    
    inline SQObjectType vm::stack::type_at(SQInteger pos) const {
        return sq_gettype(_vm, pos);
    }
    
    inline const SQChar *vm::stack::typename_at(SQInteger pos) const {
        return IdType2Name(type_at(pos));
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - stack::preserve_top
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class vm::stack::preserve_top {
    public:
        preserve_top(const HSQUIRRELVM &vm) : _vm(vm), _top(sq_gettop(vm)) {};
        ~preserve_top() {
            sq_settop(_vm, _top);
        }
    private:
        const HSQUIRRELVM _vm;
        const SQInteger _top;
    };
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - vm methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    inline table vm::root_table() const {
        stack::preserve_top pt{_vm};
        sq_pushroottable(_vm);
        return stack.at(-1);
    }
    
    inline table vm::const_table() const {
        stack::preserve_top pt{_vm};
        sq_pushconsttable(_vm);
        return stack.at(-1);
    }
    
    template<typename T>
    inline table::slot vm::const_table(T key) const {
        return const_table()[key];
    }
}


#endif // #ifdef __cplusplus
#endif // #ifndef SqXtdLib_sqxtd_vm_hpp
