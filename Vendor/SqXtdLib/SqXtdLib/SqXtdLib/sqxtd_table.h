//
//  sqxtd_table.h
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

#ifndef __SqXtdLib__sqxtd_table__
#define __SqXtdLib__sqxtd_table__

#include "SqXtdLib.h"

#ifdef __cplusplus

#include "sqxtd_object.hpp"

namespace sqxtd {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - table
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class table {
    public:
        table(HSQUIRRELVM &vm, SQTable *table) : _vm(vm), _table(table) {}
        
        class iterator;
        
        inline iterator begin() const;
        inline iterator end() const;
    private:
        HSQUIRRELVM &_vm;
        SQTable * const _table;
    };
    
    
    inline object::operator table() const {
        if (type() != OT_TABLE) {
            throw TypeError::InvalidCast;
        }
        
        return table{_vm, _table(_value)};
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - iterator
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    class table::iterator {
    public:
        iterator(const table &tbl, SQInteger refpos) : _table(tbl), _refpos(refpos) {
            next();
        };
        
        inline const std::pair<object, object> operator *() {
            return {object{_table._vm, _key}, object{_table._vm, _value}};
        }
        
        iterator &operator ++() {
            next();
            return *this;
        }
        
        inline bool operator ==(const iterator &other) const {
            return (_table._vm == other._table._vm) &&
                   (_table._table == other._table._table) &&
                   (_refpos == other._refpos);
        }
        
        inline bool operator !=(const iterator &other) const {
            return ((*this == other) == false);
        }
        
    private:
        inline void next() {
            if (_refpos != -1) {
                _refpos = _table._table->Next(false, _refpos, _key, _value);
            }
        }
        
        const sqxtd::table &_table;
        SQInteger _refpos;
        SQObjectPtr _key;
        SQObjectPtr _value;
    };
    
    
    inline table::iterator table::begin() const {
        return iterator{*this, 0};
    }
    
    inline table::iterator table::end() const {
        return iterator{*this, -1};
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - native functions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace table {
    SQRESULT tostring(HSQUIRRELVM vm);
}}}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif // #ifdef __cplusplus
#endif // #ifndef __SqXtdLib__sqxtd_table__
