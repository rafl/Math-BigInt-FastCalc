#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Math::BigInt::FastCalc		PACKAGE = Math::BigInt::FastCalc

 #############################################################################
 # 2002-08-12 0.03 Tels unreleased
 #  * is_zero/is_one/is_odd/is_even/len work now (pass v1.61 tests)
 # 2002-08-13 0.04 tels unreleased
 #  * returns no/yes for is_foo() methods to be faster

##############################################################################

SV *
_zero(class)
  SV*	class
  INIT:
    AV* a;

  CODE:
    a = newAV();
    av_push (a, newSViv( 0 ));		/* zero */
    ST(0) = newRV_noinc((SV*) a);

##############################################################################

SV *
_one(class)
  SV*	class
  INIT:
    AV* a;

  CODE:
    a = newAV();
    av_push (a, newSViv( 1 ));		/* one */
    ST(0) = newRV_noinc((SV*) a);

##############################################################################

SV *
_two(class)
  SV*	class
  INIT:
    AV* a;

  CODE:
    a = newAV();
    av_push (a, newSViv( 2 ));		/* two */
    ST(0) = newRV_noinc((SV*) a);

##############################################################################

SV *
_is_even(class, x)
  SV*	class
  SV*	x
  INIT:
    AV*	a;
    SV*	temp;

  CODE:
    a = (AV*)SvRV(x);		/* ref to aray, don't check ref */
    temp = *av_fetch(a, 0, 0);	/* fetch first element */
    ST(0) = boolSV((SvIV(temp) & 1) == 0);

##############################################################################

SV *
_is_odd(class, x)
  SV*	class
  SV*	x
  INIT:
    AV*	a;
    SV*	temp;

  CODE:
    a = (AV*)SvRV(x);		/* ref to aray, don't check ref */
    temp = *av_fetch(a, 0, 0);	/* fetch first element */
    ST(0) = boolSV((SvIV(temp) & 1) != 0);

##############################################################################

SV *
_is_one(class, x)
  SV*	class
  SV*	x
  INIT:
    AV*	a;
    SV*	temp;

  CODE:
    a = (AV*)SvRV(x);			/* ref to aray, don't check ref */
    if ( av_len(a) != 0)
      {
      ST(0) = &PL_sv_no;
      XSRETURN(1);			/* len != 1, can't be '1' */
      }
    temp = *av_fetch(a, 0, 0);	/* fetch first element */
    ST(0) = boolSV((SvIV(temp) == 1));

##############################################################################

SV *
_is_zero(class, x)
  SV*	class
  SV*	x
  INIT:
    AV*	a;
    SV*	temp;

  CODE:
    a = (AV*)SvRV(x);			/* ref to aray, don't check ref */
    if ( av_len(a) != 0)
      {
      ST(0) = &PL_sv_no;
      XSRETURN(1);			/* len != 1, can't be '0' */
      }
    temp = *av_fetch(a, 0, 0);		/* fetch first element */
    ST(0) = boolSV((SvIV(temp) == 0));


##############################################################################

SV *
_len(class,x)
  SV*	class
  SV*	x
  INIT:
    AV*	a;
    SV*	temp;
    NV	elems;
    SV*	base_len;
    STRLEN len;

  CODE:
    a = (AV*)SvRV(x);			/* ref to aray, don't check ref */
    elems = (NV) av_len(a);			/* number of elems in array */
    temp = *av_fetch(a, elems, 0);	/* fetch last element */
    SvPV(temp, len);			/* convert to string & store length */
    if ( elems != 0 )
      {
      base_len = get_sv("Math::BigInt::FastCalc::BASE_LEN", FALSE);
      len += SvIV(base_len) * elems;
      }
    ST(0) = newSViv(len);

##############################################################################

SV *
_acmp(class, cx, cy);
  SV*  class
  SV*  cx
  SV*  cy
  INIT:
    AV* array_x;
    AV* array_y;
    I32 elemsx, elemsy, diff;
    SV* tempx;
    SV* tempy;
    STRLEN lenx;
    STRLEN leny;
    NV diff_nv;
    I32 diff_str;

  CODE:
    array_x = (AV*)SvRV(cx);		/* ref to aray, don't check ref */
    array_y = (AV*)SvRV(cy);		/* ref to aray, don't check ref */
    elemsx =  av_len(array_x);
    elemsy =  av_len(array_y);
    diff = elemsx - elemsy;		/* difference */

    if (diff > 0)
      {
      ST(0) = newSViv(1);
      XSRETURN(1);
      }
    if (diff < 0)
      {
      ST(0) = newSViv(-1);
      XSRETURN(1);
      }
    /* both have same number of elements, so check length of last element
       and see if it differes */
    tempx = *av_fetch(array_x, elemsx, 0);	/* fetch last element */
    tempy = *av_fetch(array_y, elemsx, 0);	/* fetch last element */
    SvPV(tempx, lenx);			/* convert to string & store length */
    SvPV(tempy, leny);			/* convert to string & store length */
    diff_str = (I32)lenx - (I32)leny;
    if (diff_str > 0)
      {
      ST(0) = newSViv(1);
      XSRETURN(1);
      }
    if (diff_str < 0)
      {
      ST(0) = newSViv(-1);
      XSRETURN(1);
      }
    /* same number of digits, so need to make a full compare */
    while (elemsx >= 0)
      {
      tempx = *av_fetch(array_x, elemsx, 0);	/* fetch curr x element */
      tempy = *av_fetch(array_y, elemsx, 0);	/* fetch curr y element */
      diff_nv = SvNV(tempx) - SvNV(tempy);
      if (diff_nv != 0)
        {
        break; 
        }
      elemsx--;
      } 
    if (diff_nv > 0)
      {
      ST(0) = newSViv(1);
      XSRETURN(1);
      }
    if (diff_nv < 0)
      {
      ST(0) = newSViv(-1);
      XSRETURN(1);
      }
    ST(0) = newSViv(0);		/* equal */

