#include "lbfgsb_common.hpp"

#include <sstream>
#include <stdio.h>


std::ostream& operator<<(std::ostream& os, const nbd_value_type& type) {
	switch(type) {
		case -2:
			os << "unknown internal error";
			break;
		case -1:
			os << "wrong parameters were specified";
			break;
		case 0:
			os << "interrupted by user";
			break;
		case 1:
			os << "relative function decreasing is less or equal to EpsF";
			break;
		case 2:
			os << "step is less or equal to EpsX";
			break;
		case 4:
			os << "gradient norm is less or equal to EpsG";
			break;
		case 5:
			os << "number of iterations exceeds MaxIts";
			break;
		default:
            os << "unknown error: info = " << (int)type;
			break;
	}
    return os;
}


std::string str_info(const int& info) {
	std::ostringstream os;
    os << (nbd_value_type)info;
	return os.str();
}


