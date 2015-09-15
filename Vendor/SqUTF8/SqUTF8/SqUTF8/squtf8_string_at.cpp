//
//  squtf8_string_at.cpp
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
#include "utf8.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace squtf8 { namespace native { namespace string {
    SQRESULT at(HSQUIRRELVM vm) {
        SQObjectPtr self = vm->GetAt(vm->_top-2);
        
        if (type(self) == OT_STRING) {
            SQString *selfString = _string(self);
            SQInteger index = selfString->_len;
            
            sq_getinteger(vm, -1, &index);
            
            auto begin = selfString->_val;
            auto end = begin+selfString->_len;
            
            try {
                SQChar *from = NULL;
                
                
                if (index >= 0) {
                    from = begin; utf8::advance(from, index, end);
                    
                }
                else {
                    from = end;
                    
                    for (auto i = index; i < 0; ++i) {
                        utf8::prior(from, begin);
                    }
                }
                
                auto to = from; utf8::advance(to, 1, end);
                
                SQInteger resultLen = to-from;
                assert((resultLen >= 0) && "Length of the resulting string should not be negative");
                
                if (resultLen < 0) {
                    sq_pushnull(vm);
                    return 1;
                }
                
                SQChar *resultSequence = vm->_sharedstate->GetScratchPad(resultLen+1);
                
                memset(resultSequence, 0, (resultLen+1)*sizeof(SQChar));
                memcpy(resultSequence, from, resultLen*sizeof(SQChar));
                
                SQString *result = SQString::Create(vm->_sharedstate, resultSequence);
                
                vm->Push(result);
            } catch (...) {
                sq_pushnull(vm);
            }
        }
        else {
            vm->Raise_Error("string::at - Invalid receiver of type %s", GetTypeName(self));
            return SQ_ERROR;
        }
        
        return 1;
    }
}}}
