//
//  sqxtd_utils.cpp
//  SqXtdLib
//
//  Created by Egor Chiglintsev on 23.08.15.
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
#include "string.h"

#include "sqxtd_table.h"

static SQRESULT sqxtd_native_getdefaultdelegate(HSQUIRRELVM vm);

static void sqxtd_set_default_delegate_native(HSQUIRRELVM vm, SQObjectType type, const SQChar *key, SQFUNCTION func);


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_getdefaultdelegate(HSQUIRRELVM vm) {
    const SQChar *name = "getdefaultdelegate";
    
    sq_pushstring(vm, name, strlen(name));
    sq_newclosure(vm, &sqxtd_native_getdefaultdelegate, 0);
    sq_newslot(vm, -3, SQFalse);
}


void sqxtd_register_default_string_representations(HSQUIRRELVM vm) {
    sqxtd_set_default_delegate_native(vm, OT_TABLE, "_tostring", sqxtd_native_table_tostring);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static SQRESULT sqxtd_native_getdefaultdelegate(HSQUIRRELVM vm) {
    sq_getdefaultdelegate(vm, sq_gettype(vm, -1));
    return 1;
}

static void sqxtd_set_default_delegate_native(HSQUIRRELVM vm, SQObjectType type, const SQChar *key, SQFUNCTION func) {
    sq_getdefaultdelegate(vm, type);
    sq_pushstring(vm, key, strlen(key));
    sq_newclosure(vm, func, 0);
    sq_newslot(vm, -3, SQFalse);
}
