#pragma once
#define _USE_32BIT_TIME_T

#include <cstdio>
#include <ctime>

#include <iostream>
#include <string>

#include <set>
#include <map>
#include <list>

#include "lzo.h"
#ifdef NDEBUG
#pragma comment(lib, "lzo_release.lib")
#else
#pragma comment(lib, "lzo_debug.lib")
#endif

#include "Singleton.h"

#include "../../../Client/GameLib/StdAfx.h"
#include "../../../Client/GameLib/ItemData.h"

#include "../../../Client/UserInterface/StdAfx.h"
#include "../../../Client/UserInterface/PythonNonPlayer.h"

#define strncpy(a,b,c) strncpy_s(a,c,b,_TRUNCATE)
#define _snprintf(a,b,c,...) _snprintf_s(a,b,_TRUNCATE,c,__VA_ARGS__)
inline bool operator<(const CItemData::TItemTable& lhs, const CItemData::TItemTable& rhs)
{
	return lhs.dwVnum < rhs.dwVnum;
}

#include <algorithm>

//������exe���� ����鼭 ���� �߰� : ���� �о�� �� �ֵ��� �Ͽ���.
#include "CsvFile.h"
#include "ItemCSVReader.h"

#ifdef NDEBUG
#pragma comment(lib, "lzo_release.lib")
#else
#pragma comment(lib, "lzo_debug.lib")
#endif
#define ENABLE_ADDONTYPE_AUTODETECT
