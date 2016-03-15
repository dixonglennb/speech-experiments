\ Basic Component Object
\ Glenn and Tom Dixon  dixong@iomega.com 


library OLE32.DLL

1 import: CoInitialize
5 import: CoCreateInstance
6 import: MultiByteToWideChar
2 import: StringFromCLSID
2 import: CLSIDFromString
2 import: IIDFromString

PACKAGE OOP

: interface-call ( n1 n2 n3 ... nx x b a )
  swap over @ @ swap cells + @ >r @ over -roll r> pascal-call ;

: RUN-INTERFACE ( object 'data -- )
  2@ rot interface-call 0 >this ;
\  2@ cells 2 pick @ @ + @ >r dup rot @ swap -roll r> pascal-call 0 >this ;

: COMPILE-INTERFACE ( 'data -- )
  "self" POSTPONE @ POSTPONE dup
  dup 4 + @ POSTPONE literal POSTPONE -roll
  dup 4 + @ POSTPONE literal
   POSTPONE swap POSTPONE @
  @ POSTPONE literal 4 POSTPONE literal POSTPONE * POSTPONE +
  POSTPONE @ POSTPONE Pascal-call
  END-REFERENCE ;

GET-CURRENT CC-WORDS SET-CURRENT

: INTERFACE ( n n -- ) \ first n is #arguments including object,
                       \ second is order in COM calling list.
  MEMBER swap ['] RUN-INTERFACE ['] COMPILE-INTERFACE NEW-MEMBER
  , 8 THIS >size +! ;

SET-CURRENT

END-PACKAGE

create unidata 1024 256 + allot
variable unihead

: unipad ( -- addr ) unidata unihead @ 1024 mod + ;

: >unicode ( addr len -- addr len )
   256 unihead +! 0 MB_PRECOMPOSED 2swap unipad 4 + 256 MultiByteToWideChar
  dup 2 * unipad ! unipad 4 + swap 2 *  ;

\ notice that unicode strings have a whole cell for the count

: UniPlace ( addr len destaddr -- ) 2dup ! 4 + swap cmove ;
: UniAppend ( addr len destaddr -- )
  2dup @ + >r dup >r dup @ + 4 + swap cmove r> r> swap ! ;
: UniCount ( addr -- addr len ) dup 4 + swap @ ;
: UniType ( addr len -- ) 2/ 0 do dup i 2 * + h@ emit loop drop ;

: (u") r> UniCount 2dup + 2 + >r ;

: Ustr, ( addr n -- )
   R-BUF  R@ uniPLACE
   R> HERE OVER @ 4 +  DUP /ALLOT  CMOVE 0 h, ALIGN ;


: U" STATE @ IF  POSTPONE (U") ascii " word count >unicode ustr,
   EXIT  THEN  ascii " PARSE  >unicode ;  IMMEDIATE

 : hatoi number? if else 0 then  ;

 : Create-Guid ( -- )
    Create Base @ HEX   BL WORD Count dup 38 <> abort" Invalid Guid LEngth"
      1 /string  2dup ascii - scan 2dup >r >r nip - atoi ,
      r> r> ascii - skip 2dup ascii - scan 2dup >r >r nip - hatoi h,
      r> r> ascii - skip 2dup ascii - scan 2dup >r >r nip - hatoi h,
      r> r> ascii - skip 2dup drop 2 0 do dup i 2 * + 2 hatoi c, loop drop
      ascii - scan ascii - skip drop 6 0 do dup i 2 * + 2 hatoi c, loop drop base ! ;

CREATE-GUID IID_IUnknown      {00000000-0000-0000-C000-000000000046}
CREATE-GUID IID_IClassFactory {00000001-0000-0000-C000-000000000046}
CREATE-GUID CLSID_Forth       {80BBBE15-8733-D211-96EA-0080C883D7C7}
CREATE-GUID IID_IDispatch     {00020400-0000-0000-C000-000000000046}
CREATE-GUID IID_ITypeInfo     {00020401-0000-0000-C000-000000000046}
CREATE-GUID IID_ITypeInfo2    {00020412-0000-0000-C000-000000000046}




class COM  \ basic com object
  variable pointer
  16 buffer: guid

  : define-guid ( n h h h c c c c c -- )
    6 0 do 15 i - guid + c! loop
    3 0 do 7 i 2 * - guid + h! loop
    guid ! ;

  3 0 INTERFACE IQueryInterface ( riid ppv -- hres )
  1 1 INTERFACE IAddRef ( -- refs )
  1 2 INTERFACE IReleaseRef ( interface -- refs )
end-class

\ pre-defined data types used by COM interface descriptors:

0    constant VT_EMPTY      \ no data associated with this
1    constant VT_NULL       \ same as a regular NULL
16   constant VT_I1         \ 1 byte signed integer
17   constant VT_UI1        \ 1 byte unsigned integer
2    constant VT_I2         \ 2 bytes signed integer
18   constant VT_UI2        \ 2 bytes unsigned integer
3    constant VT_I4         \ 4 bytes signed integer
22   constant VT_INT        \ same as VT_I4 but with a different code (?? what on earth are these people thinking!!?!)
19   constant VT_UI4        \ 4 bytes unsigned integer
23   constant VT_UINT       \ same as VT_UI4 but with a different code (I can only suppose for clarity....)
20   constant VT_I8         \ 8 bytes signed integer
21   constant VT_UI8        \ 8 bytes unsigned integer
4    constant VT_R4         \ IEEE 32-bit floating-point number
5    constant VT_R8         \ IEEE 64-bit floating-point number
6    constant VT_CY         \ 8 byte two's complement integer (scaled by 10000, used for currency)
7    constant VT_DATE       \ 64-bit floating-point number representing the days since Dec. 31, 1899
8    constant VT_BSTR       \ pointer to Null-terminated unicode string--see unicode notes above
11   constant VT_BOOL       \ boolean value
10   constant VT_ERROR      \ 32-bit number containing status code
64   constant VT_FILETIME   \ 64-bit FileTime structure (see win32 api)
30   constant VT_LPSTR      \ pointer to Null-terminated ansi string
31   constant VT_LPWSTR     \ pointer to Null-terminated unicode string
72   constant VT_CLSID      \ pointer to guid (or a clsid, or what-have-you)
71   constant VT_CF         \ pointer to a clip structure
65   constant VT_BLOB       \ 32-bit count of bytes followed by that number of bytes
70   constant VT_BLOBOBJECT \ a blob containing a serialize object
66   constant VT_STREAM     \ pointer to an IStream interface
68   constant VT_STREAMED_OBJECT \ same as stream, but contains an object
67   constant VT_STORAGE    \ pointer to an IStorage interface
69   constant VT_STORED_OBJECT   \ same as storage, but contains an object
14   constant VT_DECIMAL    \ a decimal structure
$1000 constant VT_VECTOR     \ array of types, pointer to count, then pointer to the array
$2000 constant VT_ARRAY      \ pointer to safearray
$4000 constant VT_BYREF      \ value is a reference
12    constant VT_VARIANT    \ type indicator followed by corresponding value
$FFF  constant VT_TYPEMASK   \ used as a mask for vt_vector, array and what-not

class VARIANT-Head
  hvariable vt
  hvariable reserved1
  hvariable reserved2
  hvariable reserved3
end-class

class VARIANT
  hvariable vt
  hvariable reserved1
  hvariable reserved2
  hvariable reserved3
  8 buffer: data
end-class


COM Subclass ITypeInfo
  2 3  INTERFACE GetTypeAttr ( ptypeaddr -- res )
  2 4  INTERFACE GetTypeComp ( ptypecomp -- res )
  3 5  INTERFACE GetFuncDesc ( index pfuncdesc -- res )
  3 6  INTERFACE GetVarDesc ( index pvardesc -- res )
  5 7  INTERFACE GetNames ( memid bstr maxnames pcount -- res )
  3 8  INTERFACE GetRefTypeOfimpleType ( index reftype -- res )
  3 9  INTERFACE GetImplTypeFlags ( index typeflags -- res )
  4 10 INTERFACE GetIdsofnames ( names cnames memid -- res )
  8 11 INTERFACE Invoke ( inst memid flags disparams varresult exceptinfo argerr -- res )
  6 12 INTERFACE GetDocumentation ( memid bname bdoc helpcont helpfile -- res )
  6 13 INTERFACE GetDLLEntry ( memid invkind bname ordinal -- res )
  3 14 INTERFACE GetRefTypeInfo ( hreftype pinfo -- res )
  4 15 INTERFACE GetAddressOfMember ( memid invkind ppv -- res )
  4 16 INTERFACE CreateInstance ( punkouter riid pobj -- res )
  3 17 INTERFACE GetMops ( memid bmops -- res )
  3 18 INTERFACE GetContainintTypeLib ( pptlib pindex -- res )
  2 19 INTERFACE ReleaseTypeAttr ( ptypeattr -- res )
  2 20 INTERFACE ReleaseFuncDesc ( pfuncdesc -- res )
  2 21 INTERFACE ReleaseVarDesc ( pvardesc -- res )
end-class

class TypeDesc
  variable lpdesc
  variable vt
end-class

class ParamDesc
  variable lpparamdesc  \ address to a variant count and array of variants
  variable paramflags
end-class

class ElemDesc
  typedesc builds tdesc
  paramdesc builds pdesc
end-class


class FuncDesc
  variable memid                \ function member ID
  variable lprgscode
  variable lpelementdescparam
  variable Funckind             \ specifies wether the function is virtual, static, etc..
  variable InvKind              \ Kind of method, (executing vartype, etc...)
  variable callconv             \ Calling Convention, almost always a pascal-call
  hvariable cparams             \ count of parameters
  hvariable vparamsopt          \ count of optional parameters
  hvariable oVft                \ offset in the VTBL
  hvariable cScodes             \ count of permittees unsigned integer
4    constant VT_R4         \ IEEE 32-bit floating-point number
5    constant VT_R8         \ IEEE 64-bit floating-point number
6    constant VT_CY         \ 8 byte two's complement integer (scaled by 10000, used for currency)
7    constant VT_DATE       \ 64-bit floating-point number representing the days since Dec. 31, 1899
8    constant VT_BS