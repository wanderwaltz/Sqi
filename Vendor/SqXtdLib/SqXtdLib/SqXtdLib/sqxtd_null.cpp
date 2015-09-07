//
//  sqxtd_null.cpp
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

#include "SqXtdLib.h"
#include "sqxtd_utils.h"

namespace sqxtd { namespace native { namespace null {
    static SQRESULT default_metamethod(HSQUIRRELVM vm);
}}}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void sqxtd_register_objectivec_null(HSQUIRRELVM vm) {
    sqxtd::set_global_constant(vm, _SC("SQXTD_NULL_EXTENSION_VERSION"), _SC(SQXTD_VERSION));
    
    sqxtd::set_default_delegate_native(vm, OT_NULL, "_call", &sqxtd::native::null::default_metamethod);
    sqxtd::set_default_delegate_native(vm, OT_NULL, "_get", &sqxtd::native::null::default_metamethod);
    sqxtd::set_default_delegate_native(vm, OT_NULL, "_set", &sqxtd::native::null::default_metamethod);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace sqxtd { namespace native { namespace null {
    static SQRESULT default_metamethod(HSQUIRRELVM vm) {
        sq_pushnull(vm);
        return 1;
    }
}}}
