//
//  main.m
//  Sqi
//
//  Created by Egor Chiglintsev on 10.08.15.
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


#include <stdio.h>
#include <stdarg.h>

#include "squirrel.h"
#include "sqstdblob.h"
#include "sqstdsystem.h"
#include "sqstdio.h"
#include "sqstdmath.h"
#include "sqstdstring.h"
#include "sqstdaux.h"

#include "sqratimport.h"

#include "SqXtdLib.h"

void printfunc(HSQUIRRELVM v,const SQChar *s,...)
{
    va_list vl;
    va_start(vl, s);
    vfprintf(stdout, s, vl);
    va_end(vl);
}

void errorfunc(HSQUIRRELVM v,const SQChar *s,...)
{
    va_list vl;
    va_start(vl, s);
    vfprintf(stderr, s, vl);
    va_end(vl);
}

int main(int argc, const char * argv[]) {
    if (argc != 2) {
        printf("usage: sqi filename.nut\n");
        return 0;
    }
    
    HSQUIRRELVM v;
    
    v=sq_open(1024);
    sq_setprintfunc(v,printfunc,errorfunc);
    
    sq_pushroottable(v);
    
    sqstd_register_bloblib(v);
    sqstd_register_iolib(v);
    sqstd_register_systemlib(v);
    sqstd_register_mathlib(v);
    sqstd_register_stringlib(v);
    
    sqrat_register_importlib(v);
    
    sqstd_seterrorhandlers(v);
    
    sqxtd_register_getdefaultdelegate(v);
    sqxtd_register_default_string_representations(v);
    
    sqstd_dofile(v, argv[1], SQFalse, SQTrue);
    
    sq_close(v);

    return 0;
}
