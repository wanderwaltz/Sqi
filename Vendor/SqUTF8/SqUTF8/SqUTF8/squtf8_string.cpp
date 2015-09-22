//
//  squtf8_string.cpp
//  SqUTF8
//
//  Created by Egor Chiglintsev on 15.09.15.
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

#include "squtf8_string.h"
#include "sqxtd_utils.h"
#include "sqxtd_vm.hpp"


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private forwards and constants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const SQChar * const kKeyLen = _SC("len");
static const SQChar * const kKeyAt  = _SC("at");


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void squt8_register_string(HSQUIRRELVM vm) {
    sqxtd::vm{vm}.const_table(_SC("SQUTF8_STRING_EXTENSION_VERSION")) = _SC(SQUTF8_VERSION);
    
    sqxtd::set_default_delegate_native(vm, OT_STRING, kKeyLen, &squtf8::native::string::length);
    sqxtd::set_default_delegate_native(vm, OT_STRING, kKeyAt,  &squtf8::native::string::at);
}