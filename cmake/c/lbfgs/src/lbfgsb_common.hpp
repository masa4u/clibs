#ifndef __LBFGSB_COMMON_HPP__
#define __LBFGSB_COMMON_HPP__

#include <iostream>
#include <stdio.h>
#include <string.h>
#include <string>

// c header file
#include "lbfgsb.h"

// for non-visual c++ compiler
#ifndef __STDC_WANT_SECURE_LIB__
 
#define sprintf_s(buf, size, fmt, ...)  sprintf(buf, fmt, ##__VA_ARGS__)
#define vsprintf_s(buf, size, fmt, ...)  vsprintf(buf, fmt, ##__VA_ARGS__)
#define strcpy_s(dst, size, src)         strcpy(dst, src)
#define scanf_s(fmt, size, ...)          scanf(fmt, ##__VA_ARGS__)
#define memmove_s(dst, size, src, count) memmove(dst, src, count)
#define gets_s(buf, size)                gets(buf)
 
#endif // __STDC_WANT_SECURE_LIB__

#if (LBFGSB_DEBUG_ENABLE && defined(_DEBUG))

#define LBFGSB_LOG(message)		    \
    do {                            \
        char _caBuffer[2014];       \
        sprintf_s(_caBuffer, sizeof(_caBuffer), "[%s:%d] %s\n", __FUNCTION__, __LINE__, message);    \
        _caBuffer[2048-1] = 0x00;   \
        fprintf(stderr, _caBuffer); \
    } while(0)

#else

#define LBFGSB_LOG(message)

#endif

/// ---------------------------------------------------------------------
/// @brief LBFGSB_REQUIRE
/// if 'cond' is not satisfied, log message
/// 
/// @param cond 
/// @param message 
/// 
/// @return 
/// ---------------------------------------------------------------------
#define LBFGSB_REQUIRE(cond, message)   \
    if(!(cond)) {                       \
        LBFGSB_LOG(message);            \
        ret = -1;                       \
		return ret;						\
    }


/// ---------------------------------------------------------------------
/// @brief str_info
/// 
/// @param info 
/// 
/// @return 
/// ---------------------------------------------------------------------
std::string str_info(const int& info);

std::ostream& operator<<(std::ostream& os, const nbd_value_type& type);

#endif	//__LBFGSB_COMMON_HPP__

